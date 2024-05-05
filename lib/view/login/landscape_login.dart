import 'package:flutter/material.dart';
import 'package:iot_control/controller/login/login_controller.dart';
import 'package:iot_control/view/modals/login_modal.dart';

import '../../generated/assets.dart';

class LandscapeLogin extends StatelessWidget {
  const LandscapeLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7),
            child: Image.asset(Assets.iconsLogo),
          ),
          const Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('IOT',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 60,
                      color: Color.fromRGBO(0, 127, 175, 1))),
              Text('Control',
                  style: TextStyle(
                      fontSize: 60, color: Color.fromRGBO(0, 127, 175, 1))),
              SizedBox(height: 10),
              LoginModal()
            ],
          )
        ],
      ),
    );
  }
}
