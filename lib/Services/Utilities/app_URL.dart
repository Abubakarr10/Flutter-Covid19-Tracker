import 'package:flutter/material.dart';

class AppUrl{
  // this is our base Url
  static const String baseUrl = 'https://disease.sh/v3/covid-19/';

  // fetch world covid states
  static const String worldStatesAPI = baseUrl + 'all';
  static const String countriesLIst = baseUrl + 'countries';
}