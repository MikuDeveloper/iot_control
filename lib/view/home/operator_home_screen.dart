import 'package:flutter/material.dart';
import 'package:iot_control/view/operator/operator_deliveries.dart';

import '../../controller/login/logout_controller.dart';

class OperatorHomeScreen extends StatelessWidget {
  const OperatorHomeScreen({super.key});

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
