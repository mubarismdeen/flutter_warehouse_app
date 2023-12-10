class SalesDetails {
  int id = 0;
  int saleId = 0;
  String customerName = '';
  String type = '';
  String unit = '';
  double amount = 0;
  double tax = 0;
  double value = 0;
  double overseas = 0;
  double anchorage = 0;
  String editBy = '';
  DateTime editDate = DateTime.now();
  DateTime saleDt = DateTime.now();
  String createBy = '';
  DateTime createDate = DateTime.now();


  SalesDetails({
    required this.saleId,
    required this.customerName,
    required this.amount,
    required this.tax,
    required this.saleDt,
  });

  SalesDetails.fromJson(Map<String, dynamic> json) {
    id= json['id'] ?? 0;
    saleId = json['empCode']??0;
    customerName = json['name']??'';
    amount = json['salary']??0.0;
    tax = json['novt']??0.0;
    value = json['sovt']??0.0;
    overseas = json['overseas']??0.0;
    anchorage = json['anchorage']??0.0;
    editBy = json['editBy']??'';
    editDate = DateTime.parse(json['editDate']);
    createBy = json['createBy']??'';
    createDate = DateTime.parse(json['createDate']);
  }
}
