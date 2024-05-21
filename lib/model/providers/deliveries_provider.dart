import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_control/globals.dart';

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

final operatorDeliveriesProvider = StateNotifierProvider<OperatorDeliveriesNotifierProvider, AsyncValue<List<Delivery>>>((ref) => OperatorDeliveriesNotifierProvider());

class OperatorDeliveriesNotifierProvider extends StateNotifier<AsyncValue<List<Delivery>>> {
  OperatorDeliveriesNotifierProvider() : super(const AsyncValue.loading()) {
    loadOperatorDeliveries();
  }

  Future<void> loadOperatorDeliveries() async {
    if (mounted) {
      state = const AsyncValue.loading();
      try {
        final data = await HttpDeliveries.instance.getPendingByTruckId(auth.truck.id!);
        final List<dynamic> list = jsonDecode(data) as List<dynamic>;
        final deliveries = list.map((json) => Delivery.fromJson(json)).toList();
        state = AsyncValue.data(deliveries);
      } catch (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      }
    }
  }
}
