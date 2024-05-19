import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/entities/truck.dart';
import '../../model/entities/user_entity.dart';
import '../../model/providers/operators_provider.dart';
import '../../model/providers/trucks_provider.dart';
import '../shared/loading_widget.dart';


class TrucksPage extends ConsumerWidget {
  const TrucksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(trucksProvider);
    return provider.when(
      data: (trucks) {
        final provider2 = ref.watch(operatorsProvider);
        return provider2.when(
          data: (operators) => TrucksDataPage(trucks: trucks, operators: operators),
          error: (error, stackTrace) => const TrucksErrorPage(),
          loading: () => const LoadingWidget(title: 'Obteniendo datos de operadores...')
        );
      },
      error: (error, stackTrace) => const TrucksErrorPage(),
      loading: () => const LoadingWidget(title: 'Obteniendo datos de camiones...')
    );
  }
}

class TrucksDataPage extends ConsumerWidget {
  final List<Truck> trucks;
  final List<UserEntity> operators;
  const TrucksDataPage({super.key, required this.trucks, required this.operators});

  Color setColorCard(String status) {
    switch (status) {
      case 'Libre': return Colors.lightGreen;
      case 'En viaje': return Colors.lightBlue;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: ref.read(trucksProvider.notifier).loadTrucks,
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: trucks.length,
        itemBuilder: (context, index) {
          final id = trucks[index].id;
          final uuid = trucks[index].operator;
          final location = trucks[index].location;
          final status = trucks[index].status;
          final operator = operators.firstWhere((item) => item.uuid == uuid);
          final firstname = operator.firstname ?? '';
          final lastname1 = operator.lastname1 ?? '';
          final lastname2 = operator.lastname2 ?? '';
          final name = '$firstname $lastname1 $lastname2'.trim();

          return Card(
            //color: setColorCard(status!),
            child: ListTile(
              title: Text('Camión: $id', style: const TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Operador: $name'),
                  Text('Ubicación: ${location?.latitude}, ${location?.longitude}'),
                  Text('Estado: $status'),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}

class TrucksErrorPage extends ConsumerWidget {
  const TrucksErrorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Error al cargar datos de camiones'),
          const SizedBox(height: 20),
          FilledButton(
              onPressed: ref.read(trucksProvider.notifier).loadTrucks,
              child: const Text('Reintentar')
          )
        ],
      ),
    );
  }
}
