import 'package:intl/intl.dart';

extension DoubleExtensions on double {
  String toStringFormat(String format) {
    return NumberFormat(format).format(this);
  }
}
