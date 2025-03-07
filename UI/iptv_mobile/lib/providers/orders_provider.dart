import 'package:iptv_mobile/models/order.dart';
import '../models/apiResponse.dart';
import 'base_provider.dart';

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

  @override
  Order fromJson(data) {
    return Order.fromJson(data);
  }
}