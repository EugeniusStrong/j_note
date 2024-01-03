import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:j_note/data/auth_data/auth_data.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthenticationRemote authenticationRemote;
  ForgotPasswordBloc(this.authenticationRemote)
      : super(ForgotPasswordInitial()) {
    on<PressResetButton>((event, emit) {
      authenticationRemote.passwordReset(event.email, event.context);
      emit(ForgotPasswordHasReset());
    });
    on<ShowResetForm>((event, emit) {
      emit(ForgotPasswordInitial());
    });
  }
}
