import 'dart:convert';
import 'dart:io' show File, Platform;
import 'dart:typed_data' show Uint8List;

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart' show dirname, join;
import 'package:http/http.dart' as http;

import 'package:graphql_util/graphql_util.dart';

import 'graphql_util_test_part1.dart';
import 'graphql_util_test_part2.dart';

// class MockHttpClient extends Mock implements http.Client {}

// GraphQLClient graphQLClientClient;
GraphQLClient graphQLClientClient = client.value;

void main() {
   group('query', () {
      test('successful query', () async {
        final WatchQueryOptions _options = WatchQueryOptions(
          document: readRepositories,
          variables: <String, dynamic>{
            'nRepositories': 42,
          },
        );
        when(
          mockHttpClient.send(any),
        ).thenAnswer((Invocation a) async {
          const String body = '''
{
  "data": {
    "viewer": {
      "repositories": {
        "nodes": [
          {
            "__typename": "Repository",
            "id": "MDEwOlJlcG9zaXRvcnkyNDgzOTQ3NA==",
            "name": "pq",
            "viewerHasStarred": false
          },
          {
            "__typename": "Repository",
            "id": "MDEwOlJlcG9zaXRvcnkzMjkyNDQ0Mw==",
            "name": "go-evercookie",
            "viewerHasStarred": false
          },
          {
            "__typename": "Repository",
            "id": "MDEwOlJlcG9zaXRvcnkzNTA0NjgyNA==",
            "name": "watchbot",
            "viewerHasStarred": false
          }
        ]
      }
    }
  }
}
        ''';

          final List<int> bytes = utf8.encode(body);
          final Stream<List<int>> stream =
              Stream<List<int>>.fromIterable(<List<int>>[bytes]);

          final http.StreamedResponse r = http.StreamedResponse(stream, 200);

          return r;
        });
        final QueryResult r = await graphQLClientClient.query(_options);

        final http.Request capt = verify(mockHttpClient.send(captureAny))
            .captured
            .first as http.Request;
        expect(capt.method, 'post');
        expect(capt.url.toString(), 'https://api.github.com/graphql');
        expect(
          capt.headers,
          <String, String>{
            'accept': '*/*',
            'content-type': 'application/json; charset=utf-8',
            'Authorization': 'Bearer my-special-bearer-token',
          },
        );
        expect(await capt.finalize().bytesToString(),
            r'{"operationName":"ReadRepositories","variables":{"nRepositories":42},"query":"  query ReadRepositories($nRepositories: Int!) {\n    viewer {\n      repositories(last: $nRepositories) {\n        nodes {\n          __typename\n          id\n          name\n          viewerHasStarred\n        }\n      }\n    }\n  }\n"}');

        expect(r.errors, isNull);
        expect(r.data, isNotNull);
        final List<Map<String, dynamic>> nodes =
            (r.data['viewer']['repositories']['nodes'] as List<dynamic>)
                .cast<Map<String, dynamic>>();
        expect(nodes, hasLength(3));
        expect(nodes[0]['id'], 'MDEwOlJlcG9zaXRvcnkyNDgzOTQ3NA==');
        expect(nodes[1]['name'], 'go-evercookie');
        expect(nodes[2]['viewerHasStarred'], false);
        return;
      });
//    test('failed query because of network', {});
//    test('failed query because of because of error response', {});
//    test('failed query because of because of invalid response', () {
//      String responseBody =
//          '{\"message\":\"Bad credentials\",\"documentation_url\":\"https://developer.github.com/v4\"}';
//      int responseCode = 401;
//    });
//    test('partially success query with some errors', {});
    });
    
}
