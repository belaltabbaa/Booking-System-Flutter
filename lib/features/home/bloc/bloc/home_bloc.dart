import 'package:booking_system/features/home/model/order_model.dart';
import 'package:booking_system/features/home/service/order_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  OrderService orderService;
  HomeBloc({required this.orderService}) : super(HomeInitial()) {
    on<RegisterOrderEvent>((event, emit) async {
      emit(LoadingState());
      final result = await orderService.registerOrder(event.order);
      emit(
        SuccessRegisterorder(
          message: result['message'] ?? '',
          userRemaining: result['userRemaining'] ?? 0,
          systemRemaining: result['systemRemaining'] ?? 0,
          success: result['success'] ?? false, 
        ),
      );
    });
  }
}
