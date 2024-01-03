part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class SignInPressed extends AuthEvent {
  final String email;
  final String password;

  const SignInPressed({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class SingInScreenShow extends AuthEvent {
  @override
  List<Object?> get props => [];
}
