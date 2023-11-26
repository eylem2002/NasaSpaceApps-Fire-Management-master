import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import '../../Utils/theme_manager.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: ThemeManager.lightPrimary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100,),
            Expanded(
              flex: 4,
              child: Image.asset('assets/images/earth.png'),
            ),
            // CircularProgressIndicator(),
            SizedBox(height: 50,),
            SpinKitDoubleBounce(
              color: ThemeManager.accent,
              size: 50.0,
            ),

            Expanded(
              flex: 1,
              child: AnimatedSplashScreen(
                splash: 'assets/icons/world.png',
                splashIconSize: 0,
                backgroundColor: ThemeManager.lightPrimary,
                nextScreen: HomeScreen(),
                splashTransition: SplashTransition.fadeTransition,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

