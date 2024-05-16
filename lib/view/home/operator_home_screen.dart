import 'package:flutter/material.dart';

import '../../controller/login/logout_controller.dart';

class OperatorHomeScreen extends StatelessWidget {
  const OperatorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          LogoutController()
        ],
      ),
      body: const Center(
        child: Text('Pantalla del operador.'),
      ),
    );
  }
}
