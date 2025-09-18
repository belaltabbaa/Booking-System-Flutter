part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class RegisterOrderEvent extends HomeEvent {
  final OrderModel order;
  RegisterOrderEvent(this.order);
}
