part of 'google_map_place_cubit.dart';

abstract class GoogleMapPlaceState extends Equatable {
  const GoogleMapPlaceState();

  @override
  List<Object> get props => [];
}

class GoogleMapPlaceInitial extends GoogleMapPlaceState {}

class GoogleMapPlaceStateLoading extends GoogleMapPlaceState {
  @override
  List<Object> get props => [];
}

class GoogleMapPlaceStateLoaded extends GoogleMapPlaceState {
  const GoogleMapPlaceStateLoaded(this.places);
  final List<GooglePrediction> places;
  @override
  List<Object> get props => [places];
}

class GoogleMapPlaceStateError extends GoogleMapPlaceState {
  const GoogleMapPlaceStateError(this.error);

  final String error;
  @override
  List<Object> get props => [error];
}

class GoogleMapPlaceDetailStateLoading extends GoogleMapPlaceState {
  @override
  List<Object> get props => [];
}

class GoogleMapPlaceDetailStateLoaded extends GoogleMapPlaceState {
  const GoogleMapPlaceDetailStateLoaded(this.geo);
  final GooglePlaceDetails? geo;
  @override
  List<Object> get props => [geo!];
}

class GoogleMapPlaceDetailStateError extends GoogleMapPlaceState {
  const GoogleMapPlaceDetailStateError(this.error);

  final String error;
  @override
  List<Object> get props => [error];
}
