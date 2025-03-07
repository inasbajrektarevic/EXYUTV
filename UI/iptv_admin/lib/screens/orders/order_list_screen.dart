import 'package:intl/intl.dart';
import 'package:iptv_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:number_paginator/number_paginator.dart';
import '../../enums/enums.dart';
import '../../models/order.dart';
import '../../providers/orders_provider.dart';
import '../../utils/colorized_text_avatar.dart';

class OrderListScreen extends StatefulWidget {
  static const String routeName = "countries";

  const OrderListScreen({Key? key}) : super(key: key);

  @override
  State<OrderListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<OrderListScreen> {
  OrderProvider? _orderProvider = null;
  TextEditingController _searchController = TextEditingController();
  GlobalKey<NumberPaginatorState> paginatorKey = GlobalKey();
  List<Order> data = [];
  int page = 1;
  int pageSize = 5;
  int totalRecordCounts = 0;
  String searchFilter = '';
  bool isLoading = true;
  int numberOfPages = 1;
  int currentPage = 1;
  List<Center> pages = [];
  bool isFirstSubmit = false;

  @override
  void initState() {
    super.initState();
    _orderProvider = new OrderProvider();
    loadData(searchFilter, page, pageSize);
  }

  Future loadData(searchFilter, page, pageSize) async {
    if (searchFilter != '') {
      page = 1;
    }
    var response = await _orderProvider?.getForPagination({
      'SearchFilter': searchFilter.toString() ?? "",
      'PageNumber': page.toString(),
      'PageSize': pageSize.toString()
    });
    setState(() {
      data = response?.items as List<Order>;
    });
    totalRecordCounts = response?.totalCount as int;
    numberOfPages = ((totalRecordCounts - 1) / pageSize).toInt() + 1;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    pages = List.generate(numberOfPages, (index) => Center());
    return MasterScreenWidget(
        child: Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  _buildSearch(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(width: 10),
                    ],
                  ),
                  _buildList(context),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: pages[currentPage - 1],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        width: 300.0,
                        child: NumberPaginator(
                          numberPages: numberOfPages,
                          onPageChange: (index) {
                            setState(() {
                              currentPage = index + 1;
                              loadData("", currentPage, pageSize);
                            });
                          },
                          config: NumberPaginatorUIConfig(
                            height: 36,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    ));
  }

  DataRow recentDataRow(Order order, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              TextAvatar(
                size: 35,
                backgroundColor: Colors.white,
                textColor: Colors.white,
                fontSize: 14,
                upperCase: true,
                numberLetters: 1,
                shape: Shape.Rectangle,
                text: order.name!,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  order.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(order.user.firstName + " " + order.user.lastName)),
        DataCell(Text(
            "${formatDate(order.dateFrom)} - ${formatDate(order.dateTo)}")),
        DataCell(Text(order.price.toString())),
        DataCell(Text(order.discount.toString())),
        DataCell(Text(order.totalPrice.toString())),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.visibility, color: Colors.grey),
                onPressed: () {
                  showOrderDetails(context, order);
                },
              ),
              SizedBox(width: 6),
              if (order.status == 4)
                IconButton(
                  icon: Icon(Icons.check_circle, color: Colors.greenAccent),
                  onPressed: () {
                    showApprovalDialog(context, order);
                  },
                ),
              if (order.status == 3 || order.status == 4)
                IconButton(
                  icon: Icon(Icons.close, color: Colors.red),
                  onPressed: () {
                    showCompleteDialog(context, order);
                  },
                ),
              if (order.status == 5)
                Text(
                  "Završeno",
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
              if (order.status == 1 || order.status == 2)
                Text(
                  "U obradi",
                  style: TextStyle(
                      color: Colors.orange, fontWeight: FontWeight.bold),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        "Narudžbe",
        style: TextStyle(
            color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }

  void showOrderDetails(BuildContext context, Order order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          title: Text(
            "Detalji narudžbe",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow("Naziv", order.name),
                _buildDetailRow("Klijent",
                    "${order.user.firstName} ${order.user.lastName}"),
                _buildDetailRow("Period",
                    "${formatDate(order.dateFrom)} - ${formatDate(order.dateTo)}"),
                _buildDetailRow("Cijena (KM)", "${order.price} KM"),
                _buildDetailRow("Popust (%)", "${order.discount}%"),
                _buildDetailRow("Ukupna cijena (KM)", "${order.totalPrice} KM"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Zatvori",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            "$title: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  void showApprovalDialog(BuildContext context, Order order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Odobrenje narudžbe"),
          content: Text(
              "Da li ste sigurni da želite odobriti narudžbu ${order.name}?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Odustani"),
            ),
            TextButton(
              onPressed: () {
                updateStatus(order, 3);
                Navigator.pop(context);
              },
              child: Text("Odobri", style: TextStyle(color: Colors.green)),
            )
          ],
        );
      },
    );
  }

  void showCompleteDialog(BuildContext context, Order order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Završavanje narudžbe"),
          content: Text(
              "Da li ste sigurni da želite završiti narudžbu ${order.name}?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Odustani"),
            ),
            TextButton(
              onPressed: () {
                updateStatus(order, 5);
                Navigator.pop(context);
              },
              child: Text("Završi", style: TextStyle(color: Colors.green)),
            )
          ],
        );
      },
    );
  }

  Future updateStatus(Order order, int status) async {
    await _orderProvider?.updateStatus(order.id, status);
    loadData(searchFilter, page, pageSize);
  }

  Widget _buildSearch() {
    return Row(
      children: [
        SizedBox(
          width: 400.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), // Rounded corners
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) async {
                searchFilter = value;
                loadData(searchFilter, page, pageSize);
              },
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                hintText: "Pretraga...",
                hintStyle: TextStyle(color: Colors.grey[600]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none, // No border
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String formatDate(DateTime? date) {
    return date != null ? DateFormat('dd.MM.yyyy').format(date) : 'Nepoznato';
  }

  Container _buildList(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: DataTable(
                horizontalMargin: 0,
                columnSpacing: 16.0,
                columns: [
                  DataColumn(
                    label: Text("Naziv"),
                  ),
                  DataColumn(
                    label: Text("Klijent"),
                  ),
                  DataColumn(
                    label: Text("Period"),
                  ),
                  DataColumn(
                    label: Text("Cijena(KM)"),
                  ),
                  DataColumn(
                    label: Text("Popust(%)"),
                  ),
                  DataColumn(
                    label: Text("Ukupna cijena(KM)"),
                  ),
                  DataColumn(
                    label: Text(""),
                  ),
                ],
                rows: List.generate(
                  data.length,
                  (index) => recentDataRow(data[index], context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
