import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String title;
  const LoadingWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          const CircularProgressIndicator()
        ],
      ),
    );
  }
}