import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sunrise_hosting/data/model/reservation_list_model.dart';
import 'package:sunrise_hosting/data/model/reservation_post_model.dart';
import 'package:sunrise_hosting/data/provider/reservation_provider.dart';
import 'package:http/http.dart' as http;
part 'reservation_state.dart';

class ReservationCubit extends Cubit<ReservationState> {
  ReservationCubit() : super(ReservationInitial());
  Future getReservationList() async {
    final ReservationProvider _ReservationProviderProvider =
        ReservationProvider();
    emit(ReservationStateLoading());
    try {
      // if (await AuthProvider().isTokenValid()) {
      //   // token est expiré, appelez refreshToken()
      //   await AuthProvider().refreshToken();
      // }
      var checkUrl = 'http://www.google.com';
      var checkResponse = await http.get(Uri.parse(checkUrl));
      if (checkResponse.statusCode == 200) {
        var result = await _ReservationProviderProvider.getListReservation();

        log('promtion+++++++++++++++++++++++++++++++++++++++++++++++++++++++${result.data}');
        result.data != null
            ? emit(ReservationStateLoaded(result))
            : emit(ReservationStateError('oups'));
      } else {
        emit(ReservationStateError('error'));
      }
    } catch (e) {
      log(e.toString());
      log('catch');
      emit(ReservationStateError(e.toString()));
    }
  }

  Future<void> getPostReservation({
    required String idHebergement,
    required String iduser,
    required String idpropio,
    required String dateDebut,
    required String montant,
    required String dateFin,
    required String reste,
    required String avance,
    required String nbrePerson,
  }) async {
    emit(ReservationPostStateLoading());
    try {
      // Votre logique actuelle pour gérer la réservation
      // ...
      // ...
      final ReservationProvider _ReservationProviderProvider =
          ReservationProvider();

      var checkUrl = 'http://www.google.com';
      var checkResponse = await http.get(Uri.parse(checkUrl));
      if (checkResponse.statusCode == 200) {
        var result = await _ReservationProviderProvider.getPostReservation(
            idHebergement,
            iduser,
            idpropio,
            dateDebut,
            montant,
            dateFin,
            reste,
            avance,
            nbrePerson);
        if (result != null) {
          // print(result);
          emit(ReservationPostStateLoaded(result));
        } else {
          emit(ReservationPostStateError('oups'));
        }
      } else {
        emit(ReservationPostStateError('oups verifiez votre connexion'));
      }
    } catch (e) {
      emit(ReservationStateError(e.toString()));
    }
  }
}
