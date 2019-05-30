import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'graphql_util_test_part1.dart';

class MockHttpClient extends Mock implements http.Client {}
MockHttpClient mockHttpClient =  MockHttpClient();

Link linkHandle() {
  // final Link httpLink = HttpLink( uri:  GRAPHQL_ENDPOINT) as Link;
  final Link httpLink = HttpLink(
          uri: 'https://api.github.com/graphql', httpClient: mockHttpClient) as Link;
  if (subscriptionIsExist()) return httpLink;
  return httpLink.concat(WebSocketLink(url: SUBSCRIPTION_ENDPOINT));
}
bool subscriptionIsExist() => SUBSCRIPTION_ENDPOINT=='' || SUBSCRIPTION_ENDPOINT == null;
/// tokenIsEmpty|tokenIsExist
/// 
/// Link(Token) is Heavily dependent on user Settings
Link tokenHandle() {
  if (tokenIsEmpty()) return linkHandle();
  return getTokenLink();
}

/// Link(Token) is Heavily dependent on user Settings
Link getTokenLink() {
  Link link=linkHandle();
  var _getToken = () async => TOKEN;
  final AuthLink authLink = AuthLink(getToken: _getToken);
  return authLink.concat(link);
}
bool tokenIsEmpty() => TOKEN=='' || TOKEN==null;