import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'ClientBuild.dart';

class ClientUtil extends ValueNotifier<GraphQLClient> {
  // superClass is run before SonClass,So super can't put in {}.
  // ValueNotifier<GraphQLClient> hasn't no-arg constructor.
  // GraphQLClient(config) => ClientUtil(builder)
  ClientUtil(ClientBuild builder):super(GraphQLClient(
      cache: builder.cache,
      link: builder.link,
    ));
}

ValueNotifier<GraphQLClient> clientFor(OptimisticCache cache, Link link, ) {
  return ValueNotifier<GraphQLClient>(
    GraphQLClient(
      cache: cache,
      link: link,
    )
  );
}