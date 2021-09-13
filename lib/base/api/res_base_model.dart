class ResBaseModel {
  String? message;
  String? deta;
  String? meta;
  String? error;
  bool? success;

  ResBaseModel({this.error, this.message, this.deta, this.meta, this.success});

  ResBaseModel.fromJson(dynamic json) {
    success = json["success"] ?? "";
    message = json["message"] ?? "";
    meta = json["meta"] ?? "";
    error = json["error"] ?? "";
    deta = json["deta"] ?? "";
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["message"] = message;
    map["meta"] = meta;
    map["error"] = error;
    map["deta"] = deta;
    map["success"] = success;
    return map;
  }
}
