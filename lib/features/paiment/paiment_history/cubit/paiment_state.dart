part of 'paiment_cubit.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentStateLoading extends PaymentState {
  @override
  List<Object> get props => [];
}

class PaymentStateLoaded extends PaymentState {
  final PaymentModel response;
  PaymentStateLoaded(this.response);
  @override
  List<Object> get props => [response];
}

class PaymentStateError extends PaymentState {
  final String error;

  PaymentStateError(this.error);
  @override
  List<Object> get props => [error];
}
