import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/repositories/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email, message: '', loginStatus: LoginStatus.initial));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password, message: '', loginStatus: LoginStatus.initial));
  }

  Future<void> _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    if (state.email.isEmpty || state.password.isEmpty) {
      emit(state.copyWith(
        loginStatus: LoginStatus.failure,
        message: 'Email and password cannot be empty',
      ));
      return;
    }

    emit(state.copyWith(isLoading: true, loginStatus: LoginStatus.loading, message: ''));

    try {
      await authRepository.login(email: state.email, password: state.password);
      emit(state.copyWith(
        isLoading: false,
        loginStatus: LoginStatus.success,
        message: 'Login successful!',
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        loginStatus: LoginStatus.failure,
        message: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }
}
