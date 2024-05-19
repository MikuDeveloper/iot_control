import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../globals.dart';

class HttpTrucks {
  HttpTrucks._();
  static final HttpTrucks instance = HttpTrucks._();

  Future<String> getTrucks() async {
    final response = await http.get(
        Uri.https( apiUrl, 'truck' ),
        headers: { 'Authorization': 'Bearer ${auth.token}' }
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return response.body;
    } else {
      throw Exception(jsonDecode(response.body));
    }
  }

}