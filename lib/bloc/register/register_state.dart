part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterSuccess extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterFailed extends RegisterState {
  final Object error;

  const RegisterFailed({required this.error});
  @override
  List<Object> get props => [error];
}
