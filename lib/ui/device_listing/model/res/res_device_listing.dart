import 'package:phonebuyertask/utils/const/api_param.dart';
import 'package:phonebuyertask/utils/const/sql_const.dart';

class ResDeviceListing {
  List<DeviceData> devices = [];
  ResDeviceListing({required this.devices});

  ResDeviceListing.fromJson(var json) {
    if (json != null) {
      devices = <DeviceData>[];
      json.forEach((v) {
        devices.add(new DeviceData.fromJson(v));
      });
    }
  }
}

class DeviceData {
  String? name;
  double? price;
  String? description;
  String? brand;
  String? id;
  double? rating;
  String? thumbImageURL;
  bool isFavProduct = false;

  DeviceData(
      {this.name,
      this.price,
      this.description,
      this.brand,
      this.id,
      this.rating,
      this.thumbImageURL});

  DeviceData.fromJson(Map<String, dynamic> json) {
    name = json[apiDeviceNameParam];
    price = double.parse(json[apiPriceParam].toString());
    description = json[apiDescriptionParam];
    brand = json[apiBrandParam];
    id = json[apiIdParam].toString();
    rating = json[apiRatingParam];
    thumbImageURL = json[apiThumbUrlParam];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[PRODUCT_NAME] = this.name;
    data[PRODUCT_PRICE] = this.price;
    data[PRODUCT_DESCRIPTION] = this.description;
    data[PRODUCT_BRANDG] = this.brand;
    data[PRODUCT_ID] = this.id;
    data[PRODUCT_RATING] = this.rating;
    data[PRODUCT_IMAGE] = this.thumbImageURL;
    return data;
  }
}
