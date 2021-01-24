import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tatsamAssignment/models/country.dart';
import 'package:http/http.dart' as http;

class HttpService {
  String baseUrl = "https://api.first.org/data/v1/countries/";
  Future<List<Country>> getCountries(String offset, String limit) async {
    List<Country> countries = [];
    try {
      final response = await http.get(baseUrl + '?limit=$limit&offset=$offset',
          headers: {'contentType': 'Application/json'});
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        var data = decodedResponse['data'];
        if (data.isNotEmpty) {
          for (var data in data.entries) {
            countries.add(Country(
                code: data.key,
                countryName: data.value['country'],
                region: data.value['region']));
          }
        }
      }
    } catch (e) {}
    return countries;
  }
}
