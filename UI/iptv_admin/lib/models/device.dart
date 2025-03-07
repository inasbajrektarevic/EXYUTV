import 'deviceType.dart';

class Device {
  late int id = 0;
  late String name = '';
  late int deviceTypeId;
  late DeviceType? deviceType;
  late String manufacturer = '';
  late String model = '';
  late String serialNumber = '';

  Device();

  Device.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    deviceTypeId = json['deviceTypeId'];
    manufacturer = json['manufacturer'];
    model = json['model'];
    serialNumber = json['serialNumber'];

    if (json['deviceType'] != null) {
      deviceType = DeviceType.fromJson(json['deviceType']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['deviceTypeId'] = deviceTypeId;
    data['manufacturer'] = manufacturer;
    data['model'] = model;
    data['serialNumber'] = serialNumber;
    return data;
  }
}