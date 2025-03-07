import 'package:iptv_admin/models/apiResponse.dart';
import 'package:iptv_admin/models/package.dart';
import 'package:iptv_admin/providers/base_provider.dart';

import '../models/channel.dart';

class PackageProvider extends BaseProvider<Package> {
  PackageProvider() : super('Packages');

  List<Package> packages = <Package>[];

  @override
  Future<List<Package>> get(Map<String, String>? params) async {
    packages = await super.get(params);
    return packages;
  }

  @override
  Future<ApiResponse<Package>> getForPagination(Map<String, String>? params) async {
     return await super.getForPagination(params);
  }

  @override
  Package fromJson(data) {
    return Package.fromJson(data);
  }
}