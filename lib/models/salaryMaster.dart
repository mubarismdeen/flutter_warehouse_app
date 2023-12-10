class SalaryMaster {
  int id;
  String empCode;
  double salary;
  double nOtr;
  double sOtr;
  double overseas;
  double anchorage;
  String editBy;
  DateTime editDate;
  String createBy;
  DateTime createDate;
  int status = 1;

  SalaryMaster({
    required this.id,
    required this.empCode,
    required this.salary,
    required this.nOtr,
    required this.sOtr,
    required this.overseas,
    required this.anchorage,
    required this.editBy,
    required this.editDate,
    required this.createBy,
    required this.createDate,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'empCode': empCode,
    'salary': salary,
    'nOtr': nOtr,
    'sOtr': sOtr,
    'overseas': overseas,
    'anchorage': anchorage,
    'editBy': editBy,
    'editDate': editDate.toIso8601String(),
    'createBy': createBy,
    'createDate': createDate.toIso8601String(),
    'status': status,
  };
}
