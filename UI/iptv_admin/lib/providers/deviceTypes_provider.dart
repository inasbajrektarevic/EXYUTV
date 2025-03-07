import 'package:iptv_admin/models/apiResponse.dart';
import 'package:iptv_admin/models/application.dart';
import 'package:iptv_admin/models/deviceType.dart';
import 'package:iptv_admin/providers/base_provider.dart';

class DeviceTypeProvider extends BaseProvider<DeviceType> {
  DeviceTypeProvider() : super('DeviceTypes');

  List<DeviceType> deviceTypes = <DeviceType>[];

  @override
  Future<List<DeviceType>> get(Map<String, String>? params) async {
    deviceTypes = await super.get(params);

    return deviceTypes;
  }

  @override
  Future<ApiResponse<DeviceType>> getForPagination(Map<String, String>? params) async {
     return await super.getForPagination(params);
  }

  @override
  DeviceType fromJson(data) {
    return DeviceType.fromJson(data);
  }
}