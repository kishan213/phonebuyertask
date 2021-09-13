import 'package:flutter/cupertino.dart';
import 'package:phonebuyertask/base/di/locator.dart';
import 'package:phonebuyertask/base/sqlservice/database_helper.dart';
import 'package:phonebuyertask/ui/device_listing/model/res/res_add_fav_device.dart';
import 'package:phonebuyertask/ui/device_listing/model/res/res_device_listing.dart';
import 'package:phonebuyertask/ui/device_listing/repo/device_listing_repo.dart';
import 'package:phonebuyertask/utils/progress_dialog.dart';

class DeviceListingController extends ChangeNotifier {
  var resDeviceListing = ResDeviceListing(devices: []);
  var isLoading = false;
  var olderResDeviceListing = ResDeviceListing(devices: []);

  var resFavDeviceListing = FavDeviceModel(devices: []);
  var oldResFavDeviceListing = FavDeviceModel(devices: []);
  var isFavDeviceLoading = false;

  var isFilterApply = false;

  getDeviceList() {
    isLoading = true;
    locator<DeviceListingRepo>().getAllDevices().then((value) {
      resDeviceListing.devices = [];
      value.devices.forEach((element) async {
        if (element.id != null && element.id!.isNotEmpty) {
          var isExistsInFav =
              await DatabaseHelper.instance.queryMobileData(element.id ?? "");
          if (isExistsInFav.length > 0) {
            value.devices[value.devices.indexOf(element)].isFavProduct = true;
          } else {
            value.devices[value.devices.indexOf(element)].isFavProduct = false;
          }
        }
        notifyListeners();
      });
      olderResDeviceListing = value;
      resDeviceListing = value;
      isLoading = false;
      notifyListeners();
    });
  }

  markDeviceAsFav(DeviceData deviceData, int index, BuildContext context) {
    ProgressDialogUtils.showProgressDialog(context);
    resDeviceListing.devices[index].isFavProduct = true;
    olderResDeviceListing.devices[index].isFavProduct = true;
    locator<DeviceListingRepo>().insertData(deviceData);
    ProgressDialogUtils.dismissProgressDialog();
    notifyListeners();
  }

  removeDeviceFromFav(String id, BuildContext context) {
    ProgressDialogUtils.showProgressDialog(context);

    resFavDeviceListing.devices.removeWhere((element) => element.id == id);
    olderResDeviceListing
        .devices[olderResDeviceListing.devices
            .indexWhere((element) => element.id == id)]
        .isFavProduct = false;

    resDeviceListing
        .devices[
            resDeviceListing.devices.indexWhere((element) => element.id == id)]
        .isFavProduct = false;
    locator<DeviceListingRepo>().removeData(id);
    ProgressDialogUtils.dismissProgressDialog();
    notifyListeners();
  }

  getAllFavDevices() {
    isFavDeviceLoading = true;
    locator<DeviceListingRepo>().getAllFavDevices().then((value) {
      resFavDeviceListing.devices = [];

      oldResFavDeviceListing = value;
      resFavDeviceListing = value;
      isFavDeviceLoading = false;
      notifyListeners();
    });
  }

  sortByPrice(bool isDeciding) {
    isFilterApply = true;

    resDeviceListing.devices
        .sort((a, b) => a.price?.compareTo(b.price ?? 0) ?? 0);
    if (resFavDeviceListing.devices != null) {
      resFavDeviceListing.devices
          .sort((a, b) => a.price?.compareTo(b.price ?? 0) ?? 0);
    }

    if (isDeciding) {
      resDeviceListing.devices = resDeviceListing.devices.reversed.toList();
      if (resFavDeviceListing.devices.isNotEmpty) {
        resFavDeviceListing.devices =
            resFavDeviceListing.devices.reversed.toList();
      }
    }
    notifyListeners();
  }

  sortByRating() {
    notifyListeners();
    isFilterApply = (true);

    resDeviceListing.devices
        .sort((a, b) => a.rating?.compareTo(b.rating ?? 0) ?? 0);
    resDeviceListing.devices = resDeviceListing.devices.reversed.toList();
    if (resFavDeviceListing.devices.isNotEmpty) {
      resFavDeviceListing.devices
          .sort((a, b) => a.rating?.compareTo(b.rating ?? 0) ?? 0);
      resFavDeviceListing.devices =
          resFavDeviceListing.devices.reversed.toList();
    }
    notifyListeners();
  }

  cleanFilter() {
    isFilterApply = (false);
    resDeviceListing = olderResDeviceListing;
    resFavDeviceListing = oldResFavDeviceListing;
  }
}
