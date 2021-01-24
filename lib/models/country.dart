import 'dart:convert';

class Country {
  String code;
  String countryName;
  String region;

  Country({this.countryName, this.region, this.code});

  Map<String, dynamic> toMap() {
    return {
      'country': countryName,
      'region': region,
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Country(
      countryName: map['country'],
      region: map['region'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Country.fromJson(String source) =>
      Country.fromMap(json.decode(source));
}
