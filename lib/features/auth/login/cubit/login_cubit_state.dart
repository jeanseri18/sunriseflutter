part of 'login_cubit_cubit.dart';

abstract class LoginCubitState extends Equatable {
  const LoginCubitState();

  @override
  List<Object> get props => [];
}

class LoginCubitInitial extends LoginCubitState {}

class LoginStateLoading extends LoginCubitState {
  @override
  List<Object> get props => [];
}

class LoginStateLoaded extends LoginCubitState {
  final ApiResponse response;
  LoginStateLoaded(this.response);
  @override
  List<Object> get props => [response];
}

class LoginStateError extends LoginCubitState {
  final String error;

  LoginStateError(this.error);
  @override
  List<Object> get props => [error];
}

class LoginOtpStateLoading extends LoginCubitState {
  @override
  List<Object> get props => [];
}

class LoginOtpStateLogout extends LoginCubitState {
  @override
  List<Object> get props => [];
}
