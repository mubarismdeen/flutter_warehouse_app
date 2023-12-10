
class JobDetails {
  int id = 0;
  String job = "";
  String narration = "";
  String assignedDate = "";
  String dueDate = "";
  int jobStatus = 0;
  int status = 1;
  String assignedTo = "";
  String createBy = "";
  DateTime createDate = DateTime.now();
  String editBy = "";
  DateTime editDate = DateTime.now();

  JobDetails({
    required this.id,
    required this.job,
    required this.narration,
    required this.assignedDate,
    required this.jobStatus,
    required this.status,
    required this.assignedTo,
    required this.dueDate,
    required this.createBy,
    required this.createDate,
    required this.editBy,
    required this.editDate,
  });

  JobDetails.toJson();

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'job': job,
        'narration': narration,
        'assignedDate': assignedDate,
        'jobStatus': jobStatus,
        'status': status,
        'assignedTo': assignedTo,
        'dueDate': dueDate,
        'createBy':createBy,
        'createDate':createDate.toIso8601String(),
        'editBy':editBy,
        'editDate':editDate.toIso8601String(),
      };

}