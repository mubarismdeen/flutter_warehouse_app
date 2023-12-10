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
  bool customers = false;
  bool gratuity = false;
  String editBy = "";
  DateTime editDate = DateTime.now();
  String createBy = "";
  DateTime createDate = DateTime.now();

  UserScreens({required this.createBy});

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
    customers =  json['customers']??false;
    gratuity =  json['gratuity']??false;
    editBy = json['editBy']??"";
    editDate = DateTime.parse(json['editDate']);
    createBy = json['createBy']??"";
    createDate = DateTime.parse(json['createDate']);
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
    'customers': customers,
    'gratuity': gratuity,
    'editBy': editBy,
    'editDate': editDate.toIso8601String(),
    'createBy': createBy,
    'createDate': createDate.toIso8601String(),
  };
}
