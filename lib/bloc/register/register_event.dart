part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class SignUpPressed extends RegisterEvent {
  final String email;
  final String password;
  final String confirm;

  const SignUpPressed({
    required this.confirm,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class SingUpScreenShow extends RegisterEvent {
  @override
  List<Object?> get props => [];
}
