class ApiEndpoints {
  static const String baseUrl = "http://payrollstaging.qbscocloud.net:31112";// Production Url
  static const String loginUrl = "/Auth/IAuthFeature/Login";
  static const String addAttendanceUrl = "/EmsAPI/Attendance/AddAttendance";
  static const String updateAttendanceUrl = "/EmsAPI/Attendance/UpdateAttendance";
  static const String addLocationInUrl = "/EmsAPI/IAttendanceLocationManagement/AddLocationIn";
  static const String addLocationOutUrl = "/EmsAPI/IAttendanceLocationManagement/AddLocationOut";
  static const String add2FA = "/Auth/IAuthFeature/Add2FA";
  static const String remove2FA = "/Auth/IAuthFeature/Remove2FA";
  static const String getAttendanceLog = "/EmsAPI/Attendance/GetAttendance";



}