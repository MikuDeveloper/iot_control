import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iot_control/model/api/http_user.dart';
import 'package:iot_control/model/entities/user_entity.dart';

final operatorsProvider = StateNotifierProvider<OperatorsNotifierProvider, AsyncValue<List<UserEntity>>>((ref) => OperatorsNotifierProvider());

class OperatorsNotifierProvider extends StateNotifier<AsyncValue<List<UserEntity>>> {
  List<UserEntity> operatorsList = [];

  OperatorsNotifierProvider() : super(const AsyncValue.loading()) {
    if (mounted) loadOperators();
  }

  Future<void> loadOperators() async {
    if (mounted) {
      state = const AsyncValue.loading();
      try {
        final data = await HttpUser.instance.getOperators();
        final List<dynamic> list = jsonDecode(data) as List<dynamic>;
        final operators = list.map((json) => UserEntity.fromJson(json)).toList();
        operatorsList = operators;
        state = AsyncValue.data(operators);
      } catch (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      }
    }
  }
}