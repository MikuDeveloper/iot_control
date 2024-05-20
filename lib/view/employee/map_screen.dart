import 'package:flutter/material.dart';

import '../../model/entities/client.dart';
import '../../model/entities/delivery.dart';

class MapScreen extends StatelessWidget {
  final Delivery delivery;
  final Client client;
  const MapScreen({super.key, required this.delivery, required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seguimiento de pedido'),
      ),
      body: const Placeholder(),
    );
  }
}
