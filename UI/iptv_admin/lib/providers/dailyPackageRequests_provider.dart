import 'package:iptv_admin/models/apiResponse.dart';
import 'package:iptv_admin/models/dailyPackageRequest.dart';
import 'package:iptv_admin/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import '../utils/authorization.dart';

class DailyPackageRequestProvider extends BaseProvider<DailyPackageRequest> {
  DailyPackageRequestProvider() : super('DailyPackageRequests');

  List<DailyPackageRequest> items = <DailyPackageRequest>[];

  @override
  Future<List<DailyPackageRequest>> get(Map<String, String>? params) async {
    items = await super.get(params);

    return items;
  }

  @override
  Future<ApiResponse<DailyPackageRequest>> getForPagination(
      Map<String, String>? params) async {
    return await super.getForPagination(params);
  }

  Future<bool> updateStatus(int id, int status) async {
    var url = "$apiUrl/$endpoint/UpdateStatus/$id?status=$status";
    var uri = Uri.parse(url);

    Map<String, String> headers = Authorization.createHeaders();
    var response = await http.post(uri, headers: headers);

    if (isValidResponseCode(response)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  DailyPackageRequest fromJson(data) {
    return DailyPackageRequest.fromJson(data);
  }
}
