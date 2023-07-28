import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sunrise_hosting/data/model/hebergement_list_model.dart';
import 'package:sunrise_hosting/data/provider/hebergement_prodiver.dart';
import 'package:http/http.dart' as http;
part 'hebergement_state.dart';

class HebergementCubit extends Cubit<HebergementState> {
  HebergementCubit() : super(HebergementInitial());
  Future getHebergementList() async {
    final HebergementProvider _HebergementProviderProvider =
        HebergementProvider();
    emit(HebergementStateLoading());
    try {
      // if (await AuthProvider().isTokenValid()) {
      //   // token est expiré, appelez refreshToken()
      //   await AuthProvider().refreshToken();
      // }
      var checkUrl = 'http://www.google.com';
      var checkResponse = await http.get(Uri.parse(checkUrl));
      if (checkResponse.statusCode == 200) {
        var result = await _HebergementProviderProvider.getListHebergement();

        // log('promtion+++++++++++++++++++++++++++++++++++++++++++++++++++++++${result}');
        result.data != null
            ? emit(HebergementStateLoaded(result))
            : emit(HebergementStateError('oups'));
      } else {
        emit(HebergementStateError('error'));
      }
    } catch (e) {
      log(e.toString());
      log('catch');
      emit(HebergementStateError(e.toString()));
    }
  }

  Future getListHebergementByType(String type) async {
    final HebergementProvider _HebergementProviderProvider =
        HebergementProvider();
    emit(HebergementStateLoading());
    try {
      // if (await AuthProvider().isTokenValid()) {
      //   // token est expiré, appelez refreshToken()
      //   await AuthProvider().refreshToken();
      // }
      var checkUrl = 'http://www.google.com';
      var checkResponse = await http.get(Uri.parse(checkUrl));
      if (checkResponse.statusCode == 200) {
        var result =
            await _HebergementProviderProvider.getListHebergementByType(type);

        // log('promtion+++++++++++++++++++++++++++++++++++++++++++++++++++++++${result}');
        result.data != null
            ? emit(HebergementStateLoaded(result))
            : emit(HebergementStateError('oups'));
      } else {
        emit(HebergementStateError('error'));
      }
    } catch (e) {
      log(e.toString());
      log('catch');
      emit(HebergementStateError(e.toString()));
    }
  }

  Future getListHebergementById() async {
    final HebergementProvider _HebergementProviderProvider =
        HebergementProvider();
    emit(HebergementStateLoading());
    try {
      // if (await AuthProvider().isTokenValid()) {
      //   // token est expiré, appelez refreshToken()
      //   await AuthProvider().refreshToken();
      // }
      var checkUrl = 'http://www.google.com';
      var checkResponse = await http.get(Uri.parse(checkUrl));
      if (checkResponse.statusCode == 200) {
        var result =
            await _HebergementProviderProvider.getListHebergementById();

        // log('promtion+++++++++++++++++++++++++++++++++++++++++++++++++++++++${result}');
        result.data != null
            ? emit(HebergementStateLoaded(result))
            : emit(HebergementStateError('oups'));
      } else {
        emit(HebergementStateError('error'));
      }
    } catch (e) {
      log(e.toString());
      log('catch');
      emit(HebergementStateError(e.toString()));
    }
  }
}
