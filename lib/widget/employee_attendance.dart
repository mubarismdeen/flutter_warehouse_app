import 'package:admin/api.dart';
import 'package:admin/constants/style.dart';
import 'package:admin/models/empMaster.dart';
import 'package:admin/utils/common_utils.dart';
import 'package:admin/widget/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../models/attedanceDto.dart';
import '../models/attendanceModel.dart';

class EmployeeAttendance extends StatefulWidget {
  DateTime pickedDate;
  EmployeeAttendance(this.pickedDate);

  @override
  _EmployeeAttendanceState createState() =>
      _EmployeeAttendanceState(pickedDate);
}

class _EmployeeAttendanceState extends State<EmployeeAttendance> {
  DateTime _pickedDate;
  List<AttendanceDto> attendances = List<AttendanceDto>.empty();
  List<AttendanceModel> _attendanceList = List<AttendanceModel>.empty();
  bool _editable = false;
  bool _enterAttendance = false;

  _EmployeeAttendanceState(this._pickedDate);

  void listUpdate(rowIndex, val, column) {
    // int rowIndex = processTail.indexWhere((element) => element.srl == int.parse(_srlId));

    int rowLength = _attendanceList.length;

    if (rowLength > rowIndex) {
      switch (column) {
        case 'empId':
          _attendanceList[rowIndex].empCode = val;
          break;
        case 'ancDays':
          _attendanceList[rowIndex].anchorage = val;
          break;
        case 'sOvt':
          _attendanceList[rowIndex].sovt = val;
          break;
        case 'nOvt':
          _attendanceList[rowIndex].novt = val;
          break;
        case 'ovrDays':
          _attendanceList[rowIndex].overseas = val;
          break;
        case 'att':
          _attendanceList[rowIndex].attendance = val;
          break;
        case 'lop':
          _attendanceList[rowIndex].lop = val;
          break;
        case 'off':
          _attendanceList[rowIndex].offdays = val;
          break;
      }
    } else {
      _attendanceList.add(AttendanceModel(
          id: 0,
          empCode: 0,
          attendance: 0,
          offdays: 0,
          lop: 0,
          novt: 0,
          sovt: 0,
          overseas: 0,
          anchorage: 0,
          date: DateFormat('yyyy-MM').format(DateTime.now()).toString(),
          editBy: 1,
          editDt: DateTime.now(),
          creatBy: 1,
          creatDt: DateTime.now()));
    }
  }

  // _loadData() async {
  //   for (int i = 0; i < 1; i++) {
  //     AttendanceDto obj = attendances[i];
  //     // _attendanceList.add(Attendance(id: 0, empCode: obj.employeeId, attendance: obj.totalAttendance, offdays: obj.totalOffAndSickDays, lop: obj.totalLossOfPaymentDays, novt: obj.totalNormalOvertimeHours, sovt: obj.totalSpecialOvertimeHours, overseas: obj.totalOverseasDays, anchorage: obj.totalAnchorageDays, editBy: 1, editDt: DateTime.now(), creatBy: 1, creatDt:  DateTime.now()));
  //     _attendanceList = [
  //       Attendance(
  //           id: 0,
  //           empCode: obj.employeeId,
  //           attendance: obj.totalAttendance,
  //           offdays: obj.totalOffAndSickDays,
  //           lop: obj.totalLossOfPaymentDays,
  //           novt: obj.totalNormalOvertimeHours,
  //           sovt: obj.totalSpecialOvertimeHours,
  //           overseas: obj.totalOverseasDays,
  //           anchorage: obj.totalAnchorageDays,
  //           date: '',
  //           editBy: 1,
  //           editDt: DateTime.now(),
  //           creatBy: 1,
  //           creatDt: DateTime.now())
  //     ];
  //   }
  // }

  getAttendanceData() async {
    attendances =
        await getAttendanceDetails(DateFormat('yyyy-MM').format(_pickedDate));
    _attendanceList = attendances
        .map((att) => AttendanceModel(
            id: att.id,
            empCode: att.employeeId,
            attendance: att.totalAttendance,
            offdays: att.totalOffAndSickDays,
            lop: att.totalOffAndSickDays,
            novt: att.totalNormalOvertimeHours,
            sovt: att.totalSpecialOvertimeHours,
            overseas: att.totalSpecialOvertimeHours,
            anchorage: att.totalAnchorageDays,
            date: DateFormat('yyyy-MM').format(DateTime.now()),
            editBy: 1,
            editDt: DateTime.now(),
            creatBy: 1,
            creatDt: DateTime.now()))
        .toList();
  }

