class GratuityDetails {
  int id = 0;
  String empCode = '';
  String name = '';
  String servedYears = '';
  String type = '';
  String gratuityAmount = '';
  String editBy = '';
  DateTime editDate = DateTime.now();
  String createBy = '';
  DateTime createDate = DateTime.now();

  GratuityDetails({
    required this.id,
    required this.empCode,
    required this.name,
    required this.servedYears,
    required this.type,
    required this.gratuityAmount,
    required this.editBy,
    required this.editDate,
    required this.createBy,
    required this.createDate,
  });

  GratuityDetails.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    empCode = json['empCode']??'';
    name = json['name']??'';
    servedYears = json['servedYears']??'';
    type = json['type']??'';
    gratuityAmount = json['gratuityAmount']??'';
    editBy = json['editBy']??'';
    editDate = DateTime.parse(json['editDate']);
    createBy = json['createBy']??'';
    createDate = DateTime.parse(json['createDate']);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'empCode':empCode,
    'name': name,
    'servedYears': servedYears,
    'type': type,
    'gratuityAmount': gratuityAmount,
    'editBy': editBy,
    'editDate': editDate.toIso8601String(),
    'createBy': createBy,
    'createDate': createDate.toIso8601String(),
  };
}
