import 'package:flightflutter/google_maps/google_maps_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class GoogleMapsView extends GoogleMapsViewModel {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: buildFloatingActionButton(),
      body: buildGoogleMap(),
    );
  }

  GoogleMap buildGoogleMap() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: kLake,
      onMapCreated: (map) {
        controller = map;
      },
      markers: createMarker(),
    );
  }


  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        controller.animateCamera(CameraUpdate.newLatLng(LatLng(40.9906621, 29.0200943)));
      },
    );
  }
}


extension GoogleMapsMarker on GoogleMapsView{
  Set<Marker> createMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId("asdad"),
          position: kLake.target,
          zIndex: 10,
          infoWindow: InfoWindow(title:"Hello"),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure))
    ].toSet();
  }
}