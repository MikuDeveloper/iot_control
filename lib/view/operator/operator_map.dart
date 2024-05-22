import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../globals.dart';
import '../../model/entities/client.dart';
import '../../model/entities/delivery.dart';

class OperatorMap extends StatefulWidget {
  final Delivery delivery;
  final Client client;
  const OperatorMap({super.key, required this.delivery, required this.client});

  @override
  State<OperatorMap> createState() => _OperatorMapState();
}

class _OperatorMapState extends State<OperatorMap> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  late Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _markers = {
      Marker(
        markerId: const MarkerId('store'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        position: const LatLng(19.6886321240918, -100.5346297590831),
        infoWindow: const InfoWindow(
          title: 'Ferretería Juárez',
          snippet: 'Ubicación de la ferretería.',
        ),
      ),
      Marker(
        markerId: const MarkerId('delivery'),
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(widget.delivery.location!.latitude!.toDouble(), widget.delivery.location!.longitude!.toDouble()),
        infoWindow: InfoWindow(
          title: '${widget.client.nickname}',
          snippet: '${widget.client.address}',
        ),
      ),
    };

    _delivery = CameraPosition(
      bearing: 192.8334901395799,
      tilt: 59.440717697143555,
      target: LatLng(
        widget.delivery.location!.latitude!.toDouble(),
        widget.delivery.location!.longitude!.toDouble()
      ),
      zoom: 19.151926040649414
    );
  }

  final CameraPosition _store = const CameraPosition(
    target: LatLng(19.6886321240918, -100.5346297590831),
    zoom: 16,
  );

  /*final CameraPosition _truck = CameraPosition(
    bearing: 192.8334901395799,
    //target: LatLng(37.43296265331129, -122.08832357078792),
    target: LatLng(auth.truck.location!.latitude!.toDouble(), auth.truck.location!.longitude!.toDouble()),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414
  );*/

  late CameraPosition _delivery = CameraPosition(
      //bearing: 192.8334901395799,
      //target: LatLng(37.43296265331129, -122.08832357078792),
      target: LatLng(auth.truck.location!.latitude!.toDouble(), auth.truck.location!.longitude!.toDouble()),
      //tilt: 59.440717697143555,
      zoom: 19.151926040649414
  );


  /*Future<void> _goToTruck() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_truck));
  }*/

  Future<void> _goToDelivery() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_delivery));
  }

  Future<void> _goToStore() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_store));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubicación del pedido'),
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 21),
        actionsIconTheme: const IconThemeData(color: Colors.white)
      ),
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: _store,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: _markers,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton.filledTonal(
                    onPressed: _goToStore,
                    icon: const Icon(Icons.store_sharp)
                  ),
                  IconButton.filled(
                    onPressed: _goToDelivery,
                    icon: const Icon(Icons.delivery_dining_sharp)
                  )
                ],
              ),
            ),
          )
        ],
      )
      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToDelivery,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),*/
    );
  }
}
