import 'package:tmt_flutter_untils/sources/collection_util/collection_utils.dart';

extension CollectionExtensions on List {
  void replace(item, int index) {
    if (index < this.length) {
      this.insert(index, item);
      this.removeAt(this.indexOf(item) + 1);
    } else {
      throw ('Index Out Of Bounds');
    }
  }
}

extension IterableExtension<T> on Iterable<T> {
  /// Sum value from object by [pattern]

  double sumByDouble(double Function(T) pattern) {
    return ListUtils.sumBy(this, pattern);
  }

  int sum(int Function(T) pattern) {
    return ListUtils.sum(this, pattern);
  }

  int lengthOrDefault([int defaultValue = 0]) {
    return this?.length ?? 0;
  }
}
