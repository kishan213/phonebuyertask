import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phonebuyertask/base/di/locator.dart';
import 'package:phonebuyertask/base/navigation/navigation_utils.dart';
import 'package:phonebuyertask/utils/const/font_size_utils.dart';
import 'package:phonebuyertask/utils/const/image_utils.dart';
import 'package:phonebuyertask/utils/const/navigation_param.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  double dimension = 0.0;
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick == 1) {
        setState(() {
          dimension = screenSize.width * 0.8;
        });
      }
      if (timer.tick == 3) {
        _timer?.cancel();
        locator<NavigationUtils>()
            .pushAndRemoveUntil(context, routeDeviceListing);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    getScreenSize(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Center(
              child: AnimatedContainer(
                height: dimension,
                width: dimension,
                curve: Curves.linearToEaseOut,
                duration: Duration(seconds: 1),
                child: Container(
                  child: Center(
                    child: AnimatedContainer(
                      height: dimension,
                      width: dimension,
                      curve: Curves.linearToEaseOut,
                      duration: Duration(seconds: 1),
                      child: Image.asset(
                        icAppLogo,
                        scale: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
