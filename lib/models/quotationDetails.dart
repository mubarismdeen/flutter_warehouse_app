
class QuotationDetails {
  int id = 0;
  int customerId = 0;
  String narration = "";
  String name = "";
  String date = "";
  int invoiceNo = 0;
  int poRefNo = 0;
  int reportNo = 0;
  double invoiceAmt = 0.0;
  int poNo = 0;
  int poStatus = 0;
  int invStatus = 0;
  int type = 0;
  String dueDate = "";
  String createBy = "";
  DateTime createDate = DateTime.now();
  String editBy = "";
  DateTime editDate = DateTime.now();
  int status = 1;

  QuotationDetails({
    required this.id,
    required this.customerId,
    required this.narration,
    required this.name,
    required this.date,
    required this.invoiceNo,
    required this.poNo,
    required this.poRefNo,
    required this.reportNo,
    required this.invoiceAmt,
    required this.poStatus,
    required this.invStatus,
    required this.type,
    required this.dueDate,
    required this.createBy,
    required this.createDate,
    required this.editBy,
    required this.editDate,
  });

  QuotationDetails.toJson();

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'customerId': customerId,
        'narration': narration,
        'name': name,
        'date': date,
        'poNo' : poNo,
        'poRefNo' : poRefNo,
        'reportNo' : reportNo,
        'invoiceNo': invoiceNo,
        'invoiceAmt' : invoiceAmt,
        'poStatus': poStatus,
        'invStatus': invStatus,
        'type': type,
        'dueDate': dueDate,
        'createBy':createBy,
        'createDate':createDate.toIso8601String(),
        'editBy':editBy,
        'editDate':editDate.toIso8601String(),
        'status': status,
      };
}