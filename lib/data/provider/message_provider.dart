import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sunrise_hosting/data/model/mesage_detail.dart';
import 'package:sunrise_hosting/data/model/message_list_model.dart';
import 'package:sunrise_hosting/data/model/message_post_model.dart';
import 'package:sunrise_hosting/data/model/messsage_reply_model.dart';
import 'package:sunrise_hosting/data/model/token_model.dart';
import 'package:sunrise_hosting/data/provider/auth_provider.dart';

class MessageProvider {
  Future<MessageListModel> getListMessage() async {
    MessageListModel responses = MessageListModel();

    AccessToken token = await AuthProvider().getToken();
    try {
      var url = Uri.parse(
        'http://sunrise-housing.net/api/messages',
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
        responses = MessageListModel.fromJson(jsonDecode(response.body));
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

  Future<MessageDetailModel> getDetailMessage(String id) async {
    MessageDetailModel responses = MessageDetailModel();

    AccessToken token = await AuthProvider().getToken();
    try {
      var url = Uri.parse(
        'http://sunrise-housing.net/api/messages/$id',
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
        responses = MessageDetailModel.fromJson(jsonDecode(response.body));
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

  Future<MessageReplyModel> getReplyMessage(String id, String message) async {
    MessageReplyModel responses = MessageReplyModel();

    AccessToken token = await AuthProvider().getToken();

    var url = Uri.parse(
      'http://sunrise-housing.net/api/messages/$id',
    );
    var headers = {'Authorization': 'Bearer  ${token.accessToken}'};

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://sunrise-housing.net/api/messages/$id'),
    );

    request.fields.addAll({
      'message': message,
    });

    request.headers.addAll(headers);

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        responses = MessageReplyModel.fromJson(jsonDecode(responseBody));
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

  Future<MessagePostModel> getPostMessage(
      String message, String idUserProprio) async {
    AccessToken token = await AuthProvider().getToken();

    var url = Uri.parse('http://sunrise-housing.net/api/messages');
    var headers = {'Authorization': 'Bearer ${token.accessToken}'};

    var request = http.MultipartRequest('POST', url);
    request.fields['id_user_proprio'] = idUserProprio;
    request.fields['message'] = message;
    request.headers.addAll(headers);

    try {
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      print(responseBody);
      if (response.statusCode == 200) {
        return MessagePostModel.fromJson(jsonDecode(responseBody));
      } else {
        print('Error: ${response.reasonPhrase}');
        return MessagePostModel(); // Ou une autre gestion d'erreur appropriée
      }
    } catch (error, stacktrace) {
      print("Exception occurred: $error\n$stacktrace");
      return MessagePostModel(); // Ou une autre gestion d'erreur appropriée
    }
  }

  //   log('promotion');

  //   // if (message.isEmpty) {
  //   //   throw Exception("Le message ne peut pas être vide");
  //   // }

  //   var response = await http.post(url, headers: {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer  ${token.AccessToken}',
  //   }, body: {
  //     "message": message
  //   });
  //   log('codepromotion' + response.statusCode.toString());
  //   inspect(jsonDecode(response.body).toString());
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     responses = MessageReplyModel.fromJson(jsonDecode(response.body));
  //     inspect(response);
  //     return responses;
  //   }
  //   // responses =reponses ;
  //   log(responses.toString());

  //   return responses;
  // } catch (error, stacktrace) {
  //   // print("Exception occured: $error stackTrace: $stacktrace");
  //   log(responses.toString());
  //   return responses;
  // }
}
