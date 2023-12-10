class StockDetails {
  int id = 0;
  int productCode = 0;
  String name = '';
  String type = '';
  String unit = '';
  double quantity = 0;
  double price = 0;
  double value = 0;
  double overseas = 0;
  double anchorage = 0;
  String editBy = '';
  DateTime editDate = DateTime.now();
  String createBy = '';
  DateTime createDate = DateTime.now();


  StockDetails({
    required this.productCode,
    required this.name,
    required this.type,
    required this.unit,
    required this.quantity,
    required this.price,
    required this.value
  });

  StockDetails.fromJson(Map<String, dynamic> json) {
    id= json['id'] ?? 0;
    productCode = json['empCode']??0;
    name = json['name']??'';
    quantity = json['salary']??0.0;
    price = json['novt']??0.0;
    value = json['sovt']??0.0;
    overseas = json['overseas']??0.0;
    anchorage = json['anchorage']??0.0;
    editBy = json['editBy']??'';
    editDate = DateTime.parse(json['editDate']);
    createBy = json['createBy']??'';
    createDate = DateTime.parse(json['createDate']);
  }
}
