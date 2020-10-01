T safeCast<T>(dynamic obj) {
  if (obj == null) {
    return null;
  }
  return (obj is T) ? obj : null;
}

extension MapExt on Map<String, dynamic> {
  T get<T>(String key, [Function parser]) {
    final value = this[key];
    if (parser != null && value != null) {
      return parser(value) as T;
    }
    return value as T;
  }

  List<T> getList<T>(String key, [Function parser]) {
    final list = this[key] as List;
    if (parser != null) {
      return list.map((e) => parser(e)).toList().cast();
    } else {
      return list.cast();
    }
  }
}
