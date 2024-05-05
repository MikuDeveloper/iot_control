import 'package:flutter/material.dart';
import 'package:iot_control/view/modals/login_modal.dart';

import '../../generated/assets.dart';

class PortraitLogin extends StatelessWidget {
  const PortraitLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('IOT',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 60,
                  color: Color.fromRGBO(0, 127, 175, 1))),
          const Text('Control',
              style: TextStyle(
                  fontSize: 45, color: Color.fromRGBO(0, 127, 175, 1))),
          const SizedBox(height: 30),
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.width * 0.7),
            child: Image.asset(Assets.iconsLogo),
          ),
          const SizedBox(height: 20),
          const LoginModal()
        ],
      ),
    );
  }
}
