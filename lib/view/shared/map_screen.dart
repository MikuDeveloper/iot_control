import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iot_control/globals.dart';
import 'package:iot_control/model/api/http_trucks.dart';
import 'package:iot_control/model/entities/location.dart';
import 'package:iot_control/model/providers/location_provider.dart';
import 'package:iot_control/view/shared/loading_widget.dart';

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

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
      body: Consumer(
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
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: truck,
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
                          ),
                          Marker(
                            markerId: MarkerId(truck.toString()),
                            position: truck,
                            infoWindow: InfoWindow(
                              title: 'Camión $trucId',
                              snippet: 'Ubicación aproximada del camión $trucId',
                            ),
                            icon: BitmapDescriptor.defaultMarker,
                          ),
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
      ),
    );
  }
}
