import 'dart:convert';
import 'package:iptv_admin/models/listItem.dart';
import 'package:iptv_admin/providers/base_provider.dart';
import '../utils/authorization.dart';
import 'package:http/http.dart' as http;

class DropdownProvider extends BaseProvider<ListItem> {
  DropdownProvider() : super('Dropdown');

  List<ListItem> data = <ListItem>[];

  Future<List<ListItem>> getItems(String url) async {
    var uri = Uri.parse('$apiUrl/Dropdown/$url');

    var headers = Authorization.createHeaders();

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      return data.map((d) => fromJson(d)).cast<ListItem>().toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  ListItem fromJson(data) {
    return ListItem.fromJson(data);
  }
}