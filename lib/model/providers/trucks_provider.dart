import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_control/model/api/http_trucks.dart';
import 'package:iot_control/model/entities/truck.dart';

final trucksProvider = StateNotifierProvider<TrucksNotifierProvider, AsyncValue<List<Truck>>>((ref) => TrucksNotifierProvider());

class TrucksNotifierProvider extends StateNotifier<AsyncValue<List<Truck>>> {
  List<Truck> listTrucks = [];

  TrucksNotifierProvider() : super (const AsyncValue.loading()) {
    if (mounted) loadTrucks();
  }

  Future<void> loadTrucks() async {
    if (mounted) {
      state = const AsyncValue.loading();
      try {
        final data = await HttpTrucks.instance.getTrucks();
        final List<dynamic> list = jsonDecode(data) as List<dynamic>;
        final trucks = list.map((truck) => Truck.fromJson(truck)).toList();
        listTrucks = trucks;
        state = AsyncValue.data(trucks);
      } catch (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      }
    }
  }
}