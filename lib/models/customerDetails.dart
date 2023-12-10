class CustomerDetails {
  int id = 0;
  String name = '';
  String address = '';
  String mobile1 = '';
  String mobile2 = '';
  String editBy = '';
  DateTime editDate = DateTime.now();
  String createBy = '';
  DateTime createDate = DateTime.now();
  int status = 1;

  CustomerDetails({
    required this.id,
    required this.name,
    required this.address,
    required this.mobile1,
    required this.mobile2,
    required this.editBy,
    required this.editDate,
    required this.createBy,
    required this.createDate,
  });

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    name = json['name']??'';
    address = json['address']??'';
    mobile1 = json['mobile1']??'';
    mobile2 = json['mobile2']??'';
    editBy = json['editBy']??'';
    editDate = DateTime.parse(json['editDate']);
    createBy = json['createBy']??'';
    createDate = DateTime.parse(json['createDate']);
    status = json['status']??0;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'address': address,
    'mobile1': mobile1,
    'mobile2': mobile2,
    'editBy': editBy,
    'editDate': editDate.toIso8601String(),
    'createBy': createBy,
    'createDate': createDate.toIso8601String(),
    'status': status,
  };
}
