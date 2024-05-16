import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../globals.dart';
import '../../model/providers/user_provider.dart';
import '../login/login_screen.dart';
import 'employee_home_screen.dart';
import 'operator_home_screen.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(userProvider);
    return provider.when(
      data: (userData) {
        auth.setMessagingToken();
        switch (userData.role) {
          case 'E': return const EmployeeHomeScreen();
          case 'O': return const OperatorHomeScreen();
          default: return const LoginScreen();
        }
      },
      error: (error, stackTrace) {
        return const HomeScreenError();
      },
      loading: () => const HomeScreenLoading()
    );
  }
}

class HomeScreenError extends ConsumerWidget {
  const HomeScreenError({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Error al intentar cargar los datos de usuario.'),
            FilledButton(
              onPressed: ref.read(userProvider.notifier).loadData,
              child: const Text('Reintentar'),
            )
          ],
        ),
      ),
    );
  }
}

class HomeScreenLoading extends StatelessWidget {
  const HomeScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Cargando datos de usuario...', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}

