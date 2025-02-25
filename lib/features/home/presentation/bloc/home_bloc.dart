import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dukaandaar/features/auth/data/models/user_model.dart';
import 'package:dukaandaar/features/home/data/models/load_home_response.dart';
import 'package:dukaandaar/features/home/data/repositories/home_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/config/theme.dart';
import '../../../../core/local/hive_constants.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepositoryImpl homeRepositoryImpl;

  HomeBloc(this.homeRepositoryImpl) : super(HomeInitial()) {
    on<LoadHome>(_loadHome);
  }

  void _loadHome(LoadHome event, Emitter<HomeState> emit) async {
    try {
      String userString = await authBox.get(HiveKeys.userBox);
      String token = await authBox.get(HiveKeys.accessToken);
      User user = User.fromJson(jsonDecode(userString));
      final response = await homeRepositoryImpl.fetchKpi(user.id, token);
      if (response == null || response.data == null) {
        emit(LoadHomeFailure("No response from server"));
        return;
      }

      // Ensure data is always a Map<String, dynamic>
      final data = response.data['data'] is String
          ? jsonDecode(response.data['data'])
          : response.data['data'];
      final kpiResponse = HomeKpiResponse.fromJson(data);

      if (response.statusCode == 401) {
        emit(LoadHomeFailure("Login failed."));
        return;
      }
      emit(LoadHomeSuccess(kpiResponse));
    } catch (e, stacktrace) {
      print('Exception in bloc: $e');
      print('Stacktrace: $stacktrace');
      emit(LoadHomeFailure("An error occurred."));
    }
    return;
  }
}
