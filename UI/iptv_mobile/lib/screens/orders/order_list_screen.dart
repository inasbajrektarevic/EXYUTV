import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iptv_mobile/models/order.dart';
import 'package:iptv_mobile/providers/login_provider.dart';
import 'package:iptv_mobile/providers/orders_provider.dart';
import 'package:iptv_mobile/screens/packages/package_preview_screen.dart';
import '../../models/package.dart';
import '../../providers/packages_provider.dart';
import '../../widgets/exyutv_drawer.dart';
import 'order_preview_screen.dart';

class OrderListScreen extends StatefulWidget {
  static const String routeName = "orders";

  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  final OrderProvider _orderProvider = OrderProvider();
  final TextEditingController _searchController = TextEditingController();
  List<Order> data = [];
  List<Order> _filteredData = [];
  final ScrollController scrollController = ScrollController();
  int page = 1;
  int pageSize = 10;
  int totalRecordCounts = 0;
  String searchFilter = '';
  int numberOfPages = 2;
  int currentPage = 1;
  bool isLoading = true;
  bool deleteList = false;
  final apiUrl = dotenv.env['API_URL']!;

  @override
  void initState() {
    super.initState();
    loadData(searchFilter, page, pageSize);
    scrollController.addListener(_scrollListener);
  }

  Future<void> loadData(String searchFilter, int page, int pageSize) async {
    if (searchFilter != '') {
      page = 1;
    }
    var response = await _orderProvider?.getForPagination({
      'SearchFilter': searchFilter.toString() ?? "",
      'UserId': LoginProvider.authResponse?.userId.toString() ?? '',
      'PageNumber': page.toString(),
      'PageSize': pageSize.toString()
    });
    setState(() {
      if (searchFilter != '' || deleteList) {
        data = response?.items as List<Order>;
        if (searchFilter == '') {
          deleteList = false;
        }
      } else {
        data.addAll(response?.items as List<Order>);
      }
    });
    totalRecordCounts = response?.totalCount as int;
    numberOfPages = ((totalRecordCounts - 1) / pageSize).toInt() + 1;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Narudžbe"),
      ),
      drawer: ExyutvDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildChildSearch(),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final order = data[index];
                return _buildCard(order);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        "Narudžbe",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildChildSearch() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        controller: _searchController,
        onChanged: (value) async {
          if (value.isEmpty) {
            setState(() {
              deleteList = true;
              page = 1;
            });
          } else {
            setState(() {
              deleteList = false;
            });
          }
          searchFilter = value.toString();
          await loadData(searchFilter, page, pageSize);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          hintText: "Pretraga",
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(Order order) {
    String getStatusText() {
      if (order.dateTo!.isBefore(DateTime.now())) {
        return "Istekla";
      }
      switch (order.status) {
        case 4:
          return "U procesu";
        case 3:
          return "Aktivna";
        case 5:
          return "Završena";
        default:
          return "Nepoznato";
      }
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.grey[200],
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderPreviewScreen(order: order),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                Icons.shopping_cart,
                size: 40,
                color: Colors.teal,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${order.name} (${order.type == 1 ? 'Mjesečna' : 'Godišnja'})",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money,
                          size: 18,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Cijena: ${order.price} KM",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.local_offer,
                          size: 18,
                          color: Colors.green,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Popust: ${order.discount} %",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.price_check,
                          size: 18,
                          color: Colors.lightBlueAccent,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Ukupna cijena: ${order.totalPrice} KM",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.lightBlueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 18,
                          color: Colors.redAccent,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Status: ${getStatusText()}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (!deleteList) {
        page++;
        loadData(searchFilter, page, pageSize);
      }
    }
  }
}