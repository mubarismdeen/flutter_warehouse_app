class SalaryPaid {
  int id;
  String empCode;
  int type;
  double payable;
  double totalPaid;
  double due;
  String date;
  int paidBy;
  bool paid;
  DateTime paidDt;
  String editBy;
  DateTime editDate;
  String createBy;
  DateTime createDate;

  SalaryPaid(
      {required this.id,
      required this.empCode,
      required this.type,
      required this.payable,
      required this.totalPaid,
      required this.due,
      required this.date,
      required this.paidBy,
      required this.paid,
      required this.paidDt,
      required this.editBy,
      required this.editDate,
      required this.createBy,
      required this.createDate});

  Map<String, dynamic> toJson() => {
        'id': id,
        'empCode': empCode,
        'type': type,
        'payable': payable,
        'totalPaid': totalPaid,
        'due': due,
        'date': date,
        'paidBy': paidBy,
        'paid': paid,
        'paidDt': paidDt.toIso8601String(),
        'editBy': editBy,
        'editDate': editDate.toIso8601String(),
        'createBy': createBy,
        'createDate': createDate.toIso8601String(),
      };
}
