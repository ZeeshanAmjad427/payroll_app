import 'package:bloc/bloc.dart';
import 'package:payroll/presentation/screens/profile_screen/totp_bloc/totp_event.dart';
import 'package:payroll/presentation/screens/profile_screen/totp_bloc/totp_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../domain/usecases/totp_usecase.dart';
import '../../../../services/token_manager.dart';

class TotpBloc extends Bloc<TotpEvent, TotpState> {
  final GetTotpUseCase getTotpUseCase;

  TotpBloc({required this.getTotpUseCase}) : super(TotpState()) {
    on<GetTotpEvent>(_onGetTotp);
    on<On2faEvent>(_on2faEvent);
    on<OnRemove2faEvent>(_on2faRemoveEvent);
    on<VerifyTotpEvent>(_verifyTotp);
  }

  Future<void> _onGetTotp(GetTotpEvent event, Emitter<TotpState> emit) async {
    emit(state.copyWith(loginStatus: TotpStatus.loading));

    try {
      final success = await getTotpUseCase.getTotp();
      if (success.statusCode == 200) {
        final secretKey = success.data is String ? success.data as String : '';
        await TokenManager.setSecretKey(secretKey);
        emit(state.copyWith(
          loginStatus: TotpStatus.removeSuccess,
          message: success.message,
          secretKey: secretKey,
        ));
      } else {
        emit(state.copyWith(
          loginStatus: TotpStatus.failure,
          message: success.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        loginStatus: TotpStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _on2faEvent(On2faEvent event, Emitter<TotpState> emit) async {
    emit(state.copyWith(loginStatus: TotpStatus.loading));

    try {
      final success = await getTotpUseCase.on2faEvent(event.onTotpRequestModel);
      print('On2faEvent Response: statusCode=${success.statusCode}, data=${success.data}');
      if (success.statusCode == 201) {
        // Use the input secretKey since data is bool
        final newSecretKey = event.onTotpRequestModel.secretKey;
        await TokenManager.setSecretKey(newSecretKey);
        await TokenManager.setTotpVerified(true); // Use setIsTotp
        emit(state.copyWith(
          loginStatus: TotpStatus.success,
          message: success.message,
          secretKey: newSecretKey,
          isTotp: true,
        ));
        print('On2faEvent Emitted: isTotp=true, secretKey=$newSecretKey');
      } else {
        emit(state.copyWith(
          loginStatus: TotpStatus.failure,
          message: success.message,
          isTotp: await TokenManager.getIsTotp() ?? false,
        ));
        print('On2faEvent Failed: message=${success.message}');
      }
    } catch (e) {
      emit(state.copyWith(
        loginStatus: TotpStatus.failure,
        message: e.toString(),
        isTotp: await TokenManager.getIsTotp() ?? false,
      ));
      print('On2faEvent Error: $e');
    }
  }
  Future<void> _on2faRemoveEvent(OnRemove2faEvent event, Emitter<TotpState> emit) async {
    emit(state.copyWith(loginStatus: TotpStatus.loading));

    try {
      final success = await getTotpUseCase.on2faRemoveEvent(event.userId);
      if (success.statusCode == 201) {
        await TokenManager.setSecretKey('');
        await TokenManager.setTotpVerified(false);
        emit(state.copyWith(
          loginStatus: TotpStatus.success,
          message: success.message,
          secretKey: '',
          isTotp: false,
        ));
        add(GetTotpEvent());
      } else {
        emit(state.copyWith(
          loginStatus: TotpStatus.failure,
          message: success.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        loginStatus: TotpStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _verifyTotp(VerifyTotpEvent event, Emitter<TotpState> emit) async {
    emit(state.copyWith(loginStatus: TotpStatus.loading));

    try {
      final success = await getTotpUseCase.verifyTotp(event.verifyTotpRequestModel);
      final prefs = await SharedPreferences.getInstance();

      if (success.statusCode == 200) {
        if (success.data!.isVerified) {
          await prefs.setBool('isLoggedIn', true);
        }

        emit(state.copyWith(
          loginStatus: TotpStatus.success,
          message: success.message,
          verifyTotpResponseModel: success,
        ));
      } else {
        emit(state.copyWith(
          loginStatus: TotpStatus.failure,
          message: success.message,
          verifyTotpResponseModel: success,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        loginStatus: TotpStatus.failure,
        message: e.toString(),
      ));
    }
  }
}
