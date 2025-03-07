import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iptv_mobile/providers/login_provider.dart';

import 'channelCategory.dart';
import 'channelLanguage.dart';
import 'country.dart';
import 'package.dart';

class Order {
  late int id;
  late String name;
  late int type;
  late int status;
  late DateTime? dateFrom;
  late DateTime? dateTo;
  late String note;
  late double price;
  late double? discount;
  late double totalPrice;
  late int packageId;
  late Package package;
  late int userId;

  Order();

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    type = json['type'];
    dateFrom= DateTime.parse(json['dateFrom']);
    dateTo= DateTime.parse(json['dateTo']);
    note = json['note'];
    price = json['price'].toDouble();
    discount = json['discount'] != null ? json['discount'].toDouble() ?? 0.00 : 0.00;
    totalPrice = json['totalPrice'].toDouble();
    packageId = json['packageId'];
    userId = json['userId'];

    if (json['package'] != null) {
      package = Package.fromJson(json['package']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = 0;
    data['name'] = name ??'';
    data['status'] = 1;
    data['type'] = type;
    data['dateFrom'] = null;
    data['dateTo'] = null;
    data['note'] = note;
    data['price'] = price;
    data['discount'] = discount;
    data['totalPrice'] = totalPrice;
    data['packageId'] = packageId;
    data['userId'] = LoginProvider.authResponse?.userId;
    return data;
  }
}
