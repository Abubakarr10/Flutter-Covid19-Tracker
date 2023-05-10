import 'dart:convert';

//import 'package:covid_tracker/Services/Utilities/app_URL.dart';
import 'package:http/http.dart'as http;

import '../Models/worldStatesModel.dart';
import 'Utilities/app_URL.dart';

class StatesServices{

  Future<WorldStatesModel> fetchWorldStatesRecords() async{
    final response = await http.get(Uri.parse(AppUrl.worldStatesAPI));

    if(response.statusCode==200){
      var data = jsonDecode(response.body.toString());
      return WorldStatesModel.fromJson(data);
    }
    else{
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countriesListAPI() async{
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesLIst));

    if(response.statusCode==200){
       data = jsonDecode(response.body);
      return data;
    }
    else{
      throw Exception('Error');
    }
  }
}

