import 'dart:convert';

import 'package:admin/models/customerDetails.dart';
import 'package:admin/models/employeeDetails.dart';
import 'package:admin/models/jobDetails.dart';
import 'package:admin/models/leaveSalary.dart';
import 'package:admin/models/quotationDetails.dart';
import 'package:admin/models/salaryPaid.dart';
import 'package:admin/models/saveEmployeeDetails.dart';
import 'package:admin/models/userPrivileges.dart';
import 'package:admin/models/userScreens.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'models/attedanceDto.dart';
import 'models/attendanceModel.dart';
import 'models/docDetails.dart';
import 'models/empMaster.dart';
import 'models/salaryMaster.dart';
import 'models/salaryMasterGet.dart';
import 'models/salaryPay.dart';
import 'models/userDetails.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
String ip = "localhost:8080";
// String ip = "localhost:81";     // IIS
// String ip = "172.11.7.254:88"; //live
// String ip = "172.11.7.254:98"; //test

enum HttpMethod {
  GET,
  POST,
}

Future<bool> localUserValidation(String userID, String password) async {
  if(userID == '1' && password == '123'){
    return true;
  }else{
    return false;
  }
}

Future<dynamic> httpConnect(String urlWithParams, HttpMethod method, [dynamic jsonData]) async {
  try {
    dynamic response;
    switch(method) {
      case HttpMethod.GET:
        response = await http.get(Uri.parse(urlWithParams));
        break;
      case HttpMethod.POST:
        response = await http.post(Uri.parse(urlWithParams), headers: {"Content-Type": "application/json"}, body: jsonData);
        break;
      default:
        throw Exception('Invalid Http Method');
    }
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed');
    }
  } catch (e) {
    throw Exception('Failed');
  }

}

Future<bool> userValidate(String userID, String password) async {
  String urlWithParams = "http://$ip/Hrms/userValidat?userCd=$userID&password=$password";
  return await httpConnect(urlWithParams, HttpMethod.GET) as bool;
}

Future<List<UserScreens>> authorizeUser(String username, String password) async {
  String urlWithParams = "http://$ip/api/authorizeUser?username=$username&password=$password";
  List<UserScreens> list = (await httpConnect(urlWithParams, HttpMethod.GET) as List)
      .map((job) => UserScreens.fromJson(job)).toList();
  return list;
}

Future<List<UserDetails>> getUserDetails (String empCode) async {
  String urlWithParams = "http://$ip/Hrms/getUserDetails?empCode=$empCode";
  List<UserDetails> list = (await httpConnect(urlWithParams, HttpMethod.GET) as List)
      .map((job) => UserDetails.fromJson(job)).toList();
  return list;
}

Future<List<UserDetails>> getUserDetailsWithUsername (String username) async {
  String urlWithParams = "http://$ip/Hrms/getUserDetailsWithUsername?username=$username";
  List<UserDetails> list = (await httpConnect(urlWithParams, HttpMethod.GET) as List)
      .map((job) => UserDetails.fromJson(job)).toList();
  return list;
}

Future<bool> saveUserDetails(UserDetails userDetails) async {
  String urlWithParams = "http://$ip/Hrms/saveUserDetails";
  var jsonData = jsonEncode(userDetails);
  return await httpConnect(urlWithParams, HttpMethod.POST, jsonData) as bool;
}

Future<List<UserScreens>> getScreensForEmployee (String empCode) async {
  String urlWithParams = "http://$ip/Hrms/getScreensForEmployee?empCode=$empCode";
  List<UserScreens> list = (await httpConnect(urlWithParams, HttpMethod.GET) as List)
      .map((job) => UserScreens.fromJson(job)).toList();
  return list;
}

Future<bool> saveScreensForEmployee(UserScreens userScreens) async {
  String urlWithParams = "http://$ip/Hrms/saveScreensForEmployee";
  var jsonData = jsonEncode(userScreens);
  return await httpConnect(urlWithParams, HttpMethod.POST, jsonData) as bool;
}

Future<List<UserPrivileges>> getAllPrivilegesForUser(String empCode) async {
  String urlWithParams = "http://$ip/Hrms/getAllPrivilegesForUser?empCode=$empCode";
  List<UserPrivileges> list = (await httpConnect(urlWithParams, HttpMethod.GET) as List)
      .map((job) => UserPrivileges.fromJson(job)).toList();
  return list;
}