  getData() async {
    var empList = await getEmpDetails();
    for (int i = 0; i < empList.length; i++) {
      EmpMaster emp = empList[i];
      if (i == 0) {
        attendances = [
          AttendanceDto(
              id: 0,
              employeeId: emp.empCode,
              employeeName: emp.name,
              totalAttendance: 0.0,
              totalOffAndSickDays: 0.0,
              totalLossOfPaymentDays: 0.0,
              totalNormalOvertimeHours: 0.0,
              totalSpecialOvertimeHours: 0.0,
              totalOverseasDays: 0.0,
              totalAnchorageDays: 0.0,
              molId: ''),
        ];
        _attendanceList = [
          AttendanceModel(
              id: 0,
              empCode: emp.empCode,
              attendance: 0,
              offdays: 0,
              lop: 0,
              novt: 0,
              sovt: 0,
              overseas: 0,
              anchorage: 0,
              date: '',
              editBy: 1,
              editDt: DateTime.now(),
              creatBy: 1,
              creatDt: DateTime.now())
        ];
      } else {
        attendances.add(AttendanceDto(
            id: 0,
            employeeId: emp.empCode,
            employeeName: emp.name,
            totalAttendance: 0.0,
            totalOffAndSickDays: 0.0,
            totalLossOfPaymentDays: 0.0,
            totalNormalOvertimeHours: 0.0,
            totalSpecialOvertimeHours: 0.0,
            totalOverseasDays: 0.0,
            totalAnchorageDays: 0.0,
            molId: ''));
        _attendanceList.add(AttendanceModel(
            id: 0,
            empCode: emp.empCode,
            attendance: 0,
            offdays: 0,
            lop: 0,
            novt: 0,
            sovt: 0,
            overseas: 0,
            anchorage: 0,
            date: '',
            editBy: 1,
            editDt: DateTime.now(),
            creatBy: 1,
            creatDt: DateTime.now()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: getAttendanceData(),
        builder: (context, AsyncSnapshot<dynamic> _data) {
          return attendances.isEmpty && !_enterAttendance
              ? _attendanceNotFoundContainer()
              : _attendanceTable();
        });
  }

  Widget _attendanceNotFoundContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 450,
      child: getCustomCard(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Attendance data not found for this month'),
            const SizedBox(height: 20),
            _enterAttendanceButton(),
          ],
        ),
      ),
    );
  }

  Widget _attendanceTable() {
    return FutureBuilder<dynamic>(
      future: attendances.isEmpty ? getData() : getAttendanceData(),
      builder: (context, AsyncSnapshot<dynamic> _data) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          // width: 500,
          child:
              getCustomCard(_editable ? _getDataTable() : _getViewDataTable()),
        );
      },
    );
  }

  DataCell _getCustomDataCell({required double field, index, column}) {
    return DataCell(ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 77),
      child: TextFormField(
        initialValue: field == 0 ? "" : field.toString(),
        enabled: _editable,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          field = double.parse(value);
          listUpdate(index, field, column);
        },
      ),
    ));
  }

  Column _getDataTable() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 500,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Employee \n     ID',
                      style: tableHeaderStyle,
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Employee \n  Name',
                        style: tableHeaderStyle,
                      ),
                    ),
                  ),
                  // DataColumn(
                  // label: Expanded(
                  // child: Text(
                  // 'MOL ID \n    No',
                  // style: tableHeaderStyle,
                  // ),
                  // ),
                  // ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        '     Total \nAttendance',
                        style: tableHeaderStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Off Days and \n  Sick Leave',
                        style: tableHeaderStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        '      Loss of \nPayment Days',
                        style: tableHeaderStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        '       Normal \nOvertime Hours',
                        style: tableHeaderStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        '        Special \nOvertime Hours',
                        style: tableHeaderStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Overseas \n    Days',
                        style: tableHeaderStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Anchorage \n      Days',
                        style: tableHeaderStyle,
                      ),
                    ),
                  ),
                ],
                rows: attendances
                    .map((att) => DataRow(cells: [
                          DataCell(
                              Center(child: Text(att.employeeId.toString()))),
                          DataCell(Center(child: Text(att.employeeName))),
                          // DataCell(Text(attendance.molId)),
                          _getCustomDataCell(
                              field: att.totalAttendance,
                              index: attendances.indexOf(att),
                              column: 'att'),
                          _getCustomDataCell(
                              field: att.totalOffAndSickDays,
                              index: attendances.indexOf(att),
                              column: 'off'),
                          _getCustomDataCell(
                              field: att.totalLossOfPaymentDays,
                              index: attendances.indexOf(att),
                              column: 'lop'),
                          _getCustomDataCell(
                              field: att.totalNormalOvertimeHours,
                              index: attendances.indexOf(att),
                              column: 'nOvt'),
                          _getCustomDataCell(
                              field: att.totalSpecialOvertimeHours,
                              index: attendances.indexOf(att),
                              column: 'sOvt'),
                          _getCustomDataCell(
                              field: att.totalOverseasDays,
                              index: attendances.indexOf(att),
                              column: 'ovrDays'),
                          _getCustomDataCell(
                              field: att.totalAnchorageDays,
                              index: attendances.indexOf(att),
                              column: 'ancDays'),
                        ]))
                    .toList(),
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        _editable ? _saveButton() : _editButton(),
      ],
    );
  }

  Column _getViewDataTable() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 500,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Employee \n     ID',
                      style: tableHeaderStyle,
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Employee \n  Name',
                        style: tableHeaderStyle,
                      ),
                    ),
                  ),
                  // DataColumn(
                  // label: Expanded(
                  // child: Text(
                  // 'MOL ID \n    No',
                  // style: tableHeaderStyle,
                  // ),
                  // ),
                  // ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        '     Total \nAttendance',
                        style: tableHeaderStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Off Days and \n  Sick Leave',
                        style: tableHeaderStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        '      Loss of \nPayment Days',
                        style: tableHeaderStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        '       Normal \nOvertime Hours',
                        style: tableHeaderStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        '        Special \nOvertime Hours',
                        style: tableHeaderStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Overseas \n    Days',
                        style: tableHeaderStyle,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Anchorage \n      Days',
                        style: tableHeaderStyle,
                      ),
                    ),
                  ),
                ],
                rows: attendances
                    .map((att) => DataRow(cells: [
                          DataCell(
                              Center(child: Text(att.employeeId.toString()))),
                          DataCell(Center(child: Text(att.employeeName))),
                          // DataCell(Text(attendance.molId)),
                          DataCell(Center(
                              child: Text(att.totalAttendance.toString()))),
                          DataCell(Center(
                              child: Text(att.totalOffAndSickDays.toString()))),
                          DataCell(Center(
                              child:
                                  Text(att.totalLossOfPaymentDays.toString()))),
                          DataCell(Center(
                              child: Text(
                                  att.totalNormalOvertimeHours.toString()))),
                          DataCell(Center(
                              child: Text(
                                  att.totalSpecialOvertimeHours.toString()))),
                          DataCell(Center(
                              child: Text(att.totalOverseasDays.toString()))),
                          DataCell(Center(
                              child: Text(att.totalAnchorageDays.toString()))),
                        ]))
                    .toList(),
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        _editable ? _saveButton() : _editButton(),
      ],
    );
  }

  Widget _enterAttendanceButton() {
    return CustomElevatedButton(
      handleOnPress: () => {
        setState(
          () {
            _enterAttendance = true;
            _editable = true;
          },
        ),
      },
      buttonText: 'Enter Attendance',
    );
  }

  Widget _editButton() {
    return CustomElevatedButton(
      handleOnPress: () => {
        setState(
          () {
            _editable = true;
          },
        ),
      },
      buttonText: 'Edit',
    );
  }

  Widget _saveButton() {
    return CustomElevatedButton(
      handleOnPress: () async {
        // await _loadData();
        bool status = await saveAttendance(_attendanceList);
        if (status) {
          Fluttertoast.showToast(
            msg: "Saved",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
            webPosition: "center",
            webShowClose: false,
          );
        }
        setState(() {
          _editable = false;
        });
      },
      buttonText: 'Save',
    );
  }
}

// class AttendanceDto {
//   int id = 0;
//   int employeeId = 0;
//   String employeeName = '';
//   String molId = '';
//   double totalAttendance = 0.0;
//   double totalOffAndSickDays = 0.0;
//   double totalLossOfPaymentDays = 0.0;
//   double totalNormalOvertimeHours = 0.0;
//   double totalSpecialOvertimeHours = 0.0;
//   double totalOverseasDays = 0.0;
//   double totalAnchorageDays = 0.0;
//
//   AttendanceDto(
//       {required this.id,
//       required this.employeeId,
//       required this.employeeName,
//       required this.molId,
//       required this.totalAttendance,
//       required this.totalOffAndSickDays,
//       required this.totalLossOfPaymentDays,
//       required this.totalNormalOvertimeHours,
//       required this.totalSpecialOvertimeHours,
//       required this.totalOverseasDays,
//       required this.totalAnchorageDays});
//
//   AttendanceDto.fromJson(Map<String, dynamic> json) {
//     id = json['id'] ?? 0;
//     employeeId = json['empCode'] ?? 0;
//     employeeName = json['name'] ?? 'NULL';
//     molId = json['molId'] ?? 'NULL';
//     totalAttendance = json['attendance'] ?? 0.0;
//     totalOffAndSickDays = json['offDays'] ?? 0.0;
//     totalLossOfPaymentDays = json['lop'] ?? 0.0;
//     totalNormalOvertimeHours = json['novt'] ?? 0.0;
//     totalSpecialOvertimeHours = json['sovt'] ?? 0.0;
//     totalOverseasDays = json['overseas'] ?? 0.0;
//     totalAnchorageDays = json['anchorage'] ?? 0.0;
//   }
// }

// class AttendanceDto {
//   int empCode;
//   int attendance;
//   int offdays;
//   int lop;
//   String novt;
//   String sovt;
//   int overseas;
//   int anchorage;
//   int editBy;
//   DateTime editDt;
//   int creatBy;
//   DateTime creatDt;
//
//   AttendanceDto(this.empCode,
//       this.attendance,
//       this.offdays,
//       this.lop,
//       this.novt,
//       this.sovt,
//       this.overseas,
//       this.anchorage,
//       this.editBy,
//       this.editDt,
//       this.creatBy,
//       this.creatDt,);
// }
