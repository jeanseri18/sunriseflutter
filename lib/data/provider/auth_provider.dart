import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunrise_hosting/data/model/apireponse.dart';
import 'package:sunrise_hosting/data/model/token_model.dart';
import 'package:sunrise_hosting/data/model/user_model.dart';

class AuthProvider {
  Future<ApiResponse> registerUser(
      String name,
      String telephone,
      String birthday,
      String typeCompte,
      String idPays,
      String ville,
      String email,
      String password) async {
    // var headers = {
    //   'Authorization':
    //       'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2F1dGgvcmVnaXN0ZXIiLCJpYXQiOjE2ODk1OTkwMDksImV4cCI6MTY4OTYwMjYwOSwibmJmIjoxNjg5NTk5MDA5LCJqdGkiOiJtR29Kc3VqYWd2aWJsSVRBIiwic3ViIjoiNyIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.CMUvMKj2uk5-tTMGaxTNMzpw49Kg2f4Zzp-mQGGHhpc',
    //   'Cookie':
    //       'XSRF-TOKEN=eyJpdiI6Ikd3MHNia2VmTzYyNjY4OGZHU0s5M2c9PSIsInZhbHVlIjoiRmpJSFJGVjV4THArclUwK3VmNkJITXBvQVVOdU44VlVYT09NeGhUZjg4VXQyYnJEVTJkaHJ6Ukt0ektqUmY5Z0w2Q3VxOFQ4Z2cxQ0t6R1pBTDFTVHU4VWlIMmI4ZEpNSXVZSDFxb3AxdDMwWjE5YWNrS2x6ZDhNOUJidUtvT1UiLCJtYWMiOiI4ODM2OGM4ZjE2MzU1YTRjNjVjYzJlNDQ1ZjY3OGMwOWVkZDQ5MmRmY2QzOWVmZTE2NDI5ZTg2NDM2NDVlODQwIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6InFhTlAvTHowbERUeUpaZ2tQdFErUUE9PSIsInZhbHVlIjoiV1BxbVhQUnF1emxoaG1MUmdpZTRFRk90VDdyRmsyY0tJWXluaWMzRS9yRDZqbXNnRzY3cmlHZjB3VGV5L0JFMTBkMU8yY01lR2lQT1BUSDhCd1NQK0VvbGVhZTNJc1lYN01CZVR1UVZsQW9PM09sZjU2NmoxS0k3emlndC8zci8iLCJtYWMiOiIzMGJlYzVmZGIwZTc0OWJmOTc4NGIwZmVhNDY3MjE2ZjE3YWE4NzVhNWFiNzZjNjViODBhOTFjNjUzMjkyMjVjIiwidGFnIjoiIn0%3D'
    // };
    ApiResponse response = ApiResponse();
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://sunrise-housing.net/api/auth/register'));
      request.fields.addAll({
        'name': name,
        'telephone': telephone,
        'birthday': birthday,
        'type_compte': typeCompte,
        'id_pays': idPays,
        'ville': ville,
        'email': email,
        'password': password,
      });
      // request.headers.addAll(headers);

      http.StreamedResponse responses = await request.send();
      var responseData = await responses.stream.bytesToString();
      var json = jsonDecode(responseData);
      log(responseData);
      if (responses.statusCode == 200) {
        // var responseData = await responses.stream.bytesToString();
        // var json = jsonDecode(responseData);

        var token = json['access_token'];
        inspect(json['expires_in']);
        var expiresIn = DateTime.parse(json['expires_in']);
        inspect(expiresIn);
        var userJson = json['user'];
        var user = User.fromJson(userJson);
        addUserInfo(user, email, password);
        log(user.email.toString());
        addToken(AccessToken.fromJson(json));
        response.status = true;
        response.data = user;
        return response;
      }
      response.data = null;
      log(response.data.toString());
      response.error = 'Oups ! une erreure est survenue';

      return response;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      // Faire quelque chose avec l'erreur, par exemple afficher un message à l'utilisateur
      response.error = "Erreur lors de la connexion au serveur";
      return response;
    }
  }

  Future<ApiResponse> loginUser(String email, String password) async {
    // var headers = {
    //   'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2F1dGgvbG9naW4iLCJpYXQiOjE2ODA2MjA2MDMsImV4cCI6MTY4MDYyNDIwMywibmJmIjoxNjgwNjIwNjAzLCJqdGkiOiJRWVJ6RkhOTUV6RDZWQmdsIiwic3ViIjoiMSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.szosNCZhRvhZ6_L4lCMrwFx-u4se2PCDeqwJ91tRWtA',
    //   'Cookie': 'XSRF-TOKEN=eyJpdiI6Ikd3MHNia2VmTzYyNjY4OGZHU0s5M2c9PSIsInZhbHVlIjoiRmpJSFJGVjV4THArclUwK3VmNkJITXBvQVVOdU44VlVYT09NeGhUZjg4VXQyYnJEVTJkaHJ6Ukt0ektqUmY5Z0w2Q3VxOFQ4Z2cxQ0t6R1pBTDFTVHU4VWlIMmI4ZEpNSXVZSDFxb3AxdDMwWjE5YWNrS2x6ZDhNOUJidUtvT1UiLCJtYWMiOiI4ODM2OGM4ZjE2MzU1YTRjNjVjYzJlNDQ1ZjY3OGMwOWVkZDQ5MmRmY2QzOWVmZTE2NDI5ZTg2NDM2NDVlODQwIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6InFhTlAvTHowbERUeUpaZ2tQdFErUUE9PSIsInZhbHVlIjoiV1BxbVhQUnF1emxoaG1MUmdpZTRFRk90VDdyRmsyY0tJWXluaWMzRS9yRDZqbXNnRzY3cmlHZjB3VGV5L0JFMTBkMU8yY01lR2lQT1BUSDhCd1NQK0VvbGVhZTNJc1lYN01CZVR1UVZsQW9PM09sZjU2NmoxS0k3emlndC8zci8iLCJtYWMiOiIzMGJlYzVmZGIwZTc0OWJmOTc4NGIwZmVhNDY3MjE2ZjE3YWE4NzVhNWFiNzZjNjViODBhOTFjNjUzMjkyMjVjIiwidGFnIjoiIn0%3D'
    // };
    ApiResponse response = ApiResponse();
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://sunrise-housing.net/api/auth/login'));
      request.fields.addAll({
        'email': email,
        'password': password,
      });
      // request.headers.addAll(headers);

      http.StreamedResponse responses = await request.send();

      if (responses.statusCode == 200) {
        var responseData = await responses.stream.bytesToString();
        var json = jsonDecode(responseData);

        var token = json['access_token'];
        inspect(json['expires_in']);
        var expiresIn = DateTime.parse(json['expires_in']);
        inspect(expiresIn);
        var userJson = json['user'];
        var user = User.fromJson(userJson);
        addUserInfo(user, email, password);
        log(user.email.toString());
        addToken(AccessToken.fromJson(json));
        response.status = true;
        response.data = user;
        return response;
      }
      response.data = null;
      log(response.data.toString());
      response.error = 'Oups ! mot de passe ou email incorrect ';

      return response;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      // Faire quelque chose avec l'erreur, par exemple afficher un message à l'utilisateur
      response.error = "Erreur lors de la connexion au serveur";
      return response;
    }
  }

  Future addUserInfo(User user, String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedMap = json.encode(user);
    print(encodedMap);
    prefs.setString('user', encodedMap);
    prefs.setString('id', user.id.toString());
    prefs.setString('password', password);
    prefs.setString('phoneOrEmail', email);
    getUserInfo();
  }

  Future<User> getUserInfo() async {
    var response = User();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedMap = prefs.getString('user');
    Map<String, dynamic> decodedMap = json.decode(encodedMap!);
    log('+++++++++++++++++++++++++++++++++++++');
    response = User.fromJson(decodedMap);
    log('connected and saving.....${prefs.getString('id')}');
    log('connected and saving.....${prefs.getString('id')}');
    log('connected and saving.....$response');
    return response;
  }

// ignore: avoid_types_as_parameter_names
  Future addToken(AccessToken token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedMap = json.encode(token);
    prefs.setString('token', encodedMap);
    getToken();
  }

  Future<AccessToken> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedMap = prefs.getString('token');

    var decodedMap = json.decode(encodedMap!);
    log('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
    log('+++++++++++++++++++++++++6+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
    log('++++++++++++++++++++++++++++88445++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
    var response = AccessToken.fromJson(decodedMap);
    log('show token model.....${response.accesstoken}');
    log('show refresh model.....${response.expiresin}');
    return response;
  }

  Future logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("user");
    prefs.remove("id");
    prefs.remove("token");
    prefs.remove("phoneOrEmail");
    log('deconnexion');
  }
}
