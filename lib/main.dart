import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phonebuyertask/ui/device_details/controller/device_details_controller.dart';
import 'package:phonebuyertask/ui/device_listing/controller/device_listing_controller.dart';
import 'package:provider/provider.dart';
// import 'package:get/get.dart';
import 'base/di/locator.dart';
import 'utils/localization/localization.dart';
import 'utils/const/app_constants.dart';
import 'ui/splash/screen/splash_screen.dart';
import 'utils/const/color_utils.dart';
import 'base/navigation/navigation_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Register controller
  // Get.put(DeviceListingController());
  // Get.put(DeviceDetailsController());
  //init di manager
  await setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ListenableProvider<DeviceListingController>(
          create: (_) => DeviceListingController(),
        ),
        ListenableProvider<DeviceDetailsController>(
          create: (_) => DeviceDetailsController(),
        ),
      ],
      child: MaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData(
          brightness: Brightness.light,
        ),
        theme: ThemeData(
          primaryColor: primaryColor,
          accentColor: primaryColor,
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
        ),
        builder: (context, child) {
          return MediaQuery(
            child: child!,
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          );
        },
        home: SplashScreen(),
        onGenerateRoute: locator<NavigationUtils>().generateRoute,
        localizationsDelegates: [
          const MyLocalizationsDelegate(),
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''),
        ],
      ),
    );
  }
}
