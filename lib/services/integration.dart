import 'dart:convert' as convert;

import 'package:fluttermap/models/ResultDTO.dart';
import 'package:http/http.dart' as http;

const GOOGLE_URL =
    "https://us-central1-projeto-lab-314800.cloudfunctions.net/verifyUserLocation?";

Future<ResultDTO> fetchData(double lat, double long) async {
  String queryString =
      "latitude=" + lat.toString() + "&longitude=" + long.toString();

  String teste = "latitude=-19.93314955762107&longitude=-43.93706889593937";

  print(GOOGLE_URL + queryString);

  final response = await http.get(Uri.parse(GOOGLE_URL + teste));

  if (response.statusCode == 200) {
    return ResultDTO.fromJson(convert.jsonDecode(response.body));
  } else {
    return new ResultDTO(success: false, error: true);
  }
}
