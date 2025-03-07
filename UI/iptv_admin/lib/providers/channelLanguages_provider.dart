import 'package:iptv_admin/models/apiResponse.dart';
import 'package:iptv_admin/models/channelLanguage.dart';
import 'package:iptv_admin/providers/base_provider.dart';

class ChannelLanguageProvider extends BaseProvider<ChannelLanguage> {
  ChannelLanguageProvider() : super('ChannelLanguages');

  List<ChannelLanguage> channelLanguages = <ChannelLanguage>[];

  @override
  Future<List<ChannelLanguage>> get(Map<String, String>? params) async {
    channelLanguages = await super.get(params);
    return channelLanguages;
  }

  @override
  Future<ApiResponse<ChannelLanguage>> getForPagination(Map<String, String>? params) async {
     return await super.getForPagination(params);
  }

  @override
  ChannelLanguage fromJson(data) {
    return ChannelLanguage.fromJson(data);
  }
}