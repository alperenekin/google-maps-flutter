import 'package:flightflutter/google_maps/google_maps_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsView extends GoogleMapsViewModel {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: [buildGoogleMap(), buildPositioned()],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => {initMapItemList()});
  }

  Positioned buildPositioned() {
    return Positioned(
      bottom: 20,
      left: 20,
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: flightList.isEmpty ? loadingWidget : buildListViewFlights(),
    );
  }

  ListView buildListViewFlights() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: flightList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return SizedBox(
            width: MediaQuery.of(context).size.width - 100,
            child: Card(
              child: ListTile(
                  onTap: () => controller.animateCamera(CameraUpdate.newLatLng(
                      LatLng(flightList[index].lat, flightList[index].long))),
                  title: Text(flightList[index].country)),
            ),
          );
        });
  }

  Widget get loadingWidget => Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.white),
        ),
      );

  GoogleMap buildGoogleMap() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: kLake,
      onMapCreated: (map) async {
        controller = map;
        await createMarkerImageFromAsset(context);
      },
      markers: createMarker(),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        controller.animateCamera(
            CameraUpdate.newLatLng(LatLng(40.9906621, 29.0200943)));
      },
    );
  }

  Future<void> createMarkerImageFromAsset(BuildContext context) async {
    final ImageConfiguration imageConfiguration =
        createLocalImageConfiguration(context);
    var bitmap = await BitmapDescriptor.fromAssetImage(
        imageConfiguration, 'assets/images/dog.png');
    dogIcon = bitmap;
    setState(() {});
    // print(dogIcon);
  }
}

extension GoogleMapsMarker on GoogleMapsView {
  Set<Marker> createMarker() {
    return flightList
        .map((e) => Marker(
            markerId: MarkerId(e.hashCode.toString()),
            position: LatLng(e.lat, e.long),
            zIndex: 10,
            infoWindow: InfoWindow(title: e.country),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure)))
        .toSet();
  }
}
