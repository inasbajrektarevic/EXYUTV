import 'base.dart';
import 'order.dart';

class Payment extends BaseModel {
  late bool isPaid;
  late DateTime dateFrom;
  late DateTime dateTo;
  late int orderId;
  late Order? order;
  late int userId;
  late double price;
  late double discount;
  late String note;
  late int status;
  late String transactionId;

  Payment();

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionId = json['transactionId'];
    isPaid = json['isPaid'];
    dateFrom = DateTime.parse(json['dateFrom']);
    dateTo = DateTime.parse(json['dateTo']);
    userId = json['userId'];
    orderId = json['orderId'];
    if (json['order'] != null) {
      order = Order.fromJson(json['order']);
    }
    dynamic priceData = json['price'];
    if (priceData is int) {
      price = priceData.toDouble();
    } else if (priceData is double) {
      price = priceData;
    } else if (priceData is String) {
      price = double.tryParse(priceData) ?? 0.0;
    } else {
      price = 0.0;
    }
    dynamic discountData = json['discount'];
    if (discountData is int) {
      discount = discountData.toDouble();
    } else if (discountData is double) {
      discount = discountData;
    } else if (discountData is String) {
      discount = double.tryParse(discountData) ?? 0.0;
    } else {
      discount = 0.0;
    }
    note = json['note'] ?? '';
    status = json['status'] ?? 0;
  }
}
