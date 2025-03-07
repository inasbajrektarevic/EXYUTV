class ChannelLanguage {
  late int id;
  late String name;
  late String cultureName;
  late bool isActive;

  ChannelLanguage();

  ChannelLanguage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cultureName=json['cultureName'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['cultureName'] = cultureName;
    data['isActive'] = isActive;
    return data;
  }
}