import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../globals.dart';
import '../../model/entities/client.dart';
import '../../model/entities/delivery.dart';
import '../../model/providers/clients_provider.dart';
import '../../model/providers/deliveries_provider.dart';
import '../../model/providers/trucks_provider.dart';
import '../shared/loading_widget.dart';

class OperatorDeliveries extends ConsumerWidget {
  const OperatorDeliveries({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(truckByOperatorProvider);
    return provider.when(
        data: (truck) {
          auth.truck = truck;
          final provider2 = ref.watch(operatorDeliveriesProvider);
          return provider2.when(
              data: (deliveries) {
                final provider3 = ref.watch(clientsProvider);
                return provider3.when(
                    data: (clients) => OperatorDeliveriesData(deliveries, clients),
                    error: (error, stackTrace) {
                      return const OperatorDeliveriesError();
                    },
                    loading: () => const LoadingWidget(title: 'Cargando clientes...')
                );
              },
              error: (error, stackTrace) {
                return const OperatorDeliveriesError();
              },
              loading: () => const LoadingWidget(title: 'Cargando pedidos...')
          );
        },
        error: (error, stackTrace) {
          return const OperatorDeliveriesError();
        },
        loading: () => const LoadingWidget(title: 'Cargando datos de camión...')
    );
  }
}

class OperatorDeliveriesData extends ConsumerWidget {
  final List<Delivery> deliveries;
  final List<Client> clients;
  const OperatorDeliveriesData(this.deliveries, this.clients, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: ref.watch(operatorDeliveriesProvider.notifier).loadOperatorDeliveries,
      child: ListView.builder(
        itemCount: deliveries.length,
        itemBuilder: (BuildContext context, int index) {
          final client = clients.firstWhere((item) => item.uuid == deliveries[index].client);

          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              title: Text('${client.nickname}', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dirección: ${client.address}'),
                  Text('Contacto: ${client.contact}')
                ],
              ),
              trailing: IconButton(
                onPressed: () {
                  context.push(
                    '/home/delivery/map',
                    extra: { 'delivery': deliveries[index], 'client': client },
                  );
                },
                icon: const Icon(Icons.location_on)
              ),
              onTap: () {
                context.push(
                  '/home/delivery/details',
                  extra: { 'delivery': deliveries[index], 'client': client }
                );
              }
            ),
          );
        },
      ),
    );
  }
}


class OperatorDeliveriesError extends ConsumerWidget {
  const OperatorDeliveriesError({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Error al cargar datos de entregas'),
          const SizedBox(height: 20),
          FilledButton(
              onPressed: ref.read(operatorDeliveriesProvider.notifier).loadOperatorDeliveries,
              child: const Text('Reintentar')
          )
        ],
      ),
    );
  }
}
