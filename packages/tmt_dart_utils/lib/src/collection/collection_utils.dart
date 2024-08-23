class ListUtils {
  static num sumBy<T>(Iterable<T> list, num Function(T) pattern) {
    // ArgumentError.checkNotNull(pattern, 'pattern'); done need on null safety.
    return list
        .map(pattern)
        .fold(0.0, (previousValue, element) => previousValue + element);
  }

  static int sumByInt<T>(Iterable<T> list, num Function(T) pattern) {
    // ArgumentError.checkNotNull(pattern, 'pattern');
    return list
        .map(pattern)
        .fold(0, (previousValue, element) => previousValue + (element as int));
  }

  static List quickSort(List list) {
    if (list.length <= 1) {
      return list;
    }

    var pivot = list[0];
    var less = [];
    var more = [];
    var pivotList = [];

    for (var element in list) {
      if (element.compareTo(pivot) < 0) {
        less.add(element);
      } else if (element.compareTo(pivot) > 0) {
        more.add(element);
      } else {
        pivotList.add(element);
      }
    }

    less = quickSort(less);
    more = quickSort(more);

    less.addAll(pivotList);
    less.addAll(more);
    return less;
  }

  static List<dynamic> bubbleSort(List<dynamic> list) {
    var retList = List.from(list);
    dynamic tmp;
    var swapped = false;
    do {
      swapped = false;
      for (var i = 1; i < retList.length; i++) {
        if (retList[i - 1].compareTo(retList[i]) > 0) {
          tmp = retList[i - 1];
          retList[i - 1] = retList[i];
          retList[i] = tmp;
          swapped = true;
        }
      }
    } while (swapped);

    return retList;
  }

  static List heapSort(List a) {
    var count = a.length;

    var start = (count - 2) ~/ 2;

    while (start >= 0) {
      _sink(a, start, count - 1);
      start--;
    }

    var end = count - 1;
    while (end > 0) {
      var tmp = a[end];
      a[end] = a[0];
      a[0] = tmp;

      _sink(a, 0, end - 1);

      end--;
    }
    return a;
  }

  ///
  /// Sink a element in the tree
  ///
  static void _sink(List a, int start, int end) {
    var root = start;

    while ((root * 2 + 1) <= end) {
      var child = root * 2 + 1;
      if (child + 1 <= end && a[child].compareTo(a[child + 1]) == -1) {
        child = child + 1;
      }

      if (a[root].compareTo(a[child]) == -1) {
        var tmp = a[root];
        a[root] = a[child];
        a[child] = tmp;
        root = child;
      } else {
        return;
      }
    }
  }

  /// Return length of [list] if list is not null.
  /// Return default value (Default is 0) when the [list] is null.
  /// Using for nullable List of num.
  static int getLengthOrDefault(List? list, [int defaultValue = 0]) {
    return list?.length ?? defaultValue;
  }
}
