import 'package:final_project_api/tesy.dart';
import 'package:flutter/material.dart';
import '../../Utils/lib_organizer.dart';
import 'View/Screens/get_world_map_data.dart';
import 'View/Screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeManager.appTheme,
      // home:GetWorldData()
      initialRoute:initRoute ,
      onGenerateRoute: MyRouter.generateRoute,
    );
  }
}
