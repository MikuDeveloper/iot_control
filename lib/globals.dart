import 'package:shared_preferences/shared_preferences.dart';

import 'model/classes/authentication.dart';
import 'model/classes/preferences.dart';

const String apiUrl = 'iot-control-api.onrender.com';

Future<SharedPreferences> getPreferences () async => await SharedPreferences.getInstance();

final preferences = Preferences.instance;
final auth = Authentication.instance;