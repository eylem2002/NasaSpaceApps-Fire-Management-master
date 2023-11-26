import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


import 'Core/Services/nasa_api_service.dart';
import 'Core/Services/nasa_api_service_all_world.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {

          },
          child: Text("TEST"),
        ),
      ),
    );
  }
}



