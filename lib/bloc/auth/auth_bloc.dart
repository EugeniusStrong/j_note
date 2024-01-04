import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:j_note/data/auth_data/auth_data.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRemote authenticationRemote;

  AuthBloc(this.authenticationRemote) : super(AuthInitial()) {
    on<SignInPressed>((event, emit) async {
      final result =
          await authenticationRemote.login(event.email, event.password);
      if (result.isValue) {
        emit(AuthSuccess());
      } else {
        emit(AuthError(error: result.asError!.error));
      }
    });
  }
}
