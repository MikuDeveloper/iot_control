import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CloseDeliveryController extends ConsumerWidget {
  final String mode;
  const CloseDeliveryController({super.key, required this.mode});

  void closeDelivery(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Completar pedido'),
        content: const Text('¿El pedido se ha entregado exitosamente?'),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          OutlinedButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('No, volver.')
          ),
          OutlinedButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('Sí, cerrar.'),
          )
        ],
      ) 
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return (mode == 'icon') ?
    IconButton(
      onPressed: () => closeDelivery(context, ref), icon: const Icon(Icons.check_rounded),
    ) :
    FilledButton(
      onPressed: () => closeDelivery(context, ref), child: const Text('Marcar como entregado')
    );
  }
}
