import '../../../domain/entities/location/location_out.dart';

class LocationOutModel extends LocationOut {
  LocationOutModel({
    required String employeeId,
    required double latitude,
    required double longitude,
  }) : super(
    employeeId: employeeId,
    latitude: latitude,
    longitude: longitude,
  );

  factory LocationOutModel.fromJson(Map<String, dynamic> json) {
    return LocationOutModel(
      employeeId: json['employeeId'],
      latitude: json['latitude'],
      longitude: json['longitute'], // typo kept consistent
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
