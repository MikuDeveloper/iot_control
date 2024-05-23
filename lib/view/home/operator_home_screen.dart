import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../../controller/login/logout_controller.dart';
import '../../globals.dart';
import '../../model/entities/location.dart';
import '../operator/operator_deliveries.dart';

class OperatorHomeScreen extends StatefulWidget {
  const OperatorHomeScreen({super.key});

  @override
  State<OperatorHomeScreen> createState() => _OperatorHomeScreenState();
}

class _OperatorHomeScreenState extends State<OperatorHomeScreen> {
  Timer? locationTimer;

  @override
  void initState() {
    super.initState();
    startLocationUpdates();
  }

  void startLocationUpdates() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return;
    }

    locationTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      final position = await Geolocator.getCurrentPosition();
      sendLocationToServer(position);
    });
  }

  Future<void> sendLocationToServer(Position position) async {
    //final url = 'https://iot-control-api.onrender.com/';
    auth.truck = auth.truck.copyWith(location: Location(latitude: position.latitude, longitude: position.longitude)) ;

    final response = await http.patch(
      Uri.https(apiUrl, 'truck/update/${auth.truck.id}'),
      body: { "location" : locationToJson(Location(latitude: position.latitude, longitude: position.longitude)) },
      headers: { 'Authorization': 'Bearer ${ auth.token }' }
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      print('Ubicación enviada al servidor');
    } else {
      print(response.body);
      print('Error al enviar la ubicación al servidor');
    }
  }

  @override
  void dispose() {
    locationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos asignados'),
        actions: const [
          LogoutController()
        ],
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 21),
        actionsIconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const OperatorDeliveries()
    );
  }
}
