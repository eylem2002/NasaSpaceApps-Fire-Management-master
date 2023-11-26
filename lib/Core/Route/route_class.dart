



import 'dart:developer';

import 'package:flutter/material.dart';

import '../../Utils/lib_organizer.dart';
import '../../View/Screens/get_world_map_data.dart';
import '../../View/Screens/home_screen.dart';
import '../../View/Screens/world_map_view_screen.dart';


class MyRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {


      case initRoute:
        {
          return _route(SplashScreen());
        }

      case getMapDataRoute:{
        return _route(GetMapData());
      }

      case getWorldMapDataRoute:{
        return _route(GetWorldData());
      }
      case homeRoute:{
        return _route(HomeScreen());
      }

      case getMapRoute:{
        var data  =settings.arguments as List<String>;
        log("From Route ${data.toString()}");
        return _route(MapViewScreen(mapData: data));
      }
      case getWorldMapRoute:{
        var data  =settings.arguments as List<String>;
        log("From Route ${data.toString()}");

        return _route(WorldMapViewScreen(mapData: data));
      }

      default:
        {
          final arg = settings.name as String;
          return _route(UndefineRoute(routeName: arg));
        }
    }
  }

  static MaterialPageRoute _route(Widget child) {
    return MaterialPageRoute(builder: (_) => child);
  }
}

class UndefineRoute extends StatelessWidget {
  const UndefineRoute({Key? key, required this.routeName}) : super(key: key);
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'This $routeName is Undefine Route',
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.grey.shade700),
        ),
      ),
    );
  }
}