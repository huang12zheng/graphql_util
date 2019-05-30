import 'package:graphql_util/graphql_util.dart';

import 'graphql_util_test_part2.dart';

const String readRepositories = r'''
  query ReadRepositories($nRepositories: Int!) {
    viewer {
      repositories(last: $nRepositories) {
        nodes {
          __typename
          id
          name
          viewerHasStarred
        }
      }
    }
  }
''';

  const String addStar = r'''
  mutation AddStar($starrableId: ID!) {
    action: addStar(input: {starrableId: $starrableId}) {
      starrable {
        viewerHasStarred
      }
    }
  }
''';

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