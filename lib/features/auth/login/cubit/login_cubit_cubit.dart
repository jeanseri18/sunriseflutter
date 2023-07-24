import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sunrise_hosting/data/model/apireponse.dart';
import 'package:sunrise_hosting/data/provider/auth_provider.dart';

part 'login_cubit_state.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  LoginCubit() : super(LoginCubitInitial());
  final AuthProvider _apiProvider = AuthProvider();

  Future loginByMail(String email, String password) async {
    emit(LoginStateLoading());
    try {
      var result = await _apiProvider.loginUser(email, password);
      log('result ....${result.error}');
      result.data != null
          ? emit(LoginStateLoaded(result))
          : emit(LoginStateError(result.error.toString()));
    } catch (e) {
      log(e.toString());
      emit(LoginStateError(e.toString()));
    }
  }

  Future logout() async {
    emit(LoginOtpStateLoading());
    emit(LoginOtpStateLogout());
    await AuthProvider().logout();
    // emit(LoginStateError('error'));

    emit(LoginCubitInitial());
  }
}
