import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iptv_mobile/models/order.dart';
import 'package:iptv_mobile/models/package.dart';
import 'package:iptv_mobile/screens/orders/order_list_screen.dart';
import 'package:provider/provider.dart';
import '../../models/listItem.dart';
import '../../providers/dropdown_provider.dart';
import '../../providers/orders_provider.dart';

class OrderCreateScreen extends StatefulWidget {
  final Package package;
  const OrderCreateScreen({Key? key, required this.package}) : super(key: key);

  @override
  State<OrderCreateScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController noteController = TextEditingController();
  bool isFirstSubmit = false;

  OrderProvider? _orderProvider;
  DropdownProvider? _dropdownProvider;
  List<ListItem> orderTypes = [];
  ListItem? selectedOrderType;
  double totalPrice = 0;

  @override
  void initState() {
    super.initState();
    _dropdownProvider = context.read<DropdownProvider>();
    _orderProvider = OrderProvider();
    loadOrderTypes();
    totalPrice = 0;
  }

  Future loadOrderTypes() async {
    var response = await _dropdownProvider?.getItems("orderTypes");
    setState(() {
      orderTypes = response ?? [];
    });
  }

  void updateTotalPrice() {
    if (selectedOrderType == null) return;
    setState(() {
      totalPrice = selectedOrderType!.key == 1
          ? widget.package.price
          : widget.package.price * 12;
      if (widget.package.discount != null) {
        var discount = (widget.package.discount! * widget.package.price / 100);
        totalPrice -= selectedOrderType!.key == 1 ? discount : discount * 12;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kreiranje narudžbe",
            style: GoogleFonts.montserrat(
                color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal[400],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    _buildDetailRow(
                        Icons.label, 'Naziv', widget.package.name, Colors.blue),
                    _buildDetailRow(
                        Icons.attach_money,
                        'Cijena',
                        '\$${widget.package.price.toStringAsFixed(2)}',
                        Colors.green),
                    _buildDetailRow(
                        Icons.discount,
                        'Popust',
                        widget.package.discount != null
                            ? '\$${widget.package.discount!.toStringAsFixed(2)}'
                            : '0.00',
                        Colors.orange),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _buildCard(
                child: DropdownButtonFormField<ListItem>(
                  key: Key('orderTypeDropdown'),
                  value: selectedOrderType,
                  onChanged: (ListItem? newValue) {
                    setState(() {
                      selectedOrderType = newValue;
                      updateTotalPrice();
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Tip narudžbe",
                    prefixIcon: Icon(Icons.mobile_friendly),
                  ),
                  validator: (value) =>
                      value == null ? 'Molimo odaberite tip narudžbe' : null,
                  items: orderTypes.map((ListItem item) {
                    return DropdownMenuItem<ListItem>(
                      value: item,
                      child: Text(item.value),
                    );
                  }).toList(),
                  hint: const Text('Odaberite tip narudžbe'),
                ),
              ),
              const SizedBox(height: 12),
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text("Napomena",
                        style: GoogleFonts.montserrat(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: noteController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Napomena',
                        border: OutlineInputBorder(),
                        hintText: 'Unesite napomenu',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ukupan iznos",
                        style: GoogleFonts.montserrat(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text("\$${totalPrice.toStringAsFixed(2)}",
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var order = Order();
                      order.type = selectedOrderType!.key;
                      order.price = widget.package.price;
                      order.discount = widget.package.discount;
                      order.totalPrice = totalPrice;
                      order.note = noteController.text;
                      order.dateFrom = DateTime.now();
                      order.dateTo = DateTime.now();
                      order.packageId = widget.package.id;
                      order.name = '';
                      bool? result = await _orderProvider?.insert(order);
                      if (result != null && result) {
                        Fluttertoast.showToast(
                            msg: "Narudžba uspješno kreirana",
                            backgroundColor: Colors.green);
                        Navigator.popAndPushNamed(
                            context, OrderListScreen.routeName);
                      } else {
                        Fluttertoast.showToast(
                            msg: "Greška prilikom kreiranja narudžbe",
                            backgroundColor: Colors.red);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[400]),
                  child: const Text("Rezerviši",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      IconData icon, String label, String value, Color iconColor) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: GoogleFonts.montserrat(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ))
        ]));
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(padding: const EdgeInsets.all(16.0), child: child),
    );
  }
}
