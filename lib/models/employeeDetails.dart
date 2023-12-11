class EmployeeDetails {
  int id = 0;
  String empCode = '';
  String name = '';
  String mobile1 = '';
  String mobile2 = '';
  String department = '';
  String status = '';
  String nationality = '';
  String birthDt = '';
  String joinDt = '';
  String editBy = '';
  DateTime editDate = DateTime.now();
  String createBy = '';
  DateTime createDate = DateTime.now();

  EmployeeDetails({
    required this.id,
    required this.empCode,
    required this.name,
    required this.mobile1,
    required this.mobile2,
    required this.department,
    required this.status,
    required this.nationality,
    required this.birthDt,
    required this.joinDt,
    required this.editBy,
    required this.editDate,
    required this.createBy,
    required this.createDate,
  });

  EmployeeDetails.fromJson(Map<String, dynamic> json) {
    id = json['id']>>0;
    empCode = json['empCode']??'';
    name = json['name']??'';
    mobile1 = json['mobile1']??'';
    mobile2 = json['mobile2']??'';
    department = json['department']??'';
    status = json['status']??'';
    nationality = json['nationality']??'';
    birthDt = json['birthDt']??'';
    joinDt = json['joinDt']??'';
    editBy = json['editBy']??'';
    editDate = DateTime.parse(json['editDate']);
    createBy = json['createBy']??'';
    createDate = DateTime.parse(json['createDate']);
  }
}
