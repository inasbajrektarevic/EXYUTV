import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../utils/authorization.dart';

class DashboardProvider {
  String endpoint = "Dashboard";
  String apiUrl = "";

  DashboardProvider() {
    apiUrl = String.fromEnvironment('API_URL', defaultValue: dotenv.env['API_URL']!);
  }

  Future<Map<String, dynamic>?> getClientData(int userId) async {
    var url = "$apiUrl/$endpoint/Client?userId=$userId";
    var uri = Uri.parse(url);

    var headers = Authorization.createHeaders();

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Greška: ${response.statusCode}, ${response.body}");
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
