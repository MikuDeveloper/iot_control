import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../model/api/http_trucks.dart';
import '../../model/entities/client.dart';
import '../../model/entities/delivery.dart';
import '../../model/entities/location.dart';

class EmployeeMap extends StatefulWidget {
  final Delivery delivery;
  final Client client;
  const EmployeeMap({super.key, required this.delivery, required this.client});

  @override
  State<EmployeeMap> createState() => _EmployeeMapState();
}

class _EmployeeMapState extends State<EmployeeMap> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  late Set<Marker> _markers = {};

  final CameraPosition _store = const CameraPosition(
    target: LatLng(19.6886321240918, -100.5346297590831),
    zoom: 16,
  );

  late CameraPosition _delivery = const CameraPosition(
    target: LatLng(0, 0),
    zoom: 19.151926040649414
  );

  late CameraPosition _truck = const CameraPosition(
      bearing: 192.8334901395799,
      //target: LatLng(37.43296265331129, -122.08832357078792),
      target: LatLng(19.6886321240918, -100.5346297590831),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414
  );

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
      Marker(
        markerId: const MarkerId('truck'),
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(widget.delivery.location!.latitude!.toDouble(), widget.delivery.location!.longitude!.toDouble()),
        infoWindow: InfoWindow(
          title: '${widget.client.nickname}',
          snippet: '${widget.client.address}',
        ),
      )
    };


    final stream = HttpTrucks.instance.fetchLocation();
    stream.asBroadcastStream().listen((String location) {
      final data = locationFromJson(location);
      final latitude = data.latitude!.toDouble();
      final longitude = data.longitude!.toDouble();
      //ref.read(stateLocation.notifier).state = LatLng(latitude, longitude);
      setState(() {
        _truck = CameraPosition(
          bearing: 192.8334901395799,
          //target: LatLng(37.43296265331129, -122.08832357078792),
          target: LatLng(latitude, longitude),
          tilt: 59.440717697143555,
          zoom: 19.151926040649414
        );

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
          Marker(
            markerId: const MarkerId('truck'),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(
              title: 'Camión ${widget.delivery.truck}',
              snippet: 'Última ubicación conocida',
            ),
          )
        };
      });
    });

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


  Future<void> _goToTruck() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_truck));
  }

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
        title: const Text('Seguimiento del pedido'),
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 21),
        actionsIconTheme: const IconThemeData(color: Colors.white)
      ),
      body: Stack(
        children: [
          GoogleMap(
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
                  ),
                  IconButton.filled(
                      onPressed: _goToTruck,
                      icon: const Icon(Icons.car_crash_sharp)
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
