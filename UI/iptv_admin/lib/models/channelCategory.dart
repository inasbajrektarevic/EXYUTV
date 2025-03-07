class ChannelCategory {
  late int id;
  late String name;
  late String description;
  late int orderNumber;
  late bool isActive;

  ChannelCategory();

  ChannelCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description=json['description'];
    orderNumber=json['orderNumber'];
    isActive = json['isActive'];
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