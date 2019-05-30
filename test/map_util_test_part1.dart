List<String> reference(String key) {
  return <String>['cache/reference', key];
}

const String rawOperationKey = 'rawOperationKey';

final Map<String, Object> rawOperationData = <String, Object>{
  'a': <String, Object>{
    '__typename': 'A',
    '_id': 1,
    'list': <Object>[
      1,
      2,
      3,
      <String, Object>{
        '__typename': 'Item',
        '_id': 4,
        'value': 4,
      }
    ],
    'b': <String, Object>{
      '__typename': 'B',
      '_id': 5,
      'c': <String, Object>{
        '__typename': 'C',
        '_id': 6,
        'cField': 'value',
      },
      'bField': <String, Object>{'field': true}
    },
    'd': <String, Object>{
      '_id': 9,
      'dField': <String, Object>{'field': true}
    },
  },
  'aField': <String, Object>{'field': false}
};

final Map<String, Object> updatedCValue = <String, Object>{
  '__typename': 'C',
  '_id': 6,
  'new': 'field',
  'cField': 'changed value',
};

final Map<String, Object> updatedCOperationData = <String, Object>{
  'a': <String, Object>{
    '__typename': 'A',
    '_id': 1,
    'list': <Object>[
      1,
      2,
      3,
      <String, Object>{
        '__typename': 'Item',
        '_id': 4,
        'value': 4,
      }
    ],
    'b': <String, Object>{
      '__typename': 'B',
      '_id': 5,
      'c': updatedCValue,
      'bField': <String, Object>{'field': true}
    },
    'd': <String, Object>{
      '_id': 9,
      'dField': <String, Object>{'field': true}
    },
  },
  'aField': <String, Object>{'field': false}
};

final Map<String, Object> subsetAValue = <String, Object>{
  'a': <String, Object>{
    '__typename': 'A',
    '_id': 1,
    'list': <Object>[
      5,
      6,
      7,
      <String, Object>{
        '__typename': 'Item',
        '_id': 8,
        'value': 8,
      }
    ],
    'd': <String, Object>{
      '_id': 10,
    },
  },
};

final Map<String, Object> updatedSubsetOperationData = <String, Object>{
  'a': <String, Object>{
    '__typename': 'A',
    '_id': 1,
    'list': <Object>[
      5,
      6,
      7,
      <String, Object>{
        '__typename': 'Item',
        '_id': 8,
        'value': 8,
      }
    ],
    'b': <String, Object>{
      '__typename': 'B',
      '_id': 5,
      'c': updatedCValue,
      'bField': <String, Object>{'field': true}
    },
    'd': <String, Object>{
      '_id': 10,
      'dField': <String, Object>{'field': true}
    },
  },
  'aField': <String, Object>{'field': false}
};

final Map<String, Object> cyclicalOperationData = <String, Object>{
  'a': <String, Object>{
    '__typename': 'A',
    '_id': 1,
    'b': <String, Object>{
      '__typename': 'B',
      '_id': 5,
      'a': <String, Object>{
        '__typename': 'A',
        '_id': 1,
      },
    },
  },
};

final Map<String, Object> cyclicalNormalizedA = <String, Object>{
  '__typename': 'A',
  '_id': 1,
  'b': <String>['@cache/reference', 'B/5'],
};

final Map<String, Object> cyclicalNormalizedB = <String, Object>{
  '__typename': 'B',
  '_id': 5,
  'a': <String>['@cache/reference', 'A/1'],
};