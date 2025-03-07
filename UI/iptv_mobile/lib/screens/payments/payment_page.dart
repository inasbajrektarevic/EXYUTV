import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'package:intl/intl.dart';
import 'package:iptv_mobile/screens/payments/payment_success.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../models/appConfig.dart';
import '../../models/payment.dart';
import '../../providers/payments_provider.dart';

class PaymentPage extends StatefulWidget {
  static const String routeName = 'payment';
  final Payment payment;
  PaymentPage({required this.payment});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  PaymentProvider? _paymentProvider = null;
  AppConfig? appConfigData = null;
  bool isLoading = false;
  double monthlyFee = 0.0;

  @override
  void initState() {
    super.initState();
    _paymentProvider = new PaymentProvider();
  }

  showPaymentSheet() async {
    setState(() {
      isLoading = true;
    });
    var paymentIntentData =
        await createPaymentIntent(widget.payment.price.toString(), 'BAM');
    await Stripe.instance
        .initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentData['client_secret'],
        merchantDisplayName: 'Ex-yu TV',
        appearance: const PaymentSheetAppearance(
          primaryButton: PaymentSheetPrimaryButtonAppearance(
              colors: PaymentSheetPrimaryButtonTheme(
                  light: PaymentSheetPrimaryButtonThemeColors(
                      background: Colors.cyan))),
        ),
      ),
    )
        .then((value) {
    }).onError((error, stackTrace) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Transakcija nije uspjela"),
              ));
    });

    try {
      await Stripe.instance.presentPaymentSheet();
      SetPaymentIsPaid(paymentIntentData['id']);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PaymentSuccess(),
        ),
      );
    } catch (e) {
      //silent
    }
    setState(() {
      isLoading = false;
    });
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': ((widget.payment.price.toInt() ?? 1) * 100).toString(),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer ${dotenv.env['STRIPE_SECRET']}',
            'Content-Type': 'application/x-www-form-urlencoded'
          });

      return jsonDecode(response.body);
    } catch (err) {
      //silent
    }
  }

  Widget build(BuildContext context) {
    final Payment payment = widget.payment;
    return Scaffold(
      appBar: AppBar(
        title: Text("Prikaz detalja uplate"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: payment != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Detalji plaćanja:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Divider(),
                      if (payment != null)
                        _buildDetailItem(
                            Icons.person,
                            "Narudžba",
                            "${payment.order?.name}" ??
                                '',
                            Colors.greenAccent),
                      _buildDetailItem(Icons.date_range, "Period",
                          "${formatDate(payment.order?.dateFrom)} - ${formatDate(payment.order?.dateTo)}", Colors.blueAccent),
                      _buildDetailItem(Icons.discount, "Popust",
                          payment.discount.toString() + "%" ?? '0.00', Colors.cyan),
                      _buildDetailItem(Icons.price_change, "Cijena",
                          payment.price.toString() + "KM" ?? '0.00', Colors.cyan),
                      if(payment.transactionId != "")
                      _buildDetailItem(Icons.price_change, "Transakcija",
                          payment.transactionId.toString() ?? '/', Colors.cyan),
                      _buildDetailItem(Icons.note, "Napomena",
                          payment.note ?? '/', Colors.yellowAccent),
                      payment.isPaid == false
                          ? Container(
                              width: double.infinity,
                              child: FractionallySizedBox(
                                  widthFactor: 1,
                                  child: SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.greenAccent,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: isLoading
                                            ? null
                                            : () async =>
                                                await showPaymentSheet(),
                                        child: Text(
                                          "Plati",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ))))
                          : Container()
                    ],
                  )
                : Column()),
      ),
    );
  }

  Widget _buildDetailItem(
      IconData icon, String label, String value, Color iconColor) {
    return Card(
      elevation: 3,
      shadowColor: Colors.grey[300],
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Icon(
              icon,
              size: 36,
              color: iconColor,
            ),
            title: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              value,
              style: TextStyle(
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatDate(DateTime? date) {
    return date != null ? DateFormat('dd.MM.yyyy').format(date) : 'Nepoznato';
  }

  SetPaymentIsPaid(String transactionId) async {
    await _paymentProvider?.setIsPaid(widget.payment.id, transactionId);
  }
}
