import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsView extends StatefulWidget {
  @override
  _GoogleMapsViewState createState() => _GoogleMapsViewState();
}

class _GoogleMapsViewState extends State<GoogleMapsView> {
  GoogleMapController controller;
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(40.9130116, 29.2094771),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.animateCamera(CameraUpdate.newLatLng(LatLng(40.9906621, 29.0200943)));
        },
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kLake,
        onMapCreated: (map) {
          controller = map;
        },
        markers: _createMarker(),
      ),
    );
  }

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId("asdad"),
          position: _kLake.target,
          zIndex: 10,
          infoWindow: InfoWindow(title:"Hello"),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure))
    ].toSet();
  }
}
