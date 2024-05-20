import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../globals.dart';

class HttpDeliveries {
  HttpDeliveries._();
  static final HttpDeliveries instance = HttpDeliveries._();

  Future<String> getPending() async {
    final response = await http.get(
      Uri.https(apiUrl, 'delivery/pending'),
      headers: { 'Authorization' : 'Bearer ${ auth.token }' }
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return response.body;
    } else {
      throw Exception(jsonDecode(response.body));
    }
  }

  Future<String> getPendingByTruckId(String truckId) async {
    final response = await http.get(
        Uri.https(apiUrl, 'delivery/truck/$truckId'),
        headers: { 'Authorization' : 'Bearer ${ auth.token }' }
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return response.body;
    } else {
      throw Exception(jsonDecode(response.body));
    }
  }

}