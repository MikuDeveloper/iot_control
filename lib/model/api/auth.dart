import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iot_control/model/entities/truck.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../firebase_options.dart';
import '../../globals.dart';
import '../entities/payload.dart';

class Auth {
  Auth._();
  static final Auth instance = Auth._();

  late Payload payload = Payload();
  late String token = '';
  late Truck truck = Truck();
  late String? messagingToken;

  Future<String> login({required String email, required String password}) async {
    final response = await http.post(
        Uri.https(apiUrl, 'auth/login'),
        body: { 'email': email, 'password': password }
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      await _setToken(response.body);
      _setPayload();
      return response.body;
    } else {
      throw Exception(jsonDecode(response.body));
    }
  }

  Future<void> logout() async {
    final prefs = await _getPreferences();
    prefs.remove('token');
    prefs.remove('messagingToken');
    token = '';
    payload = Payload();
    truck = Truck();
  }

  Future<String?> _getToken() async {
    final prefs = await _getPreferences();
    return prefs.getString('token');
  }

  Future<void> _setToken(String jwt) async {
    final prefs = await _getPreferences();
    prefs.setString('token', jwt);
    token = jwt;
  }

  Future<bool> isExpiredToken() async {
    final token = await _getToken();
    if (token == null) return true;

    try {
      final isExpired = JwtDecoder.isExpired(token);
      if (!isExpired) {
        await _setToken(token);
        _setPayload();
        return isExpired;
      } else {
        return isExpired;
      }
    } on FormatException catch (_) {
      return true;
    }
  }

  void _setPayload() {
    payload = Payload.fromJson(JwtDecoder.decode(token));
  }

  Future<void> setMessagingToken() async {
    final prefs = await _getPreferences();
    if (prefs.getString('messagingToken') != null) return;

    if (DefaultFirebaseOptions.currentPlatform == DefaultFirebaseOptions.web) {
      messagingToken = await messaging.getToken(vapidKey: vapidKey);
    } else {
      messagingToken = await messaging.getToken();
    }

    final response = await http.post(
        Uri.https(apiUrl, 'notification/register'),
        headers: {'Authorization': 'Bearer $token'},
        body: { 'uuid': payload.uuid, 'token': messagingToken },
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      prefs.setString('messagingToken', messagingToken!);
    }
  }

  Future<void> sendNotification({required String title, required String body}) async {
    await http.post(
        Uri.https(apiUrl, 'notification/send/${payload.uuid}'),
        headers: {'Authorization': 'Bearer $token'},
        body: { 'title': title, 'body': body }
    );
  }

  Future<SharedPreferences> _getPreferences () async => await SharedPreferences.getInstance();
}