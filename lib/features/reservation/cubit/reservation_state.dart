part of 'reservation_cubit.dart';

abstract class ReservationState extends Equatable {
  const ReservationState();

  @override
  List<Object> get props => [];
}

class ReservationInitial extends ReservationState {}

class ReservationStateLoading extends ReservationState {
  @override
  List<Object> get props => [];
}

class ReservationStateLoaded extends ReservationState {
  final ReservationListModel response;
  ReservationStateLoaded(this.response);
  @override
  List<Object> get props => [response];
}

class ReservationStateError extends ReservationState {
  final String error;

  ReservationStateError(this.error);
  @override
  List<Object> get props => [error];
}

class ReservationPostStateLoading extends ReservationState {
  @override
  List<Object> get props => [];
}

class ReservationPostStateError extends ReservationState {
  final String error;

  ReservationPostStateError(this.error);
  @override
  List<Object> get props => [error];
}

class ReservationPostStateLoaded extends ReservationState {
  final ReservationPostModel response;
  ReservationPostStateLoaded(this.response);
  @override
  List<Object> get props => [response];
}
