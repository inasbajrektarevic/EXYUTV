import 'channelCategory.dart';

class PackageChannelCategory {
  late int id;
  late int channelCategoryId;
  late ChannelCategory? channelCategory;
  late int packageId;

  PackageChannelCategory();

  PackageChannelCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    channelCategoryId = json['channelCategoryId'];
    if (json['channelCategory'] != null) {
      channelCategory = ChannelCategory.fromJson(json['channelCategory']);
    }
    packageId=json['packageId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['channelCategoryId'] = channelCategoryId;
    data['packageId'] = packageId;
    return data;
  }
}