import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iot_control/globals.dart';

class HttpUser {
  HttpUser._();
  static final HttpUser instance = HttpUser._();

  Future<String> getData() async {
    final response = await http.get(
      Uri.https(apiUrl, 'user/${auth.payload.uuid}'),
      headers: { 'Authorization': 'Bearer ${auth.token}' }
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return response.body;
    } else {
      throw Exception(jsonDecode(response.body));
    }
  }

  Future<String> getOperators() async {
    final response = await http.get(
      Uri.https(apiUrl, 'user/operators'),
      headers: { 'Authorization': 'Bearer ${auth.token}' }
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return response.body;
    } else {
      throw Exception(jsonDecode(response.body));
    }
  }

}