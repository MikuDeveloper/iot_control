import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            return const PortraitLogin();
          } else {
            ref.invalidate(userProvider);
            return const LandscapeLogin();
          }
        }
      ),
    );
  }
}
