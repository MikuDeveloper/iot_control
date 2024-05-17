import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_control/model/api/http_user.dart';

import '../entities/user_entity.dart';

final userProvider = StateNotifierProvider<UserNotifierProvider, AsyncValue<UserEntity>>((ref) => UserNotifierProvider());

class UserNotifierProvider extends StateNotifier<AsyncValue<UserEntity>> {
  UserNotifierProvider() : super(const AsyncValue.loading()) {
    if (mounted) loadData();
  }

  Future<void> loadData() async {
    if (mounted) {
      state = const AsyncValue.loading();
      try {
        final data = await HttpUser.instance.getData();
        state = AsyncValue.data(userEntityFromJson(data));
      } catch (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      }
    }
  }
}