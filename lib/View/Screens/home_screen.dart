import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

import '../../Utils/image_url_list.dart';
import '../../Utils/news_list.dart';
import '../../tesy.dart';
import '../Widgets/news_card.dart';
import '../Widgets/option_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String locationMessage;
  late double lat = 0,
      long = 0,
  // dLat = 51.1397 ,
  // dLong = 37.92453,
      dLat = 37.4219979 ,
      dLong = -122.084;


  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("error");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("error");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("error");
    }
    return await Geolocator.getCurrentPosition();

  }

  @override
  void initState() {
    // TODO: implement initState
    _getCurrentLocation().then((value) {
      lat = value.latitude;
      long = value.longitude;
   dLat=lat;
   dLong=long;
      setState(() {

        double test =    Geolocator.distanceBetween(lat, long, dLat, dLong)/1000;
        locationMessage = 'Lat ${lat} ,Long $long';
        log(locationMessage);
        log( '$test');
        if(test<=2){
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.red,
                title: const Text('FIRE ALERT',style: TextStyle(
                    color: Colors.white
                )),
                content:  Text(
                    "Please leave the place by the nearest exit ".toUpperCase(),style: TextStyle(
                    color: Colors.white
                )
                ),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Disable',style: TextStyle(
                      color: Colors.white
                    )),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Call 911',style: TextStyle(
                        color: Colors.white
                    )),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(244, 243, 243, 1),
      backgroundColor: Color(0xCDa5afac),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black87,
          ),
          onPressed: () {},
        ), systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30))),
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Nasa Space Apps',
                      style: TextStyle(color: Color(0xCD6d8176), fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Fire Management System',
                      style: TextStyle(
                        color : Color(0xCD6d8176),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),


                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      'Today\'s News',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 300,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          promoCard(imagesUrlList[0]),
                          promoCard(imagesUrlList[1]),
                          promoCard(imagesUrlList[2]),
                          promoCard(imagesUrlList[3]),
                          promoCard(imagesUrlList[0]),
                          promoCard(imagesUrlList[1]),
                          promoCard(imagesUrlList[2]),
                          promoCard(imagesUrlList[3]),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight: Radius.circular(30))
                    ),
                      width: MediaQuery.of(context).size.width,
                      height: 110,
                     child: Align(alignment: Alignment.center ,child: OptionsView())),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
