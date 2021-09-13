class ResDeviceImages {
  List<DeviceImage?> deviceImages = [];
  ResDeviceImages({required this.deviceImages});

  ResDeviceImages.fromJson(var json) {
    if (json != null) {
      deviceImages = <DeviceImage>[];
      json.forEach((v) {
        deviceImages.add(new DeviceImage.fromJson(v));
      });
    }
  }
}

class DeviceImage {
  String? url;
  int? mobileId;
  int? id;

  DeviceImage({this.url, this.mobileId, this.id});

  DeviceImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    mobileId = json['mobile_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['mobile_id'] = this.mobileId;
    data['id'] = this.id;
    return data;
  }
}
