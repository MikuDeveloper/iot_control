import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../globals.dart';

class HttpClients {
  HttpClients._();
  static final HttpClients instance = HttpClients._();

  Future<String> getClients() async {
    final response = await http.get(
        Uri.https(apiUrl, 'client'),
        headers: { 'Authorization' : 'Bearer ${ auth.token }' }
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return response.body;
    } else {
      throw Exception(jsonDecode(response.body));
    }
  }

}