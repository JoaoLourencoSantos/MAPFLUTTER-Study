import 'dart:convert' as convert;

import 'package:fluttermap/models/ResultDTO.dart';
import 'package:http/http.dart' as http;

const GOOGLE_URL =
    "https://us-central1-projeto-lab-314800.cloudfunctions.net/verifyUserLocation?";

Future<ResultDTO> fetchData(double lat, double long) async {
  String queryString =
      "latitude=" + lat.toString() + "&longitude=" + long.toString();

  final response = await http.get(Uri.parse(GOOGLE_URL + queryString));

  if (response.statusCode == 200) {
    return ResultDTO.fromJson(convert.jsonDecode(response.body));
  } else {
    return new ResultDTO(success: false, error: true);
  }
}
