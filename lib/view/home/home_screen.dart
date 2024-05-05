import 'package:flutter/material.dart';

import '../../controller/login/logout_controller.dart';
import '../../globals.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    preferences.getToken().then((token) {
      preferences.getPayload().then((payload) {
        notifications.setNotificationToken(token!, payload!.uuid!);
      });
    });
  }

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
