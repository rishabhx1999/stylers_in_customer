


class DeviceModel {
  String? deviceName;
  String? deviceModel;
  String? deviceToken;
  String? deviceOS;
  String? deviceOSVersion;
  String? deviceId;

  Map? details;

  DeviceModel(
      {this.deviceName,
        this.deviceModel,
        this.deviceToken,
        this.deviceOS,
        this.details,
        this.deviceOSVersion,
        this.deviceId});

  DeviceModel.fromJson(Map<String, dynamic> json) {
    deviceName = json['device_name'];
    deviceModel = json['device_model'];
    deviceToken = json['device_token'];
    deviceOS = json['device_os'];
    deviceOSVersion = json['deviceOSVersion'];
    details = json['details'];
    deviceId = json['deviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['device_name'] = this.deviceName;
    data['device_model'] = this.deviceModel;
    data['device_token'] = this.deviceToken;
    data['device_os'] = this.deviceOS;
    data['deviceOSVersion'] = this.deviceOSVersion;
    data['details'] = this.details;
    data['deviceId'] = this.deviceId;
    return data;
  }
}
