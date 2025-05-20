class ApiEndpoints {
  static const String baseUrl = "http://payrollstaging.qbscocloud.net:31112";// Production Url

  static const String loginUrl = "/Auth/IAuthFeature/Login";
  static const String addAttendanceUrl = "/EmsAPI/Attendance/AddAttendance";
  static const String updateAttendanceUrl = "/EmsAPI/Attendance/UpdateAttendance";
  static const String addLocationInUrl = "/EmsAPI/IAttendanceLocationManagement/AddLocationIn";
  static const String addLocationOutUrl = "/EmsAPI/IAttendanceLocationManagement/AddLocationOut";
}