import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:sunrise_hosting/data/model/google_details_model.dart';
import 'package:sunrise_hosting/data/model/google_place_model.dart';

class GoogleMapDataProvider {
  static const _apiKey = 'AIzaSyD0OFIF-WwrQRVpD3acbegQoIGapwtkAOk';
  static const _baseUrl = 'https://maps.googleapis.com';
  static String get _searchPlaceUrl =>
      '$_baseUrl/maps/api/place/autocomplete/json';
  static String get _placeDetailsFromIdUrl =>
      '$_baseUrl/maps/api/place/details/json';

  Future<List<GooglePrediction>> searchPlaces({
    required String query,
  }) async {
    final client = Dio();
    final url = _searchPlaceUrl;
    final path = '$url?input=$query&key=$_apiKey';
    final response = await client.get<String>(path);
    if (response.data != null) {
      final result = GooglePlaceResult.fromRawJson(response.data!);
      final predictions = result.predictions;
      return predictions;
    }
    return [];
  }

  Future<GooglePlaceDetails?> getPlaceDetailsFromId(
      // String query,
      {
    required String id,
  }) async {
    final client = Dio();
    final url = _placeDetailsFromIdUrl;
    final path = '$url?place_id=$id&key=$_apiKey'
        '&fields=geometry,formatted_address';
    final response = await client.get<String>(path);
    if (response.data != null) {
      final result = GooglePlaceDetailsResult.fromRawJson(response.data!);
      return result.details;
    }
    return null;
  }
}
