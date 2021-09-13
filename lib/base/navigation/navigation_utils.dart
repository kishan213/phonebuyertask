import 'dart:io';

import 'package:phonebuyertask/ui/device_details/screen/device_details_screen.dart';
import 'package:phonebuyertask/ui/device_listing/screen/device_listing_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/const/navigation_param.dart';

class NavigationUtils {
  Route<dynamic> generateRoute(RouteSettings settings) {
    Map<String, dynamic>? args = settings.arguments as Map<String, dynamic>?;
    switch (settings.name) {
      case routeDeviceListing:
        return CupertinoPageRoute(builder: (_) => DeviceListingScreen());
      case routeDeviceDetails:
        return CupertinoPageRoute(
            builder: (_) => DeviceDetailsScreen(
                  devideData: args?["deviceData"],
                ));
      default:
        return _errorRoute(" Coming soon...");
    }
  }

  // ignore: non_constant_identifier_names
  dynamic DynamicRoute(dynamic screen) {
    return Platform.isAndroid
        ? MaterialPageRoute(builder: (_) => screen)
        : CupertinoPageRoute(builder: (_) => screen);
  }

  Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(title: Text('Error')),
          body: Center(child: Text(message)));
    });
  }

  void pushReplacement(BuildContext context, String routeName,
      {Object? arguments}) {
    Navigator.of(context).pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> push(BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  void pop(BuildContext context, {dynamic args}) {
    Navigator.of(context).pop(args);
  }

  Future<dynamic> pushAndRemoveUntil(BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.of(context).pushNamedAndRemoveUntil(
        routeName, (route) => false,
        arguments: arguments);
  }
}
