import 'package:flutter/material.dart';

import '../../controller/login/logout_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Column(
          children: [
            LogoutController(),
          ],
        ),
      ),
    );
  }
}
