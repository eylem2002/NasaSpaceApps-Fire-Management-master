import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../../Utils/lib_organizer.dart';



class NasaApiServiceWorld {

  // String mapKey = "1c042fc10e6dd87b8a53350a7c8385fd";
  // String source = "VIIRS_SNPP_NRT";
  // String areaCoordinates = "USA/1";
  // String dayRange = "2023-10-01";
  final String mapKey = "1c042fc10e6dd87b8a53350a7c8385fd";
  final  String source = "VIIRS_SNPP_NRT";
  final String dayRange ;
  final String date ;

  NasaApiServiceWorld({required this.dayRange,required this.date});

  Future<String> _loadWorld() async {


    var requestWorld = http.Request(
        'GET',
        Uri.parse(
            'https://firms.modaps.eosdis.nasa.gov/api/area/csv/$mapKey/$source/world/1/$date'));

    http.StreamedResponse responseWorld = await requestWorld.send();
    if (responseWorld.statusCode == 200) {
      return responseWorld.stream.bytesToString();

    } else {
      return('Failed to load data');
    }


  }



  Future<List<FireData>> parseResponseData() async{
    String responseData = await _loadWorld();

    List<FireData> parsedDataList = [];

    List<String> lines = responseData.split("\n");

    if (lines.isNotEmpty) {
      for (int i = 1; i < lines.length; i++) {
          String line = lines[i];
          List<String> values = line.split(",");
        if (values.length == 14)
        {
 int c=0;
            FireData fireData = FireData();
            fireData.latitude = double.parse(values[c++]);
            fireData.longitude = double.parse(values[c++]);
            fireData.bright_ti4 = double.parse(values[c++]);
            fireData.scan = double.parse(values[c++]);
            fireData.track = double.parse(values[c++]);
            fireData.acq_date = values[c++];
            fireData.acq_time = int.parse(values[c++]);
            fireData.satellite = values[c++];
            fireData.instrument = values[c++];
            fireData.confidence = values[c++];
            fireData.version = values[c++];
            fireData.bright_ti5 = double.parse(values[c++]);
            fireData.frp = double.parse(values[c++]);
            fireData.daynight = values[c++];
            parsedDataList.add(fireData);
        }
        else
          {
          log("Error");
          }
      }

    }
    return parsedDataList;
  }



//reacting markers
Future<List<Marker>> getMarkers()async{

     int c=0;
     List<FireData>fireDataList =await parseResponseData();
     List<Marker> markers=[];
  for (int i = 0; i < fireDataList.length; i++) {
    LatLng location = LatLng(fireDataList[i].latitude, fireDataList[i].longitude);
    markers.add( Marker(
      markerId: MarkerId('$c'),
      position: location,
      infoWindow: InfoWindow(title: 'marker ${c++}'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ));
  }
 return markers;
}
}




