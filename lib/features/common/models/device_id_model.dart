class DeviceIdModel {

  String? deviceId;

  Map<String, String> toJson() {

    return {
      "deviceId": deviceId.toString()
    };
  }

}