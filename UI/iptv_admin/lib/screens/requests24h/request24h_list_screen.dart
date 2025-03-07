import 'package:intl/intl.dart';
import 'package:iptv_admin/models/dailyPackageRequest.dart';
import 'package:iptv_admin/providers/dailyPackageRequests_provider.dart';
import 'package:iptv_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:number_paginator/number_paginator.dart';
import '../../enums/enums.dart';
import '../../utils/colorized_text_avatar.dart';

class Request24hListScreen extends StatefulWidget {
  static const String routeName = "dailyPackageRequests";

  const Request24hListScreen({Key? key}) : super(key: key);

  @override
  State<Request24hListScreen> createState() => _Request24hListScreenState();
}

class _Request24hListScreenState extends State<Request24hListScreen> {
  DailyPackageRequestProvider? _dailyPackageRequestProvider = null;
  TextEditingController _searchController = TextEditingController();
  GlobalKey<NumberPaginatorState> paginatorKey = GlobalKey();
  List<DailyPackageRequest> data = [];
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
    _dailyPackageRequestProvider = new DailyPackageRequestProvider();
    loadData(searchFilter, page, pageSize);
  }

  Future loadData(searchFilter, page, pageSize) async {
    if (searchFilter != '') {
      page = 1;
    }
    var response = await _dailyPackageRequestProvider?.getForPagination({
      'SearchFilter': searchFilter.toString() ?? "",
      'PageNumber': page.toString(),
      'PageSize': pageSize.toString()
    });
    setState(() {
      data = response?.items as List<DailyPackageRequest>;
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

  DataRow recentDataRow(DailyPackageRequest request, BuildContext context) {
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
                text: request.firstName!,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  request.firstName!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(request.lastName)),
        DataCell(Text(request.email)),
        DataCell(Text(request.phoneNumber)),
        request.status == 2
            ? DataCell(Text("U procesu"))
            : DataCell(Text("Završeno")),
        DataCell(Text(request.application.name)),
        DataCell(Text(request.device.name)),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.visibility, color: Colors.grey),
                onPressed: () {
                  showRequestDetails(context, request);
                },
              ),
              SizedBox(width: 6),
              if (request.status == 2)
                IconButton(
                  icon: Icon(Icons.check_circle, color: Colors.greenAccent),
                  onPressed: () {
                    showApprovalDialog(context, request);
                  },
                ),
              if (request.status == 2)
                IconButton(
                  icon: Icon(Icons.close, color: Colors.red),
                  onPressed: () {
                    showDeniedDialog(context, request);
                  },
                ),
              if (request.status == 3)
                Text(
                  "Odobreno",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              if (request.status == 4)
                Text(
                  "Odbijeno",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
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
        "Dnevni zahtjevi za listu",
        style: TextStyle(
            color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }

  void showRequestDetails(BuildContext context, DailyPackageRequest request) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          title: Text(
            "Detalji zahtjeva",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow("Ime", request.firstName),
                _buildDetailRow("Prezime", request.lastName),
                _buildDetailRow("Email", request.email),
                _buildDetailRow("Telefon", request.phoneNumber),
                _buildDetailRow("Aplikacija", request.application.name),
                _buildDetailRow("Uređaj", request.device.name),
                _buildDetailRow("Period",
                    "${formatDate(request.dateFrom)} - ${formatDate(request.dateTo)}"),
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
          Icon(Icons.info_outline, color: Colors.blue, size: 20),
          SizedBox(width: 8),
          Text(
            "$title: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void showApprovalDialog(BuildContext context, DailyPackageRequest request) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Odobrenje zahtjeva"),
          content: Text("Da li ste sigurni da želite odobriti zahtjev?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Odustani"),
            ),
            TextButton(
              onPressed: () {
                updateStatus(request, 3);
                Navigator.pop(context);
              },
              child: Text("Odobri", style: TextStyle(color: Colors.green)),
            )
          ],
        );
      },
    );
  }

  void showDeniedDialog(BuildContext context, DailyPackageRequest request) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Odbijanje zahtjeva"),
          content: Text("Da li ste sigurni da želite odbiti zahtjev?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Odustani"),
            ),
            TextButton(
              onPressed: () {
                updateStatus(request, 4);
                Navigator.pop(context);
              },
              child: Text("Odbij", style: TextStyle(color: Colors.green)),
            )
          ],
        );
      },
    );
  }

  Future updateStatus(DailyPackageRequest request, int status) async {
    await _dailyPackageRequestProvider?.updateStatus(request.id, status);
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
                  DataColumn(label: Text("Ime")),
                  DataColumn(label: Text("Prezime")),
                  DataColumn(label: Text("Email")),
                  DataColumn(label: Text("Broj telefona")),
                  DataColumn(label: Text("Status")),
                  DataColumn(label: Text("Aplikacija")),
                  DataColumn(label: Text("Uređaj")),
                  DataColumn(label: Text("")),
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
