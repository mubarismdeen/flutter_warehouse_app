class SaveEmployeeDetails {
  int id = 0;
  int empCode = 0;
  String name = '';
  String mobile1 = '';
  String mobile2 = '';
  int depId = 0;
  int statusId = 0;
  int natianalityId = 0;
  DateTime joinDt = DateTime.now();
  DateTime birthDt = DateTime.now();
  int editBy = 0;
  DateTime editDate = DateTime.now();
  int creatBy = 0;
  DateTime creatDate = DateTime.now();

  SaveEmployeeDetails({
    required this.id,
    required this.empCode,
    required this.name,
    required this.mobile1,
    required this.mobile2,
    required this.depId,
    required this.statusId,
    required this.natianalityId,
    required this.joinDt,
    required this.birthDt,
    required this.editBy,
    required this.editDate,
    required this.creatBy,
    required this.creatDate,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'empCode': empCode,
    'name': name,
    'mobile1': mobile1,
    'mobile2': mobile2,
    'depId': depId,
    'statusId': statusId,
    'natianalityId': natianalityId,
    'joinDt': joinDt.toIso8601String(),
    'birthDt': birthDt.toIso8601String(),
    'editBy': editBy,
    'editDt': editDate.toIso8601String(),
    'creatBy': creatBy,
    'creatDt': creatDate.toIso8601String(),
  };

}
