import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';

import 'model/api/auth.dart';

const String apiUrl = 'iot-control-api.onrender.com';
//const String apiUrl = '192.168.1.69:3000';

final auth = Auth.instance;

final messaging = FirebaseMessaging.instance;
final messageStreamController = BehaviorSubject<RemoteMessage>();
const vapidKey = "BBWKvUDMJC8REyqizOarnZidA-UvhjgYwUg2-AMKUcdwc1uG_-2qbjCKBuXVU9qFjB72-ASpFW8rTfzxdn5lK10";