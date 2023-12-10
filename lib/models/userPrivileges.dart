class UserPrivileges {

  int id = 0;
  int userId = 0;
  String privilegeName = "";
  bool viewPrivilege = false;
  bool addPrivilege = false;
  bool editPrivilege = false;
  bool deletePrivilege = false;
  String editBy = '';
  DateTime editDate = DateTime.now();
  String createBy = '';
  DateTime createDate = DateTime.now();

  UserPrivileges({required this.userId, required this.privilegeName, required this.createBy, required this.createDate});

  UserPrivileges.fromJson(Map<String, dynamic> json) {
    id =  json['id']??"0";
    userId =  json['userId']??"0";
    privilegeName =  json['privilegeName']??"";
    viewPrivilege =  json['viewPrivilege']??false;
    addPrivilege =  json['addPrivilege']??false;
    editPrivilege =  json['editPrivilege']??false;
    deletePrivilege =  json['deletePrivilege']??false;
    editBy = json['editBy']??'';
    editDate = DateTime.parse(json['editDate']);
    createBy = json['createBy']??'';
    createDate = DateTime.parse(json['createDate']);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'privilegeName': privilegeName,
    'viewPrivilege': viewPrivilege,
    'addPrivilege': addPrivilege,
    'editPrivilege': editPrivilege,
    'deletePrivilege': deletePrivilege,
    'editBy': editBy,
    'editDate': editDate.toIso8601String(),
    'createBy': createBy,
    'createDate': createDate.toIso8601String(),
  };

}
