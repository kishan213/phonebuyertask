import 'package:phonebuyertask/utils/const/sql_const.dart';

class FavDeviceModel {
  List<FavdeviceData> devices = [];
  FavDeviceModel({required this.devices});

  FavDeviceModel.fromJson(var json) {
    if (json != null) {
      devices = <FavdeviceData>[];
      json.forEach((v) {
        devices.add(new FavdeviceData.fromJson(v));
      });
    }
  }
}

class FavdeviceData {
  String? name;
  double? price;
  String? description;
  String? brand;
  String? id;
  double? rating;
  String? thumbImageURL;

  FavdeviceData(
      {this.name,
      this.price,
      this.description,
      this.brand,
      this.id,
      this.rating,
      this.thumbImageURL});

  FavdeviceData.fromJson(Map<String, dynamic> json) {
    name = json[PRODUCT_NAME];
    price = double.parse(json[PRODUCT_PRICE].toString());
    description = json[PRODUCT_DESCRIPTION];
    brand = json[PRODUCT_BRANDG];
    id = json[PRODUCT_ID].toString();
    rating = json[PRODUCT_RATING];
    thumbImageURL = json[PRODUCT_IMAGE];
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
