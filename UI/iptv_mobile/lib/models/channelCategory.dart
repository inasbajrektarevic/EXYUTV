import 'package:iptv_mobile/models/channel.dart';

class ChannelCategory {
  late int id;
  late String name;
  late String description;
  late int orderNumber;
  late bool isActive;
  late List<Channel> channels;

  ChannelCategory() {
    channels = [];
  }

  ChannelCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    orderNumber = json['orderNumber'];
    isActive = json['isActive'];

    if (json['channels'] != null) {
      channels = (json['channels'] as List)
          .map((channelJson) => Channel.fromJson(channelJson))
          .toList();
    } else {
      channels = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['orderNumber'] = orderNumber;
    data['isActive'] = isActive;
    return data;
  }
}
