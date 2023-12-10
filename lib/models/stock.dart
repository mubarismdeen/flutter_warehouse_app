class Stock {
  String batchCode = '';
  String productCode = '';
  String productName = '';
  String unit = '';
  double quantity = 0;
  double unitCost = 0;
  double unitPrice = 0;
  String editBy = '';
  DateTime editDate = DateTime.now();
  String createBy = '';
  DateTime createDate = DateTime.now();
  int status = 1;

  Stock({
    required this.batchCode,
    required this.productCode,
    required this.productName,
    required this.unit,
    required this.quantity,
    required this.unitCost,
    required this.unitPrice,
    required this.editBy,
    required this.editDate,
    required this.createBy,
    required this.createDate,
  });

  Stock.fromJson(Map<String, dynamic> json) {
    batchCode = json['batchCode']??'';
    productCode = json['productCode']??'';
    productName = json['productName']??'';
    unit = json['unit']??'';
    quantity = json['quantity']??0;
    unitCost = json['unitCost']??0;
    unitPrice = json['unitPrice']??0;
    editBy = json['editBy']??'';
    editDate = DateTime.parse(json['editDate']);
    createBy = json['createBy']??'';
    createDate = DateTime.parse(json['createDate']);
    status = json['status']??0;
  }

  // Map<String, dynamic> toJson() => {
  //   'name': batchCode,
  //   'address': address,
  //   'mobile1': mobile1,
  //   'mobile2': mobile2,
  //   'editBy': editBy,
  //   'editDate': editDate.toIso8601String(),
  //   'createBy': createBy,
  //   'createDate': createDate.toIso8601String(),
  //   'status': status,
  // };
}