Future<List<UserPrivileges>> getAPrivilegeForUser(String username, String privilegeName) async {
  String urlWithParams = "http://$ip/Hrms/getAPrivilegeForUser?userName=$username&privilege=$privilegeName";
  List<UserPrivileges> list = (await httpConnect(urlWithParams, HttpMethod.GET) as List)
      .map((job) => UserPrivileges.fromJson(job)).toList();
  return list;
}

Future<bool> savePrivilegesForUser(List<UserPrivileges> privilegesList) async {
  String urlWithParams = "http://$ip/Hrms/savePrivilegesForUser";
  var jsonData = jsonEncode(privilegesList);
  return await httpConnect(urlWithParams, HttpMethod.POST, jsonData) as bool;
}

Future<List<Map<String, dynamic>>> getDocDetails() async {
  String urlWithParams = "http://$ip/Hrms/getDocDetails";
  List<Map<String, dynamic>> list = (await httpConnect(urlWithParams, HttpMethod.GET) as List)
      .map((dynamic e) => e as Map<String, dynamic>).toList();
  return list;
}

Future<List<Map<String, dynamic>>> getDocType() async {
  String urlWithParams = "http://$ip/Hrms/getDocType";
  List<Map<String, dynamic>> list = (await httpConnect(urlWithParams, HttpMethod.GET) as List)
      .map((dynamic e) => e as Map<String, dynamic>).toList();
  return list;
}

Future<List<Map<String, dynamic>>> getQuotationType() async {
  String urlWithParams = "http://$ip/Hrms/getQuotationType";
  List<Map<String, dynamic>> list = (await httpConnect(urlWithParams, HttpMethod.GET) as List)
      .map((dynamic e) => e as Map<String, dynamic>).toList();
  return list;
}

Future<List<Map<String, dynamic>>> getPoStatus() async {
  String urlWithParams = "http://$ip/Hrms/getpoStatus";
  List<Map<String, dynamic>> list = (await httpConnect(urlWithParams, HttpMethod.GET) as List)
      .map((dynamic e) => e as Map<String, dynamic>).toList();
  return list;
}

Future<List<Map<String, dynamic>>> getInvoiceStatus() async {
  String urlWithParams = "http://$ip/Hrms/getinvStatus";
  List<Map<String, dynamic>> list = (await httpConnect(urlWithParams, HttpMethod.GET) as List)
      .map((dynamic e) => e as Map<String, dynamic>).toList();
  return list;
}

Future<List<Map<String, dynamic>>> getQuotationDetails(String customerName, String name, String poStatus, String invStatus, String type) async {
  String urlWithParams = "http://$ip/Hrms/getQuotationDetails?customerName=$customerName&name=$name&poStatus=$poStatus&invStatus=$invStatus&type=$type";
  List<Map<String, dynamic>> list = (await httpConnect(urlWithParams, HttpMethod.GET) as List)
      .map((dynamic e) => e as Map<String, dynamic>).toList();
  return list;
}

Future<bool> deleteQuotationDetails(int quotationId) async {
  String urlWithParams = "http://$ip/Hrms/DeleteQuotationDetails?id=$quotationId";
  return await httpConnect(urlWithParams, HttpMethod.GET) as bool;
}

Future<List<Map<String, dynamic>>> getGratuityDetails() async {
  String urlWithParams = "http://$ip/Hrms/getGratuityDetails";
  List<Map<String, dynamic>> list = (await httpConnect(urlWithParams, HttpMethod.GET) as List)
      .map((dynamic e) => e as Map<String, dynamic>).toList();
  return list;
}

Future<bool> saveSalaryMaster(SalaryMaster salaryMaster) async {
  String urlWithParams = "http://$ip/Hrms/saveSalaryMaster";
  var jsonData = jsonEncode(salaryMaster);
  return await httpConnect(urlWithParams, HttpMethod.POST, jsonData) as bool;
}

Future<bool> deleteSalaryMaster(int salaryMasterId) async {
  String urlWithParams = "http://$ip/Hrms/DeleteSalaryMaster?id=$salaryMasterId";
  return await httpConnect(urlWithParams, HttpMethod.GET) as bool;
}


