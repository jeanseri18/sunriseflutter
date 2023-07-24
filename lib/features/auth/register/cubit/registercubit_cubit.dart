import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sunrise_hosting/data/model/apireponse.dart';
import 'package:sunrise_hosting/data/provider/auth_provider.dart';

part 'registercubit_state.dart';

class Registercubit extends Cubit<RegistercubitState> {
  Registercubit() : super(RegistercubitInitial());
  final AuthProvider _apiProvider = AuthProvider();
  Future registerFetch(
      String name,
      String telephone,
      String birthday,
      String typeCompte,
      String idPays,
      String ville,
      String email,
      String password) async {
    emit(RegisterStateLoading());
    try {
      var result = await _apiProvider.registerUser(name, telephone, birthday,
          typeCompte, idPays, ville, email, password);
      log('result ' + result.error.toString());
      result.data != null
          ? emit(RegisterStateLoaded(result))
          : emit(RegisterStateError(result.error.toString()));
    } catch (e) {
      log(e.toString());
      emit(RegisterStateError(e.toString()));
    }
  }
}
