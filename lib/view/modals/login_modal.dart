import 'package:flutter/material.dart';
import 'package:iot_control/controller/login/login_controller.dart';
import 'package:iot_control/controller/utils/validations.dart';

class LoginModal extends StatelessWidget {
  const LoginModal({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        useRootNavigator: true,
        builder: (context) => Padding(
          padding: EdgeInsets.only(
            top: 30,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 15
          ),
          child: const SingleChildScrollView(child: LoginForm())
        )
      ),
      label: const Text('Comenzar'),
      icon: const Icon(Icons.arrow_forward_rounded),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text('INICIO DE SESIÓN',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            )
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: Validations.emailValidation,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Correo electrónico',
              prefixIcon: Icon(Icons.email_rounded),
            ),
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: Validations.emptyOrNullValidation,
            obscureText: _obscureText,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Contraseña',
              prefixIcon: const Icon(Icons.key_rounded),
              suffixIcon: IconButton(
                onPressed: (){
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: _obscureText ?
                const Icon(Icons.visibility) :
                const Icon(Icons.visibility_off)
              )
            ),
          ),
          const SizedBox(height: 30),
          LoginController(
            formKey: _formKey,
            emailController: _emailController,
            passwordController: _passwordController
          )
        ],
      ),
    );
  }
}

