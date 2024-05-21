import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_control/globals.dart';
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

final truckByOperatorProvider = StateNotifierProvider<TruckNotifier, AsyncValue<Truck>>((ref) => TruckNotifier());

class TruckNotifier extends StateNotifier<AsyncValue<Truck>> {
  TruckNotifier() : super(const AsyncValue.loading()) {
    loadTruck();
  }

  Future<void> loadTruck() async {
    if (mounted) {
      state = const AsyncValue.loading();
      try {
        final data = await HttpTrucks.instance.getTruckByOperator(auth.payload.uuid!);
        final truck = Truck.fromJson(jsonDecode(data));
        state = AsyncValue.data(truck);
      } catch (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      }
    }
  }
}
