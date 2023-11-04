class UserDetails {
  int id = 0;
  int userId = 0;
  String name = '';
  String password = '';
  String empCode = '';
  String editBy = '';
  DateTime editDate = DateTime.now();
  String createBy = '';
  DateTime createDate = DateTime.now();

  UserDetails({required this.createBy, required this.empCode});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id =  json['id']??"0";
    userId =  json['userId']??"0";
    name =  json['name']??"";
    password =  json['password']??"";
    empCode =  json['empCode']??"";
    editBy = json['editBy']??'';
    editDate = DateTime.parse(json['editDate']);
    createBy = json['createBy']??'';
    createDate = DateTime.parse(json['createDate']);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userCd': userId,
    'name': name,
    'password': password,
    'empCode': empCode,
    'editBy': editBy,
    'editDate': editDate.toIso8601String(),
    'createBy': createBy,
    'createDate': createDate.toIso8601String(),
  };
}
