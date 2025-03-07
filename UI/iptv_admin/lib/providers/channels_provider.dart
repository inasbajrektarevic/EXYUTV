import 'package:iptv_admin/models/apiResponse.dart';
import 'package:iptv_admin/providers/base_provider.dart';

import '../models/channel.dart';

class ChannelProvider extends BaseProvider<Channel> {
  ChannelProvider() : super('Channels');

  List<Channel> channels = <Channel>[];

  @override
  Future<List<Channel>> get(Map<String, String>? params) async {
    channels = await super.get(params);
    return channels;
  }

  @override
  Future<ApiResponse<Channel>> getForPagination(Map<String, String>? params) async {
     return await super.getForPagination(params);
  }

  @override
  Channel fromJson(data) {
    return Channel.fromJson(data);
  }
}