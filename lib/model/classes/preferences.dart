import 'package:jwt_decoder/jwt_decoder.dart';

import '../../globals.dart';
import '../entities/token_payload.dart';

class Preferences {
  Preferences._();
  static final Preferences instance = Preferences._();

  Future<String?> getToken() async {
    final prefs = await getPreferences();
    return prefs.getString('token');
  }

  Future<bool> isExpiredToken() async {
    final token = await getToken();
    if (token == null) return true;

    try {
      return JwtDecoder.isExpired(token);
    } on FormatException catch (_) {
      return true;
    }
  }

  Future<TokenPayload?> getPayload() async {
    final token = await getToken();
    if (token == null) return null;
    if (await isExpiredToken()) return null;

    try {
      return TokenPayload.fromJson(JwtDecoder.decode(token));
    } on FormatException catch (_) {
      return null;
    }
  }

}