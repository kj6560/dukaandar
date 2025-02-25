part of 'home_bloc.dart';

abstract class HomeState {}

final class HomeInitial extends HomeState {
  HomeInitial();
}

class LoadHomeSuccess extends HomeState {
  final HomeKpiResponse response;
  LoadHomeSuccess(this.response);
}

class LoadHomeFailure extends HomeState {
  final String error;
  LoadHomeFailure(this.error);
}
