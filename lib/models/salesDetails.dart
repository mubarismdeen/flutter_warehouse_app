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
  DateTime editDt = DateTime.now();
  DateTime saleDt = DateTime.now();
  String creatBy = '';
  DateTime creatDt = DateTime.now();


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
    editDt = DateTime.parse(json['editDt']);
    creatBy = json['creatBy']??'';
    creatDt = DateTime.parse(json['creatDt']);
  }
}
