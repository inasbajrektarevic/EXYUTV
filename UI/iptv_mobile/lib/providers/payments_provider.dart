import '../models/apiResponse.dart';
import '../models/payment.dart';
import '../utils/authorization.dart';
import 'base_provider.dart';
import 'package:http/http.dart' as http;

class PaymentProvider extends BaseProvider<Payment> {
  PaymentProvider() : super('Payments');

  List<Payment> items = <Payment>[];

  @override
  Future<List<Payment>> get(Map<String, String>? params) async {
    items = await super.get(params);
    return items;
  }

  @override
  Future<ApiResponse<Payment>> getForPagination(Map<String, String>? params) async {
     return await super.getForPagination(params);
  }

  Future<bool> setIsPaid(int id, String transactionId) async {
    var url = "$apiUrl/$endpoint/SetIsPaid/$id/$transactionId";
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
  Payment fromJson(data) {
    return Payment.fromJson(data);
  }
}