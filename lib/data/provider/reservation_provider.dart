import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sunrise_hosting/data/model/reservation_list_model.dart';
import 'package:sunrise_hosting/data/model/reservation_post_model.dart';
import 'package:sunrise_hosting/data/model/token_model.dart';
import 'package:sunrise_hosting/data/provider/auth_provider.dart';

class ReservationProvider {
  Future<ReservationListModel> getListReservation() async {
    ReservationListModel responses = ReservationListModel();

    AccessToken token = await AuthProvider().getToken();
    try {
      var url = Uri.parse(
        'http://sunrise-housing.net/api/reservation',
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
        inspect(response);
        responses = ReservationListModel.fromJson(jsonDecode(response.body));

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

  // Future<ReservationDetailModel> getDetailReservation(String id) async {
  //   ReservationDetailModel responses = ReservationDetailModel();

  //   AccessToken token = await AuthProvider().getToken();
  //   try {
  //     var url = Uri.parse(
  //       'http://sunrise-housing.net/api/Reservations/$id',
  //     );

  //     log('promotion');

  //     var response = await http.get(
  //       url,
  //       headers: {
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer  ${token.accesstoken}',
  //       },
  //     );
  //     log('codepromotion' + response.statusCode.toString());
  //     log(jsonDecode(response.body).toString());
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       responses = ReservationDetailModel.fromJson(jsonDecode(response.body));
  //       inspect(response);
  //       return responses;
  //     }
  //     // responses =reponses ;
  //     log(responses.toString());

  //     return responses;
  //   } catch (error, stacktrace) {
  //     // print("Exception occured: $error stackTrace: $stacktrace");
  //     log(responses.toString());
  //     return responses;
  //   }
  // }

  Future<ReservationPostModel> getPostReservation(
    String idHebergement,
    String iduser,
    String idpropio,
    String dateDebut,
    String montant,
    String dateFin,
    String reste,
    String avance,
    String nbrePerson,
  ) async {
    ReservationPostModel responses = ReservationPostModel();

    AccessToken token = await AuthProvider().getToken();

    var url = Uri.parse(
      'http://sunrise-housing.net/api/reservation',
    );
    var headers = {'Authorization': 'Bearer  ${token.accessToken}'};

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://sunrise-housing.net/api/reservation'),
    );

    request.fields.addAll({
      'id_hebergement': idHebergement,
      'id_user': iduser,
      'id_proprio': idpropio,
      'date_debut': dateDebut,
      'montant': montant,
      'avance': avance,
      'reste': reste,
      'nbre_personne': nbrePerson,
      'status': 'en attente',
      'date_fin': dateFin
    });

    request.headers.addAll(headers);

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        responses = ReservationPostModel.fromJson(jsonDecode(responseBody));
        print(responseBody);
        return responses;
      } else {
        print(await response.stream.bytesToString());
        return responses;
      }
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return responses;
    }
  }
}
