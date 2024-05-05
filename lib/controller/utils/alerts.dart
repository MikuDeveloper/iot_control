import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Alerts {
  static void openErrorDialog(context, String title, String content) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
        ),
        content: Text(content),
        actions: [
          FilledButton(
              onPressed: () => context.pop(),
              child: const Text('Aceptar')
          )
        ],
        icon: const Icon(Icons.error_rounded),
        iconColor: Colors.red,
      ),
    );
  }
}