part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();
}

class ResetButtonPressed extends ForgotPasswordEvent {
  final String email;

  const ResetButtonPressed({required this.email});

  @override
  List<Object?> get props => [email];
}
