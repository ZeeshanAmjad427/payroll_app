class LocationInAndOutModel {
  final String employeeId;
  final double latitude;
  final double longitude;

  LocationInAndOutModel({
    required this.employeeId,
    required this.latitude,
    required this.longitude,
  });

  factory LocationInAndOutModel.fromJson(Map<String, dynamic> json) {
    return LocationInAndOutModel(
      employeeId: json['employeeId'],
      latitude: json['latitude'],
      longitude: json['longitute'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId,
      'latitude': latitude,
      'longitute': longitude,
    };
  }
}
