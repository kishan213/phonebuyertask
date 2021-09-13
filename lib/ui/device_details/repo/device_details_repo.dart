import 'package:dio/dio.dart';
import 'package:phonebuyertask/base/api/api_manager.dart';
import 'package:phonebuyertask/base/api/res_base_model.dart';
import 'package:phonebuyertask/ui/device_details/model/res/res_device_images_model.dart';
import 'package:phonebuyertask/utils/const/api_endpoint.dart';

class DeviceDetailRepo {
  Future<ResDeviceImages> getDeviceImages(String id) async {
    try {
      final response = await ApiService().get(
        apiDeviceList + id + apiDeviceImagesList,
      );
      return ResDeviceImages.fromJson(response.data);
    } on DioError catch (error) {
      throw ResBaseModel.fromJson(error.response?.data);
    }
  }
}