Future<bool> saveDocDetails(DocDetails docDetails) async {
  String urlWithParams = "http://$ip/Hrms/saveDocDetails";
  var jsonData = jsonEncode(docDetails);
  return await httpConnect(urlWithParams, HttpMethod.POST, jsonData) as bool;
}

Future<bool> deleteDocDetails(int docId) async {
  String urlWithParams = "http://$ip/Hrms/DeleteDocDetails?id=$docId";
  return await httpConnect(urlWithParams, HttpMethod.GET) as bool;
}


Future<bool> saveQuotationDetails(QuotationDetails quotationDetails) async {
  String urlWithParams = "http://$ip/Hrms/saveQuotation";
  var jsonData = jsonEncode(quotationDetails);
  return await httpConnect(urlWithParams, HttpMethod.POST, jsonData) as bool;
}

Future<bool> saveGratuity(String empCode, String type,String editBy) async {
  String urlWithParams = "http://$ip/Hrms/SaveGratuity?empCode=$empCode&type=$type&editBy=$editBy";
  return await httpConnect(urlWithParams, HttpMethod.GET) as bool;
}

Future<bool> saveAttendance(List<AttendanceModel> attendanceList) async {
  String urlWithParams = "http://$ip/Hrms/saveAttendance";
  var jsonData = jsonEncode(attendanceList);
  return await httpConnect(urlWithParams, HttpMethod.POST, jsonData) as bool;
}


Future<List<EmpMaster>> getEmpDetails() async {
  String urlWithParams = "http://$ip/Hrms/getEmpDetails";
  List<EmpMaster> list = (await httpConnect(urlWithParams, HttpMethod.GET) as List)
      .map((job) => EmpMaster.fromJson(job)).toList();
  return list;
}

Future<List<EmpMaster>> getGratuityEmp() async {
  String urlWithParams = "http://$ip/Hrms/getGratuityEmp";
  List<EmpMaster> list = (await httpConnect(urlWithParams, HttpMethod.GET) as List)
      .map((job) => EmpMaster.fromJson(job)).toList();
  return list;
}
Future<List<AttendanceDto>> getAttendanceDetails(String date) async {
  String urlWithParams = "http://$ip/Hrms/getAttendance?date=$date";
  List<AttendanceDto> list = (await httpConnect(urlWithParams, HttpMethod.GET))
      .map((job) => AttendanceDto.fromJson(job)).cast<AttendanceDto>().toList();
  return list;
}

Future<List<SalaryPay>> getSalaryPay(String date) async {
  String urlWithParams = "http://$ip/Hrms/getSalaryPay?date=$date";
  List<SalaryPay> list = (await httpConnect(urlWithParams, HttpMethod.GET))
      .map((job) => SalaryPay.fromJson(job)).cast<SalaryPay>().toList();
  return list;
}

Future<List<SalaryMasterGet>> getSalaryMaster(String date) async {
  String urlWithParams = "http://$ip/Hrms/getSalary?date=$date";
  List<SalaryMasterGet> list = (await httpConnect(urlWithParams, HttpMethod.GET))
      .map((job) => SalaryMasterGet.fromJson(job)).cast<SalaryMasterGet>().toList();
  return list;
}

Future<List<EmployeeDetails>> getEmployeeDetails() async {
  String urlWithParams = "http://$ip/employees/getEmployeeDetails";
  List<EmployeeDetails> list = (await httpConnect(urlWithParams, HttpMethod.GET))
      .map((job) => EmployeeDetails.fromJson(job)).cast<EmployeeDetails>().toList();
  return list;
}

Future<List<LeaveSalary>> getLeaveSalary(String year) async {
  String urlWithParams = "http://$ip/Hrms/getLeaveSalary?year=$year";
  List<LeaveSalary> list = (await httpConnect(urlWithParams, HttpMethod.GET))
      .map((job) => LeaveSalary.fromJson(job)).cast<LeaveSalary>().toList();
  return list;
}

Future<bool> saveSalaryPaid(SalaryPaid salaryPaid) async {
  String urlWithParams = "http://$ip/Hrms/saveSalaryPaid";
  var jsonData = jsonEncode(salaryPaid);
  return await httpConnect(urlWithParams, HttpMethod.POST, jsonData) as bool;
}

