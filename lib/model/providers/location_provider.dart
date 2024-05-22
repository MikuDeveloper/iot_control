import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:iot_control/model/api/http_trucks.dart';

import '../../globals.dart';

final futureStream = FutureProvider.autoDispose<StreamedResponse>((ref) async {
  final url = Uri.parse('https://$apiUrl/truck/streaming/${auth.truck.id}/location');

  final request = http.Request('GET', url);
  http.Client client = http.Client();
  HttpTrucks.instance.client = client;
  return await client.send(request);
});

final stateLocation = StateProvider<LatLng>((ref) => const LatLng(19.688632124091, -100.534629759083));
