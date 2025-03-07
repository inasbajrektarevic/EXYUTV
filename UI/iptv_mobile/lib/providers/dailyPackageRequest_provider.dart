import 'package:iptv_mobile/models/dailyPackageRequest.dart';

import '../models/apiResponse.dart';
import 'base_provider.dart';

class DailyPackageRequestProvider extends BaseProvider<DailyPackageRequest> {
  DailyPackageRequestProvider() : super('DailyPackageRequests');

  List<DailyPackageRequest> dailyPackageRequests = <DailyPackageRequest>[];

  @override
  Future<List<DailyPackageRequest>> get(Map<String, String>? params) async {
    dailyPackageRequests = await super.get(params);
    return dailyPackageRequests;
  }

  @override
  Future<ApiResponse<DailyPackageRequest>> getForPagination(Map<String, String>? params) async {
     return await super.getForPagination(params);
  }

  @override
  DailyPackageRequest fromJson(data) {
    return DailyPackageRequest.fromJson(data);
  }
}