import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

QueryBuilder buildWrapper(QueryBuilder buildFunction) {
  return (QueryResult result, {VoidCallback refetch,}) {
    if (result.errors != null) return Text(result.errors.toString());
    if (result.loading) return Center(child: CircularProgressIndicator());
    return buildFunction(result);
  };
}
class QueryStrBuilder extends Query {
  final String str;
  final QueryBuilder builder;
  QueryStrBuilder(this.str,this.builder):super(
    options: QueryOptions(document: str),
    builder: buildWrapper(builder),
  );
}


