import 'dart:convert';

class ListGooglePlaceDetailsResult {
  ListGooglePlaceDetailsResult({
    required this.details,
    required this.status,
  });

  factory ListGooglePlaceDetailsResult.fromJson(Map<String, dynamic> json) =>
      ListGooglePlaceDetailsResult(
        details: (json['results'] as List)
            .map((e) => GooglePlaceDetails.fromJson(e))
            .toList(),
        status: json['status'],
      );

  final List<GooglePlaceDetails> details;
  final String status;

  static ListGooglePlaceDetailsResult fromRawJson(String str) =>
      ListGooglePlaceDetailsResult.fromJson(json.decode(str));

  static String toRawJson(ListGooglePlaceDetailsResult data) =>
      json.encode(data.toJson());

  Map<String, dynamic> toJson() => {
        'results': details.map((e) => e.toJson()),
        'status': status,
      };
}

class GooglePlaceDetailsResult {
  GooglePlaceDetailsResult({
    required this.details,
    required this.status,
  });

  factory GooglePlaceDetailsResult.fromJson(Map<String, dynamic> json) =>
      GooglePlaceDetailsResult(
        details: GooglePlaceDetails.fromJson(json['result']),
        status: json['status'],
      );

  final GooglePlaceDetails details;
  final String status;

  static GooglePlaceDetailsResult fromRawJson(String str) =>
      GooglePlaceDetailsResult.fromJson(json.decode(str));

  static String toRawJson(GooglePlaceDetailsResult data) =>
      json.encode(data.toJson());

  Map<String, dynamic> toJson() => {
        'result': details.toJson(),
        'status': status,
      };
}

class GooglePlaceDetails {
  GooglePlaceDetails({
    required this.geometry,
    required this.formattedAddress,
  });

  factory GooglePlaceDetails.fromJson(Map<String, dynamic> json) =>
      GooglePlaceDetails(
        geometry: GooglePlaceGeometry.fromJson(json['geometry']),
        formattedAddress: json['formatted_address'],
      );

  final GooglePlaceGeometry geometry;
  final String formattedAddress;

  Map<String, dynamic> toJson() => {
        'geometry': geometry.toJson(),
      };
}

class GooglePlaceGeometry {
  GooglePlaceGeometry({
    required this.location,
    required this.viewport,
  });

  factory GooglePlaceGeometry.fromJson(Map<String, dynamic> json) =>
      GooglePlaceGeometry(
        location: GooglePlaceLocation.fromJson(json['location']),
        viewport: GooglePlaceViewport.fromJson(json['viewport']),
      );

  final GooglePlaceLocation location;
  final GooglePlaceViewport viewport;

  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
        'viewport': viewport.toJson(),
      };
}

class GooglePlaceLocation {
  GooglePlaceLocation({
    required this.lat,
    required this.lng,
  });
  factory GooglePlaceLocation.fromJson(Map<String, dynamic> json) =>
      GooglePlaceLocation(
        lat: json['lat'] as double,
        lng: json['lng'] as double,
      );

  final double lat;
  final double lng;

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };
}

class GooglePlaceViewport {
  GooglePlaceViewport({
    required this.northeast,
    required this.southwest,
  });
  factory GooglePlaceViewport.fromJson(Map<String, dynamic> json) =>
      GooglePlaceViewport(
        northeast: GooglePlaceLocation.fromJson(json['northeast']),
        southwest: GooglePlaceLocation.fromJson(json['southwest']),
      );

  final GooglePlaceLocation northeast;
  final GooglePlaceLocation southwest;

  Map<String, dynamic> toJson() => {
        'northeast': northeast.toJson(),
        'southwest': southwest.toJson(),
      };
}
