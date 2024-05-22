import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iot_control/globals.dart';
import 'package:iot_control/model/entities/truck.dart';
import 'package:http/http.dart' as http;

import '../../model/entities/client.dart';
import '../../model/entities/delivery.dart';

class MapScreen extends StatefulWidget {
  final Delivery delivery;
  final Client client;
  const MapScreen({super.key, required this.delivery, required this.client});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final trucId = auth.truck.id;

  final LatLng _store = const LatLng(19.6886321240918, -100.5346297590831);
  LatLng _truck = const LatLng(19.688632124091, -100.534629759083);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    startGetLocationUpdates();
  }

  final geolocator = Geolocator();
  Timer? locationTimer;

  @override
  void initState() {
    super.initState();

  }

  void startGetLocationUpdates() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return;
    }

    locationTimer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      //final position = await Geolocator.getCurrentPosition();
      getLocationFromServer();
    });
  }

  Future<void> getLocationFromServer() async {
    //final url = 'https://iot-control-api.onrender.com/';
    final response = await http.get(
        Uri.https(apiUrl, 'truck/${auth.truck.id}'),
        headers: { 'Authorization': 'Bearer ${ auth.token }' }
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      print(response.body);
      final truck = Truck.fromJson(jsonDecode(response.body));
      setState(() {
        _truck = LatLng(truck.location!.latitude!.toDouble(), truck.location!.longitude!.toDouble());
      });
    } else {
      print(response.body);
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
        title: const Text('Seguimiento de pedido'),
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 21),
        actionsIconTheme: const IconThemeData(color: Colors.white),
      ),

      body: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _truck,
          zoom: 15.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId(_truck.toString()),
            position: _truck,
            infoWindow: InfoWindow(
              title: 'Camión ${auth.truck.id}',
              snippet: 'Ubicación del camión: ${auth.truck.id}',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
          ),
          Marker(
            markerId: MarkerId(_store.toString()),
            position: _store,
            infoWindow: const InfoWindow(
              title: 'Ferretería',
              snippet: 'Ubicación de la Ferretería Juárez',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          ),
          Marker(
            markerId: const MarkerId('delivery1'),
            position: LatLng(widget.delivery.location!.latitude!.toDouble(), widget.delivery.location!.longitude!.toDouble()),
            infoWindow: InfoWindow(
              title: 'Entrega a: ${widget.client.nickname}',
              snippet: 'Dirección: ${widget.client.address}',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          ),
        }
      )

      /*body: Consumer(
        builder: (context, ref, _) {
          final providerStream = ref.watch(futureStream);
          final stateProvider = ref.watch(stateLocation);

          return providerStream.when(
              data: (res) {
                return Stack(
                  children: [
                    GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _store,
                        zoom: 12.0,
                      ),
                      markers: {
                        Marker(
                          markerId: MarkerId(_store.toString()),
                          position: _store,
                          infoWindow: const InfoWindow(
                            title: 'Ferretería',
                            snippet: 'Ubicación de la Ferretería Juárez',
                          ),
                          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
                        )
                      },
                    ),
                    StreamBuilder(
                      stream: HttpTrucks.instance.fetchLocation(res),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != '') {
                          final location = locationFromJson(snapshot.data!);
                          print(location.latitude);
                          print(location.longitude);
                          //ref.read(stateLocation.notifier).state = LatLng(location.latitude!.toDouble(), location.latitude!.toDouble());
                          //mapController.moveCamera(CameraUpdate.newLatLng(LatLng(location.latitude!.toDouble(), location.latitude!.toDouble())));
                          CameraPosition cPosition = CameraPosition(
                            zoom: 13,
                            target: LatLng(location.latitude!.toDouble(), location.latitude!.toDouble())
                          );
                          mapController.animateCamera(CameraUpdate.newCameraPosition(cPosition));
                          return Text('${location.latitude!.toDouble()}');
                        } else if (snapshot.hasError) {
                          return const Text('Error de comunicación. Reintentando...');
                        } else {
                          return const Text('Obteniendo ubicación...');
                        }
                      }
                    )
                  ],
                );
              },
              error: (error, stackTrace) => Text('$error'),
              loading: () => const LoadingWidget(title: 'Obteniendo datos...')
          );
        },
      ),*/

      /*body: Consumer(
        builder: (context, ref, _) {
          final providerStream = ref.watch(futureStream);

          return providerStream.when(
            data: (res) {
              return StreamBuilder(
                  stream: HttpTrucks.instance.fetchLocation(res),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != '') {
                      final location = locationFromJson(snapshot.data!);
                      final truck = LatLng(location.latitude!.toDouble(), location.latitude!.toDouble());
                      return GoogleMap(
                        myLocationEnabled: true,
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: _truck,
                          zoom: 16.0,
                        ),
                        markers: {
                          Marker(
                            markerId: MarkerId(_store.toString()),
                            position: _store,
                            infoWindow: const InfoWindow(
                              title: 'Ferretería',
                              snippet: 'Ubicación de la Ferretería Juárez',
                            ),
                            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
                          )
                        },
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text('Error de comunicación. Reintentando...')
                      );
                    } else {
                      return const LoadingWidget(title: 'Obteniendo ubicación...');
                    }
                  }
              );
            },
            error: (error, stackTrace) => Text('$error'),
            loading: () => const LoadingWidget(title: 'Cargando mapa...')
          );
        },
      ),*/
    );
  }
}
