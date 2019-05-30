# graphql_util

A Flutter plugin For Simple Use For GraphqlUtil
- [graphql_util](#graphqlutil)
  - [Installation](#installation)
  - [Usage](#usage)
    - [Client](#client)
    - [Query](#query)
## Installation

First depend on the library by adding this to your packages `pubspec.yaml`:

```yaml
dependencies:
  graphql_util: ^0.0.1
```

## Usage

### Client

```dart
# lib\client.dart
final String GRAPHQL_ENDPOINT = 'https://api.github.com/graphql';
final String SUBSCRIPTION_ENDPOINT = '';
// final String SUBSCRIPTION_ENDPOINT = 'ws://$host:3000/subscriptions';
const String TOKEN = "Bearer my-special-bearer-token";
/// setNormalization
const IDNAME = 'id';

/// StartWork
ClientUtil client = ClientBuild()
            .setLink(linkFor())
            .setNormalization(getNormalizationByIdName(IDNAME))
            .build();

/// Link is Heavily dependent on user Settings
// Link link = linkFor();
Link linkFor() {
  return tokenHandle();
}
```

```dart
# lib\linkFor.dart
Link linkHandle() {
  final Link httpLink = HttpLink( uri:  GRAPHQL_ENDPOINT) as Link;
  // final Link httpLink = HttpLink(
  //        uri: 'https://api.github.com/graphql', httpClient: mockHttpClient) as Link;
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
```

### Query

```dart
String str=r'''{user{_id userName}}''';
return Container(
      child: QueryStrBuilder(str,buildFunction)
);
```