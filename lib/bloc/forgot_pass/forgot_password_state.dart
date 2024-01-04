part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
}

class ForgotPasswordInitial extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class ForgotPasswordResetSuccess extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class ForgotPasswordFailed extends ForgotPasswordState {
  final Object error;

  const ForgotPasswordFailed({required this.error});
  @override
  List<Object> get props => [error];
}
