import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../globals.dart';

class HttpTrucks {
  HttpTrucks._();
  static final HttpTrucks instance = HttpTrucks._();

  http.Client client = http.Client();

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

  Future<String> getTruckByOperator(String operator) async {
    final response = await http.get(
        Uri.https( apiUrl, 'truck/operator/$operator' ),
        headers: { 'Authorization': 'Bearer ${auth.token}' }
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return response.body;
    } else {
      throw Exception(jsonDecode(response.body));
    }
  }

  Stream<String> fetchLocation() async* {
    final url = Uri.parse('https://$apiUrl/truck/streaming/${auth.truck.id}/location');

    final request = http.Request('GET', url);
    http.Client client = http.Client();

    final response = await client.send(request);

    await for (final data in response.stream.transform(utf8.decoder)) {
      final dataString = data.toString().split('\n')[1];
      final json = dataString.split(' ').last;

      yield json;
    }
  }

}