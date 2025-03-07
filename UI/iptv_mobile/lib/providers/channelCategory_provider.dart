import '../models/apiResponse.dart';
import '../models/channelCategory.dart';
import '../models/package.dart';
import 'base_provider.dart';

class ChannelCategoryProvider extends BaseProvider<ChannelCategory> {
  ChannelCategoryProvider() : super('ChannelCategories');

  List<ChannelCategory> data = <ChannelCategory>[];

  @override
  Future<List<ChannelCategory>> get(Map<String, String>? params) async {
    data = await super.get(params);
    return data;
  }

  @override
  Future<ApiResponse<ChannelCategory>> getForPagination(Map<String, String>? params) async {
     return await super.getForPagination(params);
  }

  @override
  ChannelCategory fromJson(data) {
    return ChannelCategory.fromJson(data);
  }
}