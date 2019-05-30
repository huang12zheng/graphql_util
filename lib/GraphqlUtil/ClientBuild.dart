import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'ClientUtil.dart';

class ClientBuild {
  Link _link;
  OptimisticCache _cache;

  OptimisticCache get cache => _cache;
  Link get link => _link;
  // No Use,Since two args is need
  /* get obj => {_cache, _link};*/

  // ClientBuild setUri({@required String uri, String subscriptionUri}){
  //   _link = linkFor(uri,subscriptionUri);
  //   return this;
  // }
  ClientBuild setLink(link){
    _link = link;
    return this;
  }
  ClientBuild setNormalization(DataIdFromObject idFunc) {
    _cache = OptimisticCache(dataIdFromObject: idFunc);
    return this;
  }
/// build()
  ValueNotifier<GraphQLClient> build() => ClientUtil(this);
}