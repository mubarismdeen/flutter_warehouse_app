class SalaryMasterGet {
  int id = 0;
  String empCode = '';
  String name = '';
  double salary = 0;
  double nOtr = 0;
  double sOtr = 0;
  double overseas = 0;
  double anchorage = 0;
  String editBy = '';
  DateTime editDate = DateTime.now();
  String createBy = '';
  DateTime createDate = DateTime.now();

  SalaryMasterGet.fromJson(Map<String, dynamic> json) {
    id= json['id'] ?? 0;
    empCode = json['empCode']??'';
    name = json['name']??'';
    salary = json['salary']??0.0;
    nOtr = json['novt']??0.0;
    sOtr = json['sovt']??0.0;
    overseas = json['overseas']??0.0;
    anchorage = json['anchorage']??0.0;
    editBy = json['editBy']??'';
    editDate = DateTime.parse(json['editDate']);
    createBy = json['createBy']??'';
    createDate = DateTime.parse(json['createDate']);
  }
}
