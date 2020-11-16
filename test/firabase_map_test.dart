import 'dart:convert';
import 'dart:io';

import 'package:flightflutter/google_maps/flights_map_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

main() {
    final firebaseServiceEndpoint = "https://fir-map-afbea.firebaseio.com/maps";

  test('firebase map test',() async {
    final response = await http.get("$firebaseServiceEndpoint.json");
    var responseData;
    switch (response.statusCode){
      case HttpStatus.ok:
      final jsonData = jsonDecode(response.body);
      if(jsonData is List){
        responseData = jsonData.map((e) => FligtsMapModel.fromJson(e)).cast<FligtsMapModel>().toList();
      }else if(jsonData is Map){
        
      }else{
        return jsonData;
      }
        break;
      default:
    }

    expect(responseData is List, true);
  });
}