import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iot_control/globals.dart';
import 'package:iot_control/model/providers/clients_provider.dart';

import '../../model/entities/client.dart';
import '../../model/entities/delivery.dart';
import '../../model/providers/deliveries_provider.dart';
import '../shared/loading_widget.dart';

class DeliveriesPage extends ConsumerWidget {
  const DeliveriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(deliveriesPendingProvider);
    return provider.when(
      data: (deliveries) {
        final provider2 = ref.watch(clientsProvider);
        return provider2.when(
          data: (clients) => DeliveriesDataPage(deliveries: deliveries, clients: clients),
          error: (error, stackTrace) => const DeliveriesErrorPage(),
          loading: () => const LoadingWidget(title: 'Cargando clientes...')
        );
      },
      error: (error, stackTrace) => const DeliveriesErrorPage(),
      loading: () => const LoadingWidget(title: 'Cargando datos de entregas...')
    );
  }
}

class DeliveriesDataPage extends ConsumerWidget {
  final List<Delivery> deliveries;
  final List<Client> clients;
  const DeliveriesDataPage({super.key, required this.deliveries, required this.clients});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: ref.read(deliveriesPendingProvider.notifier).loadPending,
      child: ListView.builder(
        itemCount: deliveries.length,
        itemBuilder: (context, index) {
          final client = clients.firstWhere((item) => item.uuid == deliveries[index].client);

          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              title: Text('${client.nickname}'),
              subtitle: Text('${client.address}'),
              trailing: IconButton(
                onPressed: () {
                  auth.truck = auth.truck.copyWith(id: deliveries[index].truck);
                  context.push(
                    '/home/delivery/map',
                    extra: { 'delivery': deliveries[index], 'client': client },
                  );
                },
                icon: const Icon(Icons.location_on)
              ),
            ),
          );
        },
      ),
    );
  }
}


class DeliveriesErrorPage extends ConsumerWidget {
  const DeliveriesErrorPage({super.key});

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
            onPressed: ref.read(deliveriesPendingProvider.notifier).loadPending,
            child: const Text('Reintentar')
          )
        ],
      ),
    );
  }
}

