import '../models/apiResponse.dart';
import '../models/order.dart';
import '../utils/authorization.dart';
import 'base_provider.dart';
import 'package:http/http.dart' as http;

class OrderProvider extends BaseProvider<Order> {
  OrderProvider() : super('Orders');

  List<Order> items = <Order>[];

  @override
  Future<List<Order>> get(Map<String, String>? params) async {
    items = await super.get(params);
    return items;
  }

  @override
  Future<ApiResponse<Order>> getForPagination(Map<String, String>? params) async {
     return await super.getForPagination(params);
  }

  Future<bool> updateStatus(int id, int status) async {
    var url = "$apiUrl/$endpoint/UpdateStatus/$id?status=$status";
    var uri = Uri.parse(url);

    Map<String, String> headers = Authorization.createHeaders();
    var response = await http.post(uri, headers: headers);

    if (isValidResponseCode(response)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Order fromJson(data) {
    return Order.fromJson(data);
  }
}