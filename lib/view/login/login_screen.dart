import 'package:flutter/material.dart';

import 'landscape_login.dart';
import 'portrait_login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) =>
        (MediaQuery.of(context).orientation == Orientation.portrait) ?
        const PortraitLogin() : const LandscapeLogin(),
      ),
    );
  }
}
