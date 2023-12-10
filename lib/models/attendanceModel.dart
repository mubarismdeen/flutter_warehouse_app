import 'package:intl/intl.dart';

class AttendanceModel {
  int id;
  String empCode;
  double attendance;
  double offdays;
  double lop;
  double novt;
  double sovt;
  double overseas;
  double anchorage;
  String date;
  String editBy;
  DateTime editDate;
  String createBy;
  DateTime createDate;

  AttendanceModel({
    required this.id,
    required this.empCode,
    required this.attendance,
    required this.offdays,
    required this.lop,
    required this.novt,
    required this.sovt,
    required this.overseas,
    required this.anchorage,
    required this.date,
    required this.editBy,
    required this.editDate,
    required this.createBy,
    required this.createDate,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['empCode'] = empCode;
    data['attendance'] = attendance;
    data['offdays'] = offdays;
    data['lop'] = lop;
    data['novt'] = novt;
    data['sovt'] = sovt;
    data['overseas'] = overseas;
    data['anchorage'] = anchorage;
    data['date'] = date;
    data['editBy'] = editBy;
    data['editDate'] = DateFormat('yyyy-MM-dd HH:mm').format(editDate);
    data['createBy'] = createBy;
    data['createDate'] = DateFormat('yyyy-MM-dd HH:mm').format(createDate);
    return data;
  }
}
