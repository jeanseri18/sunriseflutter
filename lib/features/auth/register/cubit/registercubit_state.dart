part of 'registercubit_cubit.dart';

abstract class RegistercubitState extends Equatable {
  const RegistercubitState();

  @override
  List<Object> get props => [];
}

class RegistercubitInitial extends RegistercubitState {}

class RegisterStateLoading extends RegistercubitState {
  @override
  List<Object> get props => [];
}

class RegisterStateLoaded extends RegistercubitState {
  final ApiResponse response;
  RegisterStateLoaded(this.response);
  @override
  List<Object> get props => [response];
}

class RegisterStateError extends RegistercubitState {
  final String error;

  RegisterStateError(this.error);
  @override
  List<Object> get props => [error];
}
