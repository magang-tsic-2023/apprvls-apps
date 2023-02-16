import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

extension ToLokalTime on DateTime {
  String toLokal() {
    initializeDateFormatting();
    try {
      return DateFormat.yMMMMEEEEd('id').add_jm().format(this);
    } catch (e) {
      return '-';
    }
  }
}

extension FormatString on String {
  String checkServer() {
    if (this == "null : XMLHttpRequest error.") return 'Server Maintenance';
    return this;
  }
}
