import 'package:fluttermap/models/Locale.dart';

class ResultDTO {
  final bool success;
  final Locale? locale;
  final String? distance;
  final String? measure;
  final bool error;

  ResultDTO({
    required this.success,
    this.locale,
    this.distance,
    this.measure,
    required this.error,
  });

  factory ResultDTO.fromJson(Map<String, dynamic> json) {
    return ResultDTO(
      success: json['success'] ? json['success'] : false,
      locale: buildLocale(json),
      distance: json['distance'],
      measure: json['measure'],
      error: checkBool(json['error']),
    );
  }

  static Locale buildLocale(Map<String, dynamic> json) {
    if (json['locale'] == null) {
      return new Locale();
    }

    return Locale(
      name: json['locale']['name'],
      lat: checkDouble(json['locale']['lat']),
      long: checkDouble(json['locale']['long']),
    );
  }

  static double checkDouble(dynamic value) {
    if (value != null) {
      return value;
    }

    return 0;
  }

  static bool checkBool(dynamic value) {
    if (value != null) {
      return value;
    }

    return false;
  }
}
