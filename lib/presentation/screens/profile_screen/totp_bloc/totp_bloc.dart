import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll/presentation/screens/profile_screen/totp_bloc/totp_event.dart';
import 'package:payroll/presentation/screens/profile_screen/totp_bloc/totp_state.dart';
import 'package:payroll/services/token_manager.dart';
import '../../../../domain/usecases/totp_usecase.dart';

class TotpBloc extends Bloc<TotpEvent, TotpState> {
  final GetTotpUseCase getTotpUseCase;

  TotpBloc({required this.getTotpUseCase}) : super(TotpState()) {
    on<GetTotpEvent>(_onGetTotp);
    on<On2faEvent>(_on2faEvent);
  }

  Future<void> _onGetTotp(GetTotpEvent event,
      Emitter<TotpState> emit) async {
    emit(TotpState(loginStatus: TotpStatus.loading));

    try {
      final success = await getTotpUseCase.getTotp();
      if (success.statusCode == 200) {
        emit(TotpState(loginStatus: TotpStatus.success,message: success.message,secretKey: success.data));
        // final accessToken = await TokenManager.getAccessToken();
        // final refreshToken = await TokenManager.getRefreshToken();
        // final employeeId = await TokenManager.getEmployeeId();
        // TokenManager.saveTokens(accessToken: accessToken ?? "", refreshToken: refreshToken ?? "", employeeId: employeeId ?? "",secretKey: success.data);
      }
      else {
        emit(TotpState(loginStatus: TotpStatus.failure,message: success.message));
      }
    } catch (e) {
      emit(TotpState(loginStatus: TotpStatus.failure,message: e.toString()));
    }
  }

  Future<void> _on2faEvent(On2faEvent event, Emitter<TotpState> emit) async {
    emit(TotpState(loginStatus: TotpStatus.loading, secretKey: state.secretKey));

    try {
      final success = await getTotpUseCase.on2faEvent(event.onTotpRequestModel);
      if (success.statusCode == 200) {
        // Assuming success.data contains the secretKey or use the one from event
        final newSecretKey = success.data ?? event.onTotpRequestModel.secretKey;
        emit(TotpState(
          loginStatus: TotpStatus.success,
          message: success.message,
          secretKey: newSecretKey, // Update secretKey in state
        ));
      } else {
        emit(TotpState(
          loginStatus: TotpStatus.failure,
          message: success.message,
          secretKey: state.secretKey, // Retain existing secretKey on failure
        ));
      }
    } catch (e) {
      emit(TotpState(
        loginStatus: TotpStatus.failure,
        message: e.toString(),
        secretKey: state.secretKey, // Retain existing secretKey on error
      ));
    }
  }
}
