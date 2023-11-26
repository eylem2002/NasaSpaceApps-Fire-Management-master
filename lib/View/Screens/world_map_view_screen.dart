import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Core/Services/nasa_api_service.dart';
import '../../Core/Services/nasa_api_service_all_world.dart';
import '../../Utils/lib_organizer.dart';

class WorldMapViewScreen extends StatefulWidget {
   const WorldMapViewScreen(
      {super.key, required this.mapData,});

  @override
  State<WorldMapViewScreen> createState() => WorldMapViewScreenState();
  final List<String> mapData;
}

class WorldMapViewScreenState extends State<WorldMapViewScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late List<Marker> myMarkers;
  late NasaApiServiceWorld _service;

  late CameraPosition _kGooglePlex;

  @override
  void initState() {
    // TODO: implement initState

    Future<void> requestPermission() async {
      await Permission.location.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    _service = NasaApiServiceWorld(date: widget.mapData[0],dayRange: widget.mapData[1]);
    return Scaffold(
      body: FutureBuilder<List<Marker>>(
          future: _service.getMarkers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              log("IN");
              myMarkers = snapshot.data as List<Marker>;
              if (myMarkers.isNotEmpty) {
                _kGooglePlex = CameraPosition(
                  target: LatLng(myMarkers[5].position.latitude,
                      myMarkers[5].position.longitude),
                  zoom: 8,
                );
                return GoogleMap(
                    mapType: MapType.hybrid,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    markers: Set<Marker>.of(myMarkers));
              }

              return const Center(child: Text("No Markers yet"));
            }

            log("OUT");
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
