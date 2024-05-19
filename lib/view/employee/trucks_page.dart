import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_control/model/entities/truck.dart';
import 'package:iot_control/model/providers/trucks_provider.dart';
import 'package:iot_control/view/shared/loading_widget.dart';

class TrucksPage extends ConsumerWidget {
  const TrucksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(trucksProvider);
    return provider.when(
      data: (trucks) => TrucksDataPage(trucks: trucks),
      error: (error, stackTrace) => const TrucksErrorPage(),
      loading: () => const LoadingWidget(title: 'Obteniendo datos de camiones...')
    );
  }
}

class TrucksDataPage extends ConsumerWidget {
  final List<Truck> trucks;
  const TrucksDataPage({super.key, required this.trucks});

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
          final operator = trucks[index].operator;
          final location = trucks[index].location;
          final status = trucks[index].status;
          return Card(
            color: setColorCard(status!),
            child: ListTile(
              title: Text('Camión: $id'),
              subtitle: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Operador: $operator'),
                  Text('Ubicación: $location'),
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
