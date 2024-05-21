import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iot_control/controller/operator/close_delivery.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/entities/client.dart';
import '../../model/entities/delivery.dart';

class DeliveryDetailsScreen extends StatelessWidget {
  final Delivery delivery;
  final Client client;
  const DeliveryDetailsScreen({super.key, required this.delivery, required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de entrega'),
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 21),
        actionsIconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          const Text('Cliente:', style: TextStyle(fontWeight: FontWeight.bold)),
          Card(child: ListTile(title: Text('${client.nickname}'))),
          const SizedBox(height: 15),

          const Text('Materiales:', style: TextStyle(fontWeight: FontWeight.bold)),
          Card(child: ListTile(title: Text('${client.nickname}'))),
          const SizedBox(height: 15),

          const Text('Dirección:', style: TextStyle(fontWeight: FontWeight.bold)),
          Card(
            child: ListTile(
              title: Text('${client.address}'),
              trailing: IconButton(
                onPressed: () {
                  context.push(
                    '/home/delivery/map',
                    extra: { 'delivery': delivery, 'client': client },
                  );
                },
                icon: const Icon(Icons.location_on)
              )
            )
          ),
          const SizedBox(height: 15),

          const Text('Referencia:', style: TextStyle(fontWeight: FontWeight.bold)),
          Card(child: ListTile(title: Text('${client.reference}'))),
          const SizedBox(height: 15),

          const Text('Contacto:', style: TextStyle(fontWeight: FontWeight.bold)),
          Card(
            child: ListTile(
              title: Text('${client.contact}'),
              trailing: IconButton(
                onPressed: () async {
                  final path = '${client.contact}';
                  final uri = Uri(scheme: 'tel', path: path);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  } else {

                  }
                },
                icon: const Icon(Icons.phone_in_talk_rounded),
              )
            )
          ),
          const SizedBox(height: 30),

          const CloseDeliveryController(mode: 'text'),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
