part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();
}

class PressResetButton extends ForgotPasswordEvent {
  final String email;
  final BuildContext context;

  const PressResetButton({required this.context, required this.email});

  @override
  List<Object?> get props => [email];
}

class ShowResetForm extends ForgotPasswordEvent {
  @override
  List<Object?> get props => [];
}
