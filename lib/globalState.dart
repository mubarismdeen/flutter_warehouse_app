import 'package:admin/models/userScreens.dart';
import 'package:admin/routes/routes.dart';

import 'api.dart';
import 'models/userDetails.dart';

class GlobalState {

  static String username = "User";
  static String userEmpCode = "1";
  static int userId = 1;

  static List<String> sideMenuItems =[];

  static void setScreensForUser(String givenUsername, UserScreens screensForUser) {
    username = givenUsername;
    setEmployeeCodeForSession(givenUsername);
    sideMenuItems = [];
    if(screensForUser.dashboard) {
      sideMenuItems.add(DashboardRoute);
    }
    if(screensForUser.stock) {
      sideMenuItems.add(StockRoute);
    }
    if(screensForUser.sales) {
      sideMenuItems.add(SalesRoute);
    }
    if(screensForUser.employees) {
      sideMenuItems.add(EmployeesRoute);
      }
    if(screensForUser.attendance) {
      sideMenuItems.add(AttendanceRoute);
    }
    if(screensForUser.salaryMaster) {
      sideMenuItems.add(SalaryMasterRoute);
    }
    if(screensForUser.salaryPayout) {
      sideMenuItems.add(SalaryPayoutRoute);
    }
    if(screensForUser.leaveSalary) {
      sideMenuItems.add(LeaveSalaryRoute);
    }
    if(screensForUser.customers) {
      sideMenuItems.add(CustomersRoute);
    }
    if(screensForUser.gratuity) {
      sideMenuItems.add(GratuityRoute);
    }
    sideMenuItems.add(AuthenticationPageRoute);
  }

  static setScreensForLocalValidation () {
    username = '1';
    userEmpCode = '1';
    sideMenuItems = [];
    sideMenuItems.addAll([DashboardRoute,
      StockRoute,
      SalesRoute,
      CustomersRoute,
      EmployeesRoute,
      AttendanceRoute,
      SalaryMasterRoute,
      SalaryPayoutRoute,
      LeaveSalaryRoute,
      GratuityRoute,
      AuthenticationPageRoute,]);
    // sideMenuItems.addAll(allSideMenuItems as Iterable<String>);
  }

  static Future<void> setEmployeeCodeForSession(String givenUsername) async {
    UserDetails userDetails = (await getUserDetailsWithUsername(givenUsername)).first;
    userEmpCode = userDetails.empCode;
    userId = userDetails.userId;
  }

}