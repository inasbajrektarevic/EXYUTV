import 'package:iptv_admin/models/apiResponse.dart';
import 'package:iptv_admin/providers/base_provider.dart';

import '../models/device.dart';

class DeviceProvider extends BaseProvider<Device> {
  DeviceProvider() : super('Devices');

  List<Device> devices = <Device>[];

  @override
  Future<List<Device>> get(Map<String, String>? params) async {
    devices = await super.get(params);
    return devices;
  }

  @override
  Future<ApiResponse<Device>> getForPagination(Map<String, String>? params) async {
     return await super.getForPagination(params);
  }

  @override
  Device fromJson(data) {
    return Device.fromJson(data);
  }
}