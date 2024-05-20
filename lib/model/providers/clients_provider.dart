import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/http_clients.dart';
import '../entities/client.dart';

final clientsProvider = StateNotifierProvider<ClientsNotifierProvider, AsyncValue<List<Client>>>((ref) => ClientsNotifierProvider());

class ClientsNotifierProvider extends StateNotifier<AsyncValue<List<Client>>> {
  ClientsNotifierProvider() : super(const AsyncValue.loading()) {
    loadClients();
  }

  Future<void> loadClients() async {
    if (mounted) {
      state = const AsyncValue.loading();
      try {
        final data = await HttpClients.instance.getClients();
        final List<dynamic> list = jsonDecode(data) as List<dynamic>;
        final clients = list.map((json) => Client.fromJson(json)).toList();
        state = AsyncValue.data(clients);
      } catch (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      }
    }
  }
}