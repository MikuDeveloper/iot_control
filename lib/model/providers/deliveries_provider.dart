import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/http_deliveries.dart';
import '../entities/delivery.dart';

final deliveriesPendingProvider = StateNotifierProvider<DeliveriesPendingNotifierProvider, AsyncValue<List<Delivery>>>((ref) => DeliveriesPendingNotifierProvider());

class DeliveriesPendingNotifierProvider extends StateNotifier<AsyncValue<List<Delivery>>> {
  DeliveriesPendingNotifierProvider() : super(const AsyncValue.loading()) {
    loadPending();
  }

  Future<void> loadPending() async {
    if (mounted) {
      state = const AsyncValue.loading();
      try {
        final data = await HttpDeliveries.instance.getPending();
        final List<dynamic> list = jsonDecode(data) as List<dynamic>;
        final deliveries = list.map((json) => Delivery.fromJson(json)).toList();
        state = AsyncValue.data(deliveries);
      } catch (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      }
    }
  }
}