import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sunrise_hosting/data/model/payment_model.dart';
import 'package:sunrise_hosting/data/provider/payment_provider.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
part 'paiment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  Future getPaymentList() async {
    final PaymentProvider _PaymentProviderProvider = PaymentProvider();
    emit(PaymentStateLoading());
    try {
      // if (await AuthProvider().isTokenValid()) {
      //   // token est expiré, appelez refreshToken()
      //   await AuthProvider().refreshToken();
      // }
      var checkUrl = 'http://www.google.com';
      var checkResponse = await http.get(Uri.parse(checkUrl));
      if (checkResponse.statusCode == 200) {
        var result = await _PaymentProviderProvider.getListPayment();

        // log('promtion+++++++++++++++++++++++++++++++++++++++++++++++++++++++${result}');
        result.data != null
            ? emit(PaymentStateLoaded(result))
            : emit(PaymentStateError('oups'));
      } else {
        emit(PaymentStateError('error'));
      }
    } catch (e) {
      log(e.toString());
      log('catch');
      emit(PaymentStateError(e.toString()));
    }
  }
}
