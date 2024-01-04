import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:j_note/data/auth_data/auth_data.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationRemote authenticationRemote;

  RegisterBloc(this.authenticationRemote) : super(RegisterInitial()) {
    on<SignUpPressed>((event, emit) async {
      final result = await authenticationRemote.register(
        event.email,
        event.password,
      );
      if (result.isValue) {
        emit(RegisterSuccess());
      } else {
        emit(RegisterFailed(error: result.asError!.error));
      }
    });
  }
}
