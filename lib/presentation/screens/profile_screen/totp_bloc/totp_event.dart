import 'package:equatable/equatable.dart';

import '../../../../data/models/totp_model/on_totp_request_model.dart';

abstract class TotpEvent extends Equatable {
  const TotpEvent();

  @override
  List<Object?> get props => [];
}

class GetTotpEvent extends TotpEvent {}

class On2faEvent extends TotpEvent{
  final OnTotpRequestModel onTotpRequestModel;
  const On2faEvent({required this.onTotpRequestModel});
}
