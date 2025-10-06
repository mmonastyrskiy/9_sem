class CoupleMaker {
  static Map<String, dynamic> CMtoMap(Set<String> keys, Set<dynamic> vals) {
    if (keys.length != vals.length) {
      throw ArgumentError("Количество ключей должно совпадать с количеством значений.");
    }

    // Преобразуем множества в списки, чтобы обеспечить упорядоченность и возможность обхода
    final keyList = keys.toList();
    final valList = vals.toList();

    final map = <String, dynamic>{};
    for (var i = 0; i < keyList.length; i++) {
      map[keyList[i]] = valList[i];
    }

    return map;
  }
}