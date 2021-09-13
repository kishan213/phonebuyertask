import 'package:flutter/material.dart';
import 'package:phonebuyertask/base/di/locator.dart';
import 'package:phonebuyertask/ui/device_details/model/res/res_device_images_model.dart';
import 'package:phonebuyertask/ui/device_details/repo/device_details_repo.dart';
import 'package:phonebuyertask/ui/device_listing/model/res/res_device_listing.dart';
import 'package:phonebuyertask/ui/device_listing/repo/device_listing_repo.dart';
import 'package:phonebuyertask/utils/progress_dialog.dart';

class DeviceDetailsController extends ChangeNotifier {
  var isLoading = false;
  var resDeviceImages = ResDeviceImages(deviceImages: []);

  getDeviceImages(String id) {
    isLoading = (true);
    locator<DeviceDetailRepo>().getDeviceImages(id).then((value) {
      resDeviceImages.deviceImages = [];
      resDeviceImages = (value);
      isLoading = (false);
      notifyListeners();
    });
  }

  markDeviceAsFav(DeviceData deviceData, BuildContext context) {
    ProgressDialogUtils.showProgressDialog(context);
    locator<DeviceListingRepo>().insertData(deviceData);
    ProgressDialogUtils.dismissProgressDialog();
    notifyListeners();
  }

  removeDeviceFromFav(String id, BuildContext context) {
    ProgressDialogUtils.showProgressDialog(context);
    locator<DeviceListingRepo>().removeData(id);
    ProgressDialogUtils.dismissProgressDialog();
    notifyListeners();
  }
}
