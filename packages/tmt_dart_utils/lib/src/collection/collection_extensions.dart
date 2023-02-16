import 'collection_utils.dart';

extension CollectionExtensions on List {
  void replace(item, int index) {
    if (index < length) {
      insert(index, item);
      removeAt(indexOf(item) + 1);
    } else {
      throw ('Index Out Of Bounds');
    }
  }
}

extension IterableExtension<T> on Iterable<T> {
  /// Sum value from object by [pattern]

  num sumBy(num Function(T) pattern) {
    return ListUtils.sumBy<T>(this, pattern);
  }

  int sumByInt(int Function(T) pattern) {
    return ListUtils.sumByInt(this, pattern);
  }

  @Deprecated('Remove when update to null safety. Using length instead')
  int lengthOrDefault([int defaultValue = 0]) {
    return length;
  }
}

extension IterableNullExtension<T> on Iterable<T>? {
  @Deprecated('Remove when update to null safety. Using length instead')
  int lengthOrDefault([int defaultValue = 0]) {
    return this?.length ?? defaultValue;
  }
}
