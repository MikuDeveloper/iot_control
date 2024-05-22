import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../../globals.dart';

final futureStream = FutureProvider.autoDispose<StreamedResponse>((ref) async {
  final url = Uri.parse('https://$apiUrl/truck/streaming/${auth.truck.id}/location');

  final request = http.Request('GET', url);
  http.Client client = http.Client();
  return await client.send(request);
});
