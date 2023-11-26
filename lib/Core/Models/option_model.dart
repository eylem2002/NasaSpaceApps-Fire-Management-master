
import 'package:flutter/cupertino.dart';

import '../Route/static_routes.dart';

class Option{
  final String name;
  final String imagePath;
  final String navigationTo;

  Option({required this.name, required this.imagePath, required this.navigationTo});

}

List<Option> optionsList=[
  Option(imagePath:'assets/icons/map-marker.jpg',name: 'Area Map',navigationTo:getMapDataRoute ),
  Option(imagePath:'assets/icons/world.png',name: 'World',navigationTo:getWorldMapDataRoute
  ),
  Option(imagePath:'assets/icons/animal-therapy.png',name: 'IFAW',navigationTo: "IFAW page" ),

  Option(imagePath:'assets/icons/fire-hydrant.jpg',name: 'Help',navigationTo:"Help page"  ),



];

