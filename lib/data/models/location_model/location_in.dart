import '../../../domain/entities/location/location_in.dart';

class LocationInModel extends LocationIn {
  LocationInModel({
    required String employeeId,
    required double latitude,
    required double longitude,
  }) : super(
    employeeId: employeeId,
    latitude: latitude,
    longitude: longitude,
  );

  factory LocationInModel.fromJson(Map<String, dynamic> json) {
    return LocationInModel(
      employeeId: json['employeeId'],
      latitude: json['latitude'],
      longitude: json['longitute'], // note the typo in your API body
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