Future<List<Map<String, dynamic>>> getJobDetails(String jobStatus, String assignedTo, String dueDate) async {
  String urlWithParams = "http://$ip/Hrms/getJobDetails?JobStatus=$jobStatus&AssignedTo=$assignedTo&DueDate=$dueDate";
  List<Map<String, dynamic>> list = (await httpConnect(urlWithParams, HttpMethod.GET) as List)
      .map((dynamic e) => e as Map<String, dynamic>).toList();
  return list;
}

Future<bool> saveJobDetails(JobDetails jobDetails) async {
  String urlWithParams = "http://$ip/Hrms/saveJobDetail";
  var jsonData = jsonEncode(jobDetails);
  return await httpConnect(urlWithParams, HttpMethod.POST, jsonData) as bool;
}

Future<bool> deleteJobDetails(int jobId) async {
  String urlWithParams = "http://$ip/Hrms/DeleteJobDetails?id=$jobId";
  return await httpConnect(urlWithParams, HttpMethod.GET) as bool;
}

Future<bool> saveEmployeeDetails(SaveEmployeeDetails employeeDetails) async {
  String urlWithParams = "http://$ip/Hrms/saveEmployeeDetails";
  var jsonData = jsonEncode(employeeDetails);
  return await httpConnect(urlWithParams, HttpMethod.POST, jsonData) as bool;
}

Future<bool> deleteEmployeeDetails(int employeeId) async {
  String urlWithParams = "http://$ip/Hrms/DeleteEmployeeDetails?id=$employeeId";
  return await httpConnect(urlWithParams, HttpMethod.GET) as bool;
}


Future<List<Map<String, dynamic>>> getJobStatuses() async {
  String urlWithParams = "http://$ip/Hrms/getjobStatus";
  List<Map<String, dynamic>> list = (await httpConnect(urlWithParams, HttpMethod.GET) as List)
      .map((dynamic e) => e as Map<String, dynamic>).toList();
  return list;
}

Future<List<Map<String, dynamic>>> getDepartments() async {
  String urlWithParams = "http://$ip/Hrms/getDeparments";
  List<Map<String, dynamic>> list = (await httpConnect(urlWithParams, HttpMethod.GET) as List)
      .map((dynamic e) => e as Map<String, dynamic>).toList();
  return list;
}

Future<List<Map<String, dynamic>>> getEmployeeStatuses() async {
  String urlWithParams = "http://$ip/Hrms/getEmployeeStatuses";
  List<Map<String, dynamic>> list = (await httpConnect(urlWithParams, HttpMethod.GET) as List)
      .map((dynamic e) => e as Map<String, dynamic>).toList();
  return list;
}

Future<List<Map<String, dynamic>>> getEmployeeNationalities() async {
  String urlWithParams = "http://$ip/Hrms/getEmployeeNationalities";
  List<Map<String, dynamic>> list = (await httpConnect(urlWithParams, HttpMethod.GET) as List)
      .map((dynamic e) => e as Map<String, dynamic>).toList();
  return list;
}

Future<List<Map<String, dynamic>>> getGratuityType() async {
  String urlWithParams = "http://$ip/Hrms/getGratuityType";
  List<Map<String, dynamic>> list = (await httpConnect(urlWithParams, HttpMethod.GET) as List)
      .map((dynamic e) => e as Map<String, dynamic>).toList();
  return list;
}

Future<List<CustomerDetails>> getCustomerDetails() async {
  String urlWithParams = "http://$ip/Hrms/getCustomerDetails";
  List<CustomerDetails> list = (await httpConnect(urlWithParams, HttpMethod.GET))
      .map((job) => CustomerDetails.fromJson(job)).cast<CustomerDetails>().toList();
  return list;
}

Future<bool> saveCustomerDetails(CustomerDetails customerDetails) async {
  String urlWithParams = "http://$ip/Hrms/saveCustomerDetails";
  var jsonData = jsonEncode(customerDetails);
  return await httpConnect(urlWithParams, HttpMethod.POST, jsonData) as bool;
}

Future<bool> deleteCustomerDetails(int customerId) async {
  String urlWithParams = "http://$ip/Hrms/DeleteCustomerDetails?id=$customerId";
  return await httpConnect(urlWithParams, HttpMethod.GET) as bool;
}


