import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_control/model/providers/operators_provider.dart';

import '../../model/entities/user_entity.dart';

class OperatorsPage extends ConsumerWidget {
  const OperatorsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(operatorsProvider);
    return provider.when(
      data: (operators) => OperatorsDataPage(operators: operators),
      error: (error, stackTrace) => const OperatorsErrorPage(),
      loading: () => const OperatorsLoadingPage()
    );
  }
}

class OperatorsDataPage extends ConsumerWidget {
  final List<UserEntity> operators;
  const OperatorsDataPage({super.key, required this.operators});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: ref.read(operatorsProvider.notifier).loadOperators,
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: operators.length,
        itemBuilder: (BuildContext context, int index) {
          final firstname = operators[index].firstname ?? '';
          final lastname1 = operators[index].lastname1 ?? '';
          final lastname2 = operators[index].lastname1 ?? '';
          final name = '$firstname $lastname1 $lastname2'.trim();
          return Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text(name),
            )
          );
        }
      ),
    );
  }
}


class OperatorsErrorPage extends ConsumerWidget {
  const OperatorsErrorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Error al cargar datos de operadores'),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: ref.read(operatorsProvider.notifier).loadOperators,
            child: const Text('Reintentar')
          )
        ],
      ),
    );
  }
}

class OperatorsLoadingPage extends StatelessWidget {
  const OperatorsLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Cargando operadores...', style: TextStyle(fontSize: 20)),
          SizedBox(height: 20),
          CircularProgressIndicator()
        ],
      ),
    );
  }
}

