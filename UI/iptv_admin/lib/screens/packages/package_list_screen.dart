import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:iptv_admin/providers/packages_provider.dart';
import 'package:iptv_admin/screens/packages/package_edit_screen.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';
import '../../helpers/color_constants.dart';
import '../../models/package.dart';
import '../../widgets/master_screen.dart';
import 'package_add_screen.dart';

class PackageListScreen extends StatefulWidget {
  static const String routeName = "packages";
  const PackageListScreen({Key? key}) : super(key: key);

  @override
  State<PackageListScreen> createState() => _PackageListScreenState();
}

class _PackageListScreenState extends State<PackageListScreen> {
  PackageProvider? _packageProvider = null;
  List<Package> data = [];
  TextEditingController _searchController = TextEditingController();
  int page = 1;
  int pageSize = 5;
  int totalRecordCounts = 0;
  String searchFilter = '';
  bool isLoading = true;
  int numberOfPages = 2;
  int currentPage = 1;
  @override
  void initState() {
    super.initState();
    _packageProvider = context.read<PackageProvider>();
    loadData(searchFilter, page, pageSize);
  }

  Future loadData(searchFilter, page, pageSize) async {
    if (searchFilter != '') {
      page = 1;
    }
    var response = await _packageProvider?.getForPagination({
      'PageNumber': page.toString(),
      'PageSize': pageSize.toString(),
      'SearchFilter': searchFilter
    });
    setState(() {
      data = response?.items as List<Package>;
    });
    totalRecordCounts = response?.totalCount as int;
    numberOfPages = (totalRecordCounts / pageSize).toInt() + 1;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var pages = List.generate(numberOfPages, (index) => Center());
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
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PackageAddScreen(),
                              ),
                            );
                          },
                          icon: Icon(Icons.add),
                          label: Text("Dodaj paket"),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.greenAccent),
                          ),
                        ),
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
      ),
    );
  }

  DataRow recentDataRow(Package data, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(Text(data.name)),
        DataCell(Text(data.status.toString())),
        DataCell(Text(data.price.toString())),
        DataCell(Text(data.discount.toString())),
        DataCell(Container(
          padding: EdgeInsets.all(5),
          child: Checkbox(
            activeColor: custom_green,
            value: data.isPromotional,
            onChanged: (value) {
              setState(() {});
            },
          ),
        )),
        DataCell(Container(
          padding: EdgeInsets.all(5),
          child: Checkbox(
            activeColor: custom_green,
            value: data.requiresSubscription,
            onChanged: (value) {
              setState(() {});
            },
          ),
        )),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PackageEditScreen(id: data.id),
                    ),
                  );
                },
              ),
              SizedBox(width: 6),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showDeleteModal(context, data);
                },
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
        "Paketi",
        style: TextStyle(
            color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }

  void showDeleteModal(BuildContext context, Package item) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return MaterialApp(
                home: AlertDialog(
                    title: Center(
                      child: Column(
                        children: [
                          Icon(Icons.warning_outlined,
                              size: 36, color: Colors.red),
                          SizedBox(height: 20),
                          Text("Brisanje"),
                        ],
                      ),
                    ),
                    content: Container(
                      height: 70,
                      child: Column(
                        children: [
                          Text("Da li želite obrisati paket ${item.name}?"),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                  icon: Icon(
                                    Icons.close,
                                    size: 14,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  label: Text("Izađi")),
                              SizedBox(
                                width: 20,
                              ),
                              ElevatedButton.icon(
                                  icon: Icon(
                                    Icons.delete,
                                    size: 14,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                  onPressed: () async {
                                    await deleteById(item.id);
                                    await loadData(searchFilter, 1, pageSize);
                                    Navigator.pop(context);
                                  },
                                  label: Text("Obriši"))
                            ],
                          )
                        ],
                      ),
                    )));
          });
        });
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
                    label: Text("Status"),
                  ),
                  DataColumn(
                    label: Text("Cijena(KM)"),
                  ),
                  DataColumn(
                    label: Text("Popust(%)"),
                  ),
                  DataColumn(
                    label: Text("Promocija"),
                  ),
                  DataColumn(
                    label: Text("Obavezna pretplata"),
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

  Future<void> deleteById(int id) async {
    await _packageProvider?.deleteById(id);
    loadData('', 1, 5);
  }
}
