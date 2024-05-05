import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:iot_control/model/classes/notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/classes/authentication.dart';
import 'model/classes/preferences.dart';

const String apiUrl = 'iot-control-api.onrender.com';

Future<SharedPreferences> getPreferences () async => await SharedPreferences.getInstance();

final preferences = Preferences.instance;
final notifications = Notifications.instance;
final auth = Authentication.instance;

final messaging = FirebaseMessaging.instance;
final messageStreamController = BehaviorSubject<RemoteMessage>();
const vapidKey = "BBWKvUDMJC8REyqizOarnZidA-UvhjgYwUg2-AMKUcdwc1uG_-2qbjCKBuXVU9qFjB72-ASpFW8rTfzxdn5lK10";