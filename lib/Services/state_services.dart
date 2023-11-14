import 'dart:convert';

import 'package:covid_app/Model/world_modal_state.dart';
import 'package:covid_app/Services/Utilities/Url.dart';
import 'package:http/http.dart'as http;

class stateServices{
  Future<covid_Modal> WorldStateRecord () async{
    final response = await http.get(Uri.parse(AppUrl.worldStatusApi));
     if(response.statusCode==200){
      var data = jsonDecode(response.body);
      return covid_Modal.fromJson(data);

     }else{
        throw Exception('Error');
     }


  }
  Future<List<dynamic>> CountriesStateApi () async{
    var data;
    final response = await http.get(Uri.parse(AppUrl.countryUrl));
     if(response.statusCode==200){
       data = jsonDecode(response.body);
      return data;

     }else{
        throw Exception('Error');
     }


  }
}