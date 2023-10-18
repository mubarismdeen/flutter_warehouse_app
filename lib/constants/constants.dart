enum Screen {
  dashboard,
  employees,
  attendance,
  salaryMaster,
  salaryPayout,
  leaveSalary,
  customers,
  gratuity,
}

extension ScreenExtension on Screen {
  String get value {
    switch (this) {
      case Screen.dashboard:
        return "Dashboard";
      case Screen.employees:
        return "Employees";
      case Screen.attendance:
        return "Attendance";
      case Screen.salaryMaster:
        return "Salary Master";
      case Screen.salaryPayout:
        return "Salary Payout";
      case Screen.leaveSalary:
        return "Leave Salary";
      case Screen.customers:
        return "Customers";
      case Screen.gratuity:
        return "Gratuity";
    }
  }
}