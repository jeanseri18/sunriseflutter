import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunrise_hosting/data/model/PaymentPostModel.dart';
import 'package:sunrise_hosting/data/model/apireponse.dart';
import 'package:sunrise_hosting/data/model/payment_model.dart';
import 'package:sunrise_hosting/data/model/token_model.dart';
import 'package:sunrise_hosting/data/model/user_model.dart';
import 'package:sunrise_hosting/data/provider/auth_provider.dart';

class PaymentProvider {
  Future<PaymentModel> getListPayment() async {
    PaymentModel responses = PaymentModel();

    AccessToken token = await AuthProvider().getToken();
    try {
      var url = Uri.parse(
        'http://sunrise-housing.net/api/payment',
      );

      log('promotion');

      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer  ${token.accessToken}',
        },
      );
      log('codepromotion' + response.statusCode.toString());
      log(jsonDecode(response.body).toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        responses = PaymentModel.fromJson(jsonDecode(response.body));
        inspect(response);
        return responses;
      }
      // responses =reponses ;
      log(responses.toString());

      return responses;
    } catch (error, stacktrace) {
      // print("Exception occured: $error stackTrace: $stacktrace");
      log(responses.toString());
      return responses;
    }
  }

  Future<PaymentPostModel> getPostMessage(
    String id_type_payment,
    String id_commande,
    String montant,
    String date,
    String status,
  ) async {
    AccessToken token = await AuthProvider().getToken();

    var url = Uri.parse('http://sunrise-housing.net/api/payment');
    var headers = {'Authorization': 'Bearer ${token.accessToken}'};

    var request = http.MultipartRequest('POST', url);
    request.fields['id_type_payment'] = id_type_payment;
    request.fields['id_commande'] = id_commande;
    request.fields['montant'] = montant;
    request.fields['date'] = date;
    request.fields['status'] = status;

    request.headers.addAll(headers);

    try {
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      print(responseBody);
      if (response.statusCode == 200) {
        return PaymentPostModel.fromJson(jsonDecode(responseBody));
      } else {
        print('Error: ${response.reasonPhrase}');
        return PaymentPostModel(); // Ou une autre gestion d'erreur appropriée
      }
    } catch (error, stacktrace) {
      print("Exception occurred: $error\n$stacktrace");
      return PaymentPostModel(); // Ou une autre gestion d'erreur appropriée
    }
  }
}
