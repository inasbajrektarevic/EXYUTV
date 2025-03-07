import 'dart:convert';

import '../models/apiResponse.dart';
import '../models/listItem.dart';
import '../models/listItemPackage.dart';
import '../models/package.dart';
import '../utils/authorization.dart';
import 'base_provider.dart';
import 'package:http/http.dart' as http;

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

  Future<List<ListItemPackage>> getRecommendedPackages(String userId) async {
    var uri = Uri.parse('$apiUrl/Packages/RecommendByClientId/$userId');

    var headers = Authorization.createHeaders();

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data.map((d) => ListItemPackage.fromJson(d)).cast<ListItemPackage>().toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Package fromJson(data) {
    return Package.fromJson(data);
  }
}