import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll/services/token_manager.dart';
import '../../../../domain/repositories/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(const LoginState()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(
      isLoading: true,
      loginStatus: LoginStatus.loading,
      message: '',
    ));

    try {
      final response = await authRepository.login(
        email: event.email,
        password: event.password,
      );

      if (response.statusCode == 200 && response.isRequestSuccess) {
        TokenManager.saveTokens(
            accessToken: response.data?.token ?? "",
            refreshToken: response.data?.refreshToken ?? "",
            employeeId: response.data?.roleAndActions[0].id ?? "");
        emit(state.copyWith(
          email: event.email,
          password: event.password,
          isLoading: false,
          loginStatus: LoginStatus.success,
          message: response.message,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          loginStatus: LoginStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        loginStatus: LoginStatus.failure,
        message: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }
}
