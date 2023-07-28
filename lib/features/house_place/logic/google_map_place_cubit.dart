import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:sunrise_hosting/data/model/google_details_model.dart';
import 'package:sunrise_hosting/data/model/google_place_model.dart';
import 'package:sunrise_hosting/data/provider/google_map_data_provider.dart';
part 'google_map_place_state.dart';

class GoogleMapPlaceCubit extends Cubit<GoogleMapPlaceState> {
  GoogleMapPlaceCubit() : super(GoogleMapPlaceInitial());

  GoogleMapDataProvider apiRepository = GoogleMapDataProvider();
  Future searchPlaces(String query) async {
    log('loading...');
    emit(GoogleMapPlaceStateLoading());
    try {
      final result = await apiRepository.searchPlaces(query: query);
      log(result.toString());
      emit(GoogleMapPlaceStateLoaded(result));
    } catch (e) {
      emit(GoogleMapPlaceStateError(e.toString()));
    }
  }

  Future getPlaceDetailsFromId(String query) async {
    log('loading...');
    emit(GoogleMapPlaceDetailStateLoading());

    try {
      final result = await apiRepository.getPlaceDetailsFromId(
        id: query,
      );
      log(result.toString());
      emit(GoogleMapPlaceDetailStateLoaded(result));
    } catch (e) {
      emit(GoogleMapPlaceDetailStateError(e.toString()));
    }
  }
}
