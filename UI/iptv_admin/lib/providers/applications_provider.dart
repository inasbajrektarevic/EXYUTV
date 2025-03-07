import 'package:iptv_admin/models/apiResponse.dart';
import 'package:iptv_admin/models/application.dart';
import 'package:iptv_admin/providers/base_provider.dart';

class ApplicationProvider extends BaseProvider<Application> {
  ApplicationProvider() : super('Applications');

  List<Application> applications = <Application>[];

  @override
  Future<List<Application>> get(Map<String, String>? params) async {
    applications = await super.get(params);

    return applications;
  }

  @override
  Future<ApiResponse<Application>> getForPagination(Map<String, String>? params) async {
     return await super.getForPagination(params);
  }

  @override
  Application fromJson(data) {
    return Application.fromJson(data);
  }
}