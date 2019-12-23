import 'datetime_range_type.dart';

class DateTimeRange {
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final DateTimeRangeType type;
  DateTimeRange({this.name, this.startDate, this.endDate, this.type});

  @override
  String toString() {
    return "$name, $startDate, $endDate";
  }
}