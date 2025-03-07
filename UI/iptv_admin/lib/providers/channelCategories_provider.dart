import 'package:iptv_admin/models/apiResponse.dart';
import 'package:iptv_admin/models/channelCategory.dart';
import 'package:iptv_admin/providers/base_provider.dart';

class ChannelCategoryProvider extends BaseProvider<ChannelCategory> {
  ChannelCategoryProvider() : super('ChannelCategories');

  List<ChannelCategory> channelCategories = <ChannelCategory>[];

  @override
  Future<List<ChannelCategory>> get(Map<String, String>? params) async {
    channelCategories = await super.get(params);
    return channelCategories;
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