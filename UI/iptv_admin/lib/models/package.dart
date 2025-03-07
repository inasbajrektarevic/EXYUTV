import 'package:iptv_admin/models/channelCategory.dart';
import 'package:iptv_admin/models/country.dart';
import 'package:iptv_admin/models/packageChannelCategory.dart';

class Package {
  late int id;
  late String name;
  late int status;
  late bool isPromotional;
  late bool requiresSubscription;
  late int countryId;
  late Country? country;
  late double price;
  late double? discount;
  late String? iconUrl;
  late String description;
  late int createdById;
  late List<PackageChannelCategory> channelCategories;

  Package() {
    channelCategories = [];
  }

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    isPromotional = json['isPromotional'];
    requiresSubscription = json['requiresSubscription'];
    countryId = json['countryId'];
    price = json['price'].toDouble();
    discount = json['discount']?.toDouble() ?? 0.00;
    iconUrl = json['iconUrl'];
    description = json['description'];
    createdById = json['createdById'];

    if (json['country'] != null) {
      country = Country.fromJson(json['country']);
    }

    if (json['channelCategories'] != null) {
      channelCategories = (json['channelCategories'] as List)
          .map((category) => PackageChannelCategory.fromJson(category))
          .toList();
    } else {
      channelCategories = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['isPromotional'] = isPromotional;
    data['requiresSubscription'] = requiresSubscription;
    data['countryId'] = countryId;
    data['price'] = price;
    data['discount'] = discount;
    data['iconUrl'] = iconUrl;
    data['description'] = description;
    data['createdById'] = createdById;

    if (channelCategories != null) {
      data['channelCategories'] =
          channelCategories.map((category) => category.toJson()).toList();
    }
    return data;
  }
}
