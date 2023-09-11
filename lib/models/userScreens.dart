class UserScreens {
  int id = 0;
  int userId = 0;
  bool dashboard = false;
  bool stock = false;
  bool sales = false;
  bool employees = false;
  bool attendance = false;
  bool salaryMaster = false;
  bool salaryPayout = false;
  bool leaveSalary = false;
  bool clients = false;
  bool gratuity = false;
  String editBy = '';
  DateTime editDt = DateTime.now();
  String creatBy = '';
  DateTime creatDt = DateTime.now();

  UserScreens({required this.creatBy});

  UserScreens.fromJson(Map<String, dynamic> json) {
    id =  json['id']??"0";
    userId =  json['userId']??"0";
    dashboard =  json['dashboard']??false;
    stock =  json['stock']??false;
    sales =  json['sales']??false;
    employees =  json['employees']??false;
    attendance =  json['attendance']??false;
    salaryMaster =  json['salaryMaster']??false;
    salaryPayout =  json['salaryPayout']??false;
    leaveSalary =  json['leaveSalary']??false;
    clients =  json['clients']??false;
    gratuity =  json['gratuity']??false;
    editBy = json['editBy']??'';
    editDt = DateTime.parse(json['editDate']);
    creatBy = json['createBy']??'';
    creatDt = DateTime.parse(json['createDate']);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'dashboard': dashboard,
    'stock': stock,
    'sales': sales,
    'employees': employees,
    'attendance': attendance,
    'salaryMaster': salaryMaster,
    'salaryPayout': salaryPayout,
    'leaveSalary': leaveSalary,
    'clients': clients,
    'gratuity': gratuity,
    'editBy': editBy,
    'editDt': editDt.toIso8601String(),
    'creatBy': creatBy,
    'creatDt': creatDt.toIso8601String(),
  };
}
