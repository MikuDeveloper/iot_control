import 'package:http/http.dart' as http;

import '../../firebase_options.dart';
import '../../globals.dart';

class Notifications {
  Notifications._();
  static final Notifications instance = Notifications._();

  Future setNotificationToken(String token, String uuid) async {
    String? notificationToken = await getNotificationToken();

    if (notificationToken != null) return;

    if (DefaultFirebaseOptions.currentPlatform == DefaultFirebaseOptions.web) {
      notificationToken = await messaging.getToken(vapidKey: vapidKey);
    } else {
      notificationToken = await messaging.getToken();
    }

    final response = await http.put(
        Uri.https(apiUrl, 'user/$uuid'),
        headers: {'Authorization': 'Bearer $token'},
        body: { "notificationtoken": notificationToken }
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final prefs = await getPreferences();
      prefs.setString('notificationtoken', notificationToken!);
    }
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

  Future<String?> getNotificationToken () async {
    final prefs = await getPreferences();
    return prefs.getString('notificationtoken');
  }
}