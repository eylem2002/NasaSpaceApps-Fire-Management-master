import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../../Utils/lib_organizer.dart';



class NasaApiService {

  // String mapKey = "1c042fc10e6dd87b8a53350a7c8385fd";
  // String source = "VIIRS_SNPP_NRT";
  // String areaCoordinates = "USA/1";
  // String dayRange = "2023-10-01";
  final String mapKey = "1c042fc10e6dd87b8a53350a7c8385fd";
  final  String source = "VIIRS_SNPP_NRT";
  final  String areaCoordinates ;
  final String dayRange ;
  final String date ;

  NasaApiService({required this.dayRange, required this.areaCoordinates,required this.date});

  Future<String> _loadCountry() async {
    var requestCountry = http.Request(
        'GET',
        Uri.parse(
            'https://firms.modaps.eosdis.nasa.gov/api/country/csv/$mapKey/$source/$areaCoordinates/$dayRange/$date'));



    http.StreamedResponse responseCountry = await requestCountry.send();
    if (responseCountry.statusCode == 200) {
      return responseCountry.stream.bytesToString();
    } else {
     return('Failed to load data');
    }


  }



  Future<List<FireData>> parseResponseData() async{
    String responseData = await _loadCountry();

    List<FireData> parsedDataList = [];

    List<String> lines = responseData.split("\n");

    if (lines.isNotEmpty) {
      for (int i = 1; i < lines.length; i++) {
        // log(lines[i].runtimeType.toString());
          String line = lines[i];
          List<String> values = line.split(",");
        if (values.length == 15)
        {
 int c=0;
            FireData fireData = FireData();
            fireData.country_id = values[c++];
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




