import 'package:http/http.dart' as http;

import '../../globals.dart';

class Authentication {
  Authentication._();

  static final Authentication instance = Authentication._();

  Future<String> login({required String email, required String password}) async {
    final response = await http.post(
      Uri.https(apiUrl, 'auth/login'),
      body: { "email": email, "password": password }
    );

    if (response.body.contains('ey')) {
      final prefs = await getPreferences();
      prefs.setString('token', response.body);
      return response.body;
    } else {
      throw Exception(response.body);
    }
  }

  Future<void> logout() async {
    final prefs = await getPreferences();
    final token = await preferences.getToken();
    final payload = await preferences.getPayload();

    notifications.removeNotificationToken(token!, payload!.uuid!);

    prefs.remove('token');
    prefs.remove('notificationtoken');
  }
}