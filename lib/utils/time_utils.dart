import 'package:intl/intl.dart';

String getTimeStr(DateTime dateTime) {
  return DateFormat("dd/MM/yyyy   hh:mm:ss").format(dateTime);
}

///format(11:22:333)
String getTimeStr1(DateTime dateTime) {
  return "${twoNum(dateTime.hour)}:${twoNum(dateTime.minute)}:${twoNum(dateTime.second)}";
}

String twoNum(int num) {
  return num > 9 ? num.toString() : "0$num";
}
