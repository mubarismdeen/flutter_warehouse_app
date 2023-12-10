
class DocDetails {
  int id = 0;
  String narration = "";
  String empCode = "";
  int docid = 0;
  DateTime dueDate = DateTime.now();
  DateTime renewedDate = DateTime.now();
  String createBy = '';
  DateTime createDate = DateTime.now();
  String editBy = '';
  DateTime editDate = DateTime.now();
  int status = 1;

  DocDetails({
    required this.id,
    required this.narration,
    required this.empCode,
    required this.docid,
    required this.dueDate,
    required this.renewedDate,
    required this.createBy,
    required this.createDate,
    required this.editBy,
    required this.editDate,
  });

  DocDetails.toJson();

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'narration': narration,
        'empCode': empCode,
        'docid': docid,
        'dueDate': dueDate.toIso8601String(),
        'renewedDate':renewedDate.toIso8601String(),
        'createBy':createBy,
        'createDate':createDate.toIso8601String(),
        'editBy':editBy,
        'editDate':editDate.toIso8601String(),
        'status': status,
      };

  DocDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    narration = json['narration'] ?? "";
    empCode = json['empCode'] ?? "";
    docid = json['docid'] ?? 0;
    dueDate = json['dueDate'] ?? DateTime.now();
    renewedDate = json['renewedDate'] ?? DateTime.now();
    createBy = json['createBy'] ?? '';
    createDate = json['createDate'] ?? DateTime.now();
    editBy = json['editBy'] ?? '';
    editDate = json['editDate'] ?? DateTime.now();
    status = json['status'] ?? 1;
  }
}