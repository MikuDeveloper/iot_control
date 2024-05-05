import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../globals.dart';


class LogoutController extends StatefulWidget {
  const LogoutController({super.key});

  @override
  State<LogoutController> createState() => _LogoutControllerState();
}

class _LogoutControllerState extends State<LogoutController> {
  _logout () {
    auth.logout().then((value) => context.go('/login'));
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _logout,
      icon: const Icon(Icons.arrow_back)
    );
  }
}
