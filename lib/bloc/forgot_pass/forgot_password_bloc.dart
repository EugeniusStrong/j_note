import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:j_note/data/auth_data/auth_data.dart';

part 'forgot_password_event.dart';

part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthenticationRemote authenticationRemote;

  ForgotPasswordBloc(this.authenticationRemote)
      : super(ForgotPasswordInitial()) {
    on<ResetButtonPressed>((event, emit) async {
      final result = await authenticationRemote.passwordReset(event.email);
      if (result.isValue) {
        emit(ForgotPasswordResetSuccess());
      } else {
        emit(ForgotPasswordFailed(error: result.asError!.error));
      }
    });
  }
}
