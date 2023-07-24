part of 'hebergement_cubit.dart';

abstract class HebergementState extends Equatable {
  const HebergementState();

  @override
  List<Object> get props => [];
}

class HebergementInitial extends HebergementState {}

class HebergementStateLoading extends HebergementState {
  @override
  List<Object> get props => [];
}

class HebergementStateLoaded extends HebergementState {
  final HebergementModel response;
  HebergementStateLoaded(this.response);
  @override
  List<Object> get props => [response];
}

class HebergementStateError extends HebergementState {
  final String error;

  HebergementStateError(this.error);
  @override
  List<Object> get props => [error];
}
