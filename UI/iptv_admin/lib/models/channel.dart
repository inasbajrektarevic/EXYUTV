import 'package:iptv_admin/models/channelCategory.dart';
import 'package:iptv_admin/models/channelLanguage.dart';
import 'package:iptv_admin/models/country.dart';

class Channel {
  late int id;
  late String name;
  late double frequency;
  late String logoUrl;
  late String description;
  late int channelCategoryId;
  late ChannelCategory? channelCategory;
  late int countryId;
  late Country? country;
  late int channelLanguageId;
  late ChannelLanguage? channelLanguage;
  late String streamUrl;
  late int channelNumber;
  late String owner;
  late bool isHD;

  Channel();

  Channel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    frequency =
        json['frequency'] != null ? json['frequency'].toDouble() ?? 0.00 : 0.00;
    logoUrl = json['logoUrl'];
    description = json['description'];
    streamUrl = json['streamUrl'];
    channelNumber = json['channelNumber'];
    owner = json['owner'];
    channelCategoryId = json['channelCategoryId'];
    channelLanguageId = json['channelLanguageId'];
    countryId = json['countryId'];
    isHD = json['isHD'];

    if (json['country'] != null) {
      country = Country.fromJson(json['country']);
    }
    if (json['channelCategory'] != null) {
      channelCategory = ChannelCategory.fromJson(json['channelCategory']);
    }
    if (json['channelLanguage'] != null) {
      channelLanguage = ChannelLanguage.fromJson(json['channelLanguage']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['frequency'] = frequency;
    data['logoUrl'] = logoUrl;
    data['description'] = description;
    data['streamUrl'] = streamUrl;
    data['channelNumber'] = channelNumber;
    data['owner'] = owner;
    data['channelCategoryId'] = channelCategoryId;
    data['channelLanguageId'] = channelLanguageId;
    data['countryId'] = countryId;
    data['isHD'] = isHD;
    return data;
  }
}
