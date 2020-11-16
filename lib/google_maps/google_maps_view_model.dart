import 'dart:convert';
import 'dart:io';

import 'package:flightflutter/google_maps/flights_map_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import './google_maps.dart';

abstract class GoogleMapsViewModel extends State<GoogleMaps> {
    GoogleMapController controller;
    List<FligtsMapModel> flightList;
    final firebaseServiceEndpoint = "https://fir-map-afbea.firebaseio.com/maps";
    final CameraPosition kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(38.9637, 35.2433),
      tilt: 59.440717697143555,
      zoom: 8);

    Future initMapItemList() async {  
      final response = await http.get("$firebaseServiceEndpoint.json");
      switch (response.statusCode){
      case HttpStatus.ok:
      final jsonData = jsonDecode(response.body);
      if(jsonData is List){
        flightList = jsonData.map((e) => FligtsMapModel.fromJson(e)).cast<FligtsMapModel>().toList();
        controller.animateCamera(CameraUpdate.newLatLng(LatLng(flightList.last.lat,flightList.last.long)));
        setState(() {
          
        });
      }else if(jsonData is Map){
        
      }else{
        return jsonData;
      }
        break;
      default:
    }
    }
}