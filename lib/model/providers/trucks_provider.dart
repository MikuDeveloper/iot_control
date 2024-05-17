import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_control/model/entities/truck.dart';

final trucksProvider = StateNotifierProvider<TrucksNotifierProvider, AsyncValue<List<Truck>>>((ref) => TrucksNotifierProvider());

class TrucksNotifierProvider extends StateNotifier<AsyncValue<List<Truck>>> {
  TrucksNotifierProvider() : super (const AsyncValue.loading()) {
    if (mounted) loadTrucks();
  }

  Future<void> loadTrucks() async {
    if (mounted) {
      state = const AsyncValue.loading();
      try {

      } catch (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      }
    }
  }
}