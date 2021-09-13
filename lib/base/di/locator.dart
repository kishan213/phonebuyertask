import 'package:get_it/get_it.dart';
import 'package:phonebuyertask/ui/device_details/controller/device_details_controller.dart';
import 'package:phonebuyertask/ui/device_details/repo/device_details_repo.dart';
import 'package:phonebuyertask/ui/device_listing/controller/device_listing_controller.dart';
import 'package:phonebuyertask/ui/device_listing/repo/device_listing_repo.dart';
import "../api/api_manager.dart";
import '../navigation/navigation_utils.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<NavigationUtils>(NavigationUtils());
  locator.registerSingleton<ApiService>(ApiService());

  locator.registerSingleton<DeviceListingRepo>(DeviceListingRepo());
  locator.registerSingleton<DeviceDetailRepo>(DeviceDetailRepo());
  locator.registerSingleton<DeviceListingController>(DeviceListingController());
  locator.registerSingleton<DeviceDetailsController>(DeviceDetailsController());
}
