

import 'package:graphql_flutter/graphql_flutter.dart';

String objNormalization(Object node,String valueName) {
  // node is valild and id is exist,then, can Swith to Tag
  if (node is Map<String, Object> &&
      node.containsKey('__typename') &&
      node.containsKey(valueName)) {
    return "${node['__typename']}/${node[valueName]}";
  }
  return null;
}

DataIdFromObject getNormalizationByIdName(String _idName) {
  return (Object node) {
    return objNormalization(node,_idName);
  };
}