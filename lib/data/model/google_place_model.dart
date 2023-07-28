import 'dart:convert';

class GooglePlaceResult {
  GooglePlaceResult({
    required this.predictions,
    required this.status,
  });
  factory GooglePlaceResult.fromJson(Map<String, dynamic> json) =>
      GooglePlaceResult(
        predictions: List<GooglePrediction>.from((json['predictions'] as List)
            .map((x) => GooglePrediction.fromJson(x))),
        status: json['status'],
      );

  final List<GooglePrediction> predictions;
  final String status;

  static GooglePlaceResult fromRawJson(String str) =>
      GooglePlaceResult.fromJson(json.decode(str));

  static String toRawJson(GooglePlaceResult data) => json.encode(data.toJson());

  Map<String, dynamic> toJson() => {
        'predictions': List<dynamic>.from(predictions.map((x) => x.toJson())),
        'status': status,
      };
}

class GooglePrediction {
  GooglePrediction({
    required this.structuredFormatting,
    required this.matchedSubstrings,
    required this.description,
    required this.reference,
    required this.placeId,
    required this.terms,
    required this.types,
  });

  factory GooglePrediction.fromJson(Map<String, dynamic> json) =>
      GooglePrediction(
        description: json['description'],
        matchedSubstrings: List<GoogleMatchedSubstring>.from(
            (json['matched_substrings'] as List<dynamic>)
                .map((x) => GoogleMatchedSubstring.fromJson(x))),
        placeId: json['place_id'],
        reference: json['reference'],
        structuredFormatting:
            GoogleStructuredFormatting.fromJson(json['structured_formatting']),
        terms: List<GoogleTerm>.from(
          (json['terms'] as List<dynamic>).map((x) => GoogleTerm.fromJson(x)),
        ),
        types: List<String>.from(
          (json['types'] as List<dynamic>).map((x) => x),
        ),
      );

  final GoogleStructuredFormatting structuredFormatting;
  final List<GoogleMatchedSubstring> matchedSubstrings;
  final String description;
  final List<String> types;
  final String reference;
  final List<GoogleTerm> terms;
  final String placeId;

  Map<String, dynamic> toJson() => {
        'description': description,
        'matched_substrings':
            List<dynamic>.from(matchedSubstrings.map((x) => x.toJson())),
        'place_id': placeId,
        'reference': reference,
        'structured_formatting': structuredFormatting.toJson(),
        'terms': List<dynamic>.from(terms.map((x) => x.toJson())),
        'types': List<dynamic>.from(types.map((x) => x)),
      };
}

class GoogleMatchedSubstring {
  GoogleMatchedSubstring({
    required this.length,
    required this.offset,
  });

  factory GoogleMatchedSubstring.fromJson(Map<String, dynamic> json) =>
      GoogleMatchedSubstring(
        length: json['length'],
        offset: json['offset'],
      );

  final int length;
  final int offset;

  Map<String, dynamic> toJson() => {
        'length': length,
        'offset': offset,
      };
}

class GoogleStructuredFormatting {
  GoogleStructuredFormatting({
    required this.mainText,
    required this.mainTextMatchedSubstrings,
    required this.secondaryText,
  });

  factory GoogleStructuredFormatting.fromJson(Map<String, dynamic> json) =>
      GoogleStructuredFormatting(
        mainText: json['main_text'],
        mainTextMatchedSubstrings: List<GoogleMatchedSubstring>.from(
            (json['main_text_matched_substrings'] as List<dynamic>)
                .map((x) => GoogleMatchedSubstring.fromJson(x))),
        secondaryText: json['secondary_text'],
      );

  final List<GoogleMatchedSubstring> mainTextMatchedSubstrings;
  final String secondaryText;
  final String mainText;

  Map<String, dynamic> toJson() => {
        'main_text': mainText,
        'main_text_matched_substrings': List<dynamic>.from(
            mainTextMatchedSubstrings.map((x) => x.toJson())),
        'secondary_text': secondaryText,
      };
}

class GoogleTerm {
  GoogleTerm({
    required this.offset,
    required this.value,
  });

  factory GoogleTerm.fromJson(Map<String, dynamic> json) => GoogleTerm(
        offset: json['offset'],
        value: json['value'],
      );

  final int offset;
  final String value;

  Map<String, dynamic> toJson() => {
        'offset': offset,
        'value': value,
      };
}
