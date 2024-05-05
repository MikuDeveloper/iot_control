import 'package:http/http.dart' as http;

import '../../globals.dart';

class Notification {
  Notification._();
  static final Notification instance = Notification._();

  Future setNotificationToken(String token, String uuid) async {
    //TODO: Get token from messaging

    final response = await http.put(
        Uri.https(apiUrl, 'user/$uuid'),
        headers: {'Authorization': 'Bearer $token'},
        body: { "notificationtoken": "sljnsdgljngsd" }
    );

    final prefs = await getPreferences();
    prefs.setString('notificationtoken', 'sljnsdgljngsd');
  }

  Future removeNotificationToken(String token, String uuid) async {
    final prefs = await getPreferences();
    prefs.remove('notificationtoken');

    await http.put(
        Uri.https(apiUrl, 'user/$uuid'),
        headers: {'Authorization': 'Bearer $token'},
        body: { "notificationtoken": "" }
    );
  }
}