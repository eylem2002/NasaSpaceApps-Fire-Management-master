import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Core/Services/nasa_api_service.dart';
import '../../Utils/lib_organizer.dart';

class MapViewScreen extends StatefulWidget {
  const MapViewScreen(
      {super.key, required this.mapData,});

  @override
  State<MapViewScreen> createState() => MapViewScreenState();
  final List<String> mapData;
}

class MapViewScreenState extends State<MapViewScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late List<Marker> myMarkers;
  late NasaApiService _service;

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
    _service = NasaApiService(date: widget.mapData[0], areaCoordinates: widget.mapData[1],dayRange: widget.mapData[2]);
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
