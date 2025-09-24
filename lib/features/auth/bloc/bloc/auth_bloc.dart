// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:booking_system/features/auth/model/register_model.dart';
import 'package:booking_system/features/auth/model/user_model.dart';
import 'package:booking_system/features/auth/service/login_service.dart';
import 'package:booking_system/features/auth/service/register_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  LoginService loginService;
  RegisterService registerService;
  AuthBloc({required this.loginService, required this.registerService})
    : super(AuthInitial()) {
    on<RegisterEvent>((event, emit) async {
      emit(LoadingState());
      bool status = await registerService.register(event.register);
      if (status) {
        emit(SuccessRegisterState());
      } else {
        emit(ErrorState());
      }
    });
    on<LoginEvent>((event, emit) async {
      emit(LoadingState());
      final user = await loginService.login(event.user);
      // ignore: unnecessary_null_comparison
      if (user != null) {
        emit(SuccessLoginState(user: user));
      } else {
        emit(ErrorState());
      }
    });
  }
}
