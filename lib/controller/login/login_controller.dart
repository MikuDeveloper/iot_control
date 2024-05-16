import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iot_control/controller/utils/alerts.dart';
import 'package:iot_control/controller/utils/interfaces.dart';

import '../../globals.dart';

class LoginController extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginController({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController
  });

  @override
  State<LoginController> createState() => _LoginControllerState();
}

class _LoginControllerState extends State<LoginController> implements Loading {
  _login() {
    if (widget.formKey.currentState!.validate()) {
      turnOnLoading();
      auth.login(email: widget.emailController.text, password: widget.passwordController.text)
        .then((token) {
          context.go('/home');
        })
        .catchError((error, stackTrace) {
          var message = error.message['message'];
          if (message.runtimeType == List) {
            message = 'El correo electrónico proporcionado no es válido.';
          }
          Alerts.openErrorDialog(
              context,
              'ERROR DE INICIO DE SESIÓN',
              message
          );
        }).whenComplete(() => turnOffLoading());
    }
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading) ?
    const CircularProgressIndicator() :
    FilledButton(
      onPressed: _login,
      child: const Text('Ingresar'),
    );
  }

  @override
  bool isLoading = false;

  @override
  void turnOffLoading() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void turnOnLoading() {
    setState(() {
      isLoading = true;
    });
  }
}
