import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sunrise_hosting/data/model/hebergement_list_model.dart';
import 'package:sunrise_hosting/data/model/token_model.dart';
import 'package:sunrise_hosting/data/provider/auth_provider.dart';

class HebergementProvider {
  Future<HebergementModel> getListHebergement() async {
    HebergementModel responses = HebergementModel();

    AccessToken token = await AuthProvider().getToken();
    try {
      var url = Uri.parse(
        'http://sunrise-housing.net/api/hebergement',
      );

      log('promotion');

      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer  ${token..accesstoken}',
        },
      );
      log('codepromotion' + response.statusCode.toString());
      log(jsonDecode(response.body).toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        responses = HebergementModel.fromJson(jsonDecode(response.body));
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
}
