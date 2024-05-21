import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_control/model/providers/clients_provider.dart';
import 'package:iot_control/model/providers/deliveries_provider.dart';
import 'package:iot_control/model/providers/operators_provider.dart';
import 'package:iot_control/model/providers/trucks_provider.dart';

import '../../model/providers/user_provider.dart';
import 'landscape_login.dart';
import 'portrait_login.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (MediaQuery.of(context).orientation == Orientation.portrait) {
            ref.invalidate(userProvider);
            ref.invalidate(trucksProvider);
            ref.invalidate(truckByOperatorProvider);
            ref.invalidate(operatorsProvider);
            ref.invalidate(operatorDeliveriesProvider);
            ref.invalidate(deliveriesPendingProvider);
            ref.invalidate(clientsProvider);
            return const PortraitLogin();
          } else {
            ref.invalidate(userProvider);
            ref.invalidate(trucksProvider);
            ref.invalidate(truckByOperatorProvider);
            ref.invalidate(operatorsProvider);
            ref.invalidate(operatorDeliveriesProvider);
            ref.invalidate(deliveriesPendingProvider);
            ref.invalidate(clientsProvider);
            return const LandscapeLogin();
          }
        }
      ),
    );
  }
}
