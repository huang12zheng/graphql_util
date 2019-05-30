import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_util/GraphqlUtil/GraphqlNormalization.dart';

import 'map_util_test_part1.dart';

const String IDNAME='_id';
void main(){
  group('Normalizes writes', () {
    final NormalizedInMemoryCache cache = getCache();
    test('.write .readDenormalize round trip', () {
      cache.write(rawOperationKey, rawOperationData);
      expect(cache.denormalizedRead(rawOperationKey), equals(rawOperationData));
    });
    test('updating nested data changes top level operation', () {
      cache.write('C/6', updatedCValue);
      expect(
        cache.denormalizedRead(rawOperationKey),
        equals(updatedCOperationData),
      );
    });
    test('updating subset query does not override superset query', () {
      cache.write('anotherUnrelatedKey', subsetAValue);
      expect(cache.read(rawOperationKey), equals(updatedSubsetOperationData));
    });
  });

  group('Normalizes writes', () {
    final NormalizedInMemoryCache cache = getCache();
    test('lazily reads cyclical references', () {
      cache.write(rawOperationKey, cyclicalOperationData);
      final LazyCacheMap a = cache.read('A/1') as LazyCacheMap;
      expect(a.data, equals(cyclicalNormalizedA));
      // final LazyCacheMap b = a['b'] as LazyCacheMap;
      // expect(b.data, equals(cyclicalNormalizedB));
    });
  });
}

getCache(){
  DataIdFromObject normalization=getNormalizationByIdName(IDNAME);
  final NormalizedInMemoryCache cache = NormalizedInMemoryCache(
    dataIdFromObject: normalization,
  );
  return cache;
}