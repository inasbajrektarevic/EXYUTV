import 'package:iptv_admin/models/channelLanguage.dart';
import 'package:iptv_admin/providers/channelLanguages_provider.dart';
import 'package:iptv_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:number_paginator/number_paginator.dart';
import '../../helpers/color_constants.dart';
import '../../enums/enums.dart';
import '../../utils/colorized_text_avatar.dart';

class ChannelLanguageListScreen extends StatefulWidget {
  static const String routeName = "channelLanguages";

  const ChannelLanguageListScreen({Key? key}) : super(key: key);

  @override
  State<ChannelLanguageListScreen> createState() =>
      _ChannelLanguageListScreenState();
}

class _ChannelLanguageListScreenState extends State<ChannelLanguageListScreen> {
  ChannelLanguageProvider? _channelLanguageProvider = null;
  TextEditingController _searchController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _cultureNameController = TextEditingController();
  GlobalKey<NumberPaginatorState> paginatorKey = GlobalKey();
  bool _isActive = false;
  List<ChannelLanguage> data = [];
  int page = 1;
  int pageSize = 5;
  int totalRecordCounts = 0;
  String searchFilter = '';
  bool isLoading = true;
  int numberOfPages = 1;
  int currentPage = 1;
  List<Center> pages = [];
  final _formKey = GlobalKey<FormState>();
  bool isFirstSubmit = false;
  @override
  void initState() {
    super.initState();
    _channelLanguageProvider = new ChannelLanguageProvider();
    loadData(searchFilter, page, pageSize);
  }

  Future loadData(searchFilter, page, pageSize) async {
    if (searchFilter != '') {
      page = 1;
    }
    var response = await _channelLanguageProvider?.getForPagination({
      'SearchFilter': searchFilter.toString() ?? "",
      'PageNumber': page.toString(),
      'PageSize': pageSize.toString()
    });
    setState(() {
      data = response?.items as List<ChannelLanguage>;
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
                      ElevatedButton.icon(
                        onPressed: () {
                          ChannelLanguage channelLanguage =
                              new ChannelLanguage();
                          channelLanguage.id = 0;
                          channelLanguage.name = '';
                          channelLanguage.cultureName = '';
                          channelLanguage.isActive = false;
                          showAddEditModal(context, channelLanguage, false);
                        },
                        icon: Icon(Icons.add),
                        label: Text('Dodaj jezik kanala'),
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
    ));
  }

  DataRow recentDataRow(ChannelLanguage channelLanguage, BuildContext context) {
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
                text: channelLanguage.name!,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  channelLanguage.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(channelLanguage.cultureName.toString())),
        DataCell(Container(
          padding: EdgeInsets.all(5),
          child: Checkbox(
            activeColor: custom_green,
            value: channelLanguage.isActive,
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
                  showAddEditModal(context, channelLanguage, true);
                },
              ),
              SizedBox(width: 6),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showDeleteModal(context, channelLanguage);
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
        "Jezici kanala",
        style: TextStyle(
            color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }

  void showDeleteModal(BuildContext context, ChannelLanguage channelLanguage) {
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
                          Text(
                              "Da li želite obrisati jezik kanala ${channelLanguage.name}?"),
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
                                    await deleteById(channelLanguage.id);
                                    await loadData(searchFilter, 1, pageSize);
                                    Navigator.pop(context);
                                    ;
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

  void showAddEditModal(
      BuildContext context, ChannelLanguage channelLanguage, bool isEdit) {
    _nameController.text = channelLanguage.name ?? '';
    _cultureNameController.text = channelLanguage.cultureName ?? '';
    _isActive = channelLanguage.isActive ?? false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
                home: AlertDialog(
              title: isEdit
                  ? Text('Uredi jezik kanala')
                  : Text("Dodaj jezik kanala"),
              content: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  onChanged: () {
                    if (isFirstSubmit) _formKey.currentState!.validate();
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(children: [
                        Expanded(
                            child: TextFormField(
                          key: Key('nameTextField'),
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Naziv',
                            border: OutlineInputBorder(),
                            hintText: 'Unesite naziv',
                            hintStyle: TextStyle(color: Colors.grey),
                            prefixIcon: Icon(Icons.near_me),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Molimo unesite naziv';
                            }
                            return null;
                          },
                        )),
                        SizedBox(width: 16),
                        Expanded(
                            child: TextFormField(
                          key: Key('cultureNameTextField'),
                          controller: _cultureNameController,
                          decoration: InputDecoration(
                            labelText: 'Naziv kulture',
                            border: OutlineInputBorder(),
                            hintText: 'Unesite naziv kulture',
                            hintStyle: TextStyle(color: Colors.grey),
                            prefixIcon: Icon(Icons.abc),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Molimo unesite naziv kulture';
                            }
                            return null;
                          },
                        ))
                      ]),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text('Aktivna'),
                          Checkbox(
                            key: Key('isActiveCheckbox'),
                            value: _isActive,
                            onChanged: (bool? value) {
                              setState(() {
                                _isActive = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  )),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Zatvori modal
                  },
                  child: Text('Odustani'),
                ),
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      isFirstSubmit = true;
                      channelLanguage.name = _nameController.text;
                      channelLanguage.cultureName = _cultureNameController.text;
                      channelLanguage.isActive = _isActive;
                      bool? result = false;
                      if (isEdit) {
                        result = await _channelLanguageProvider?.update(
                            channelLanguage.id, channelLanguage);
                      } else {
                        result = await _channelLanguageProvider
                            ?.insert(channelLanguage);
                      }
                      if (result != null && result) {
                        showCustomToast(
                          context,
                          !isEdit
                              ? "Jezik kanala uspješno dodan"
                              : "Jezik kanala uspješno promjenjen",
                          Colors.green,
                        );
                        loadData("", 1, pageSize);
                        Navigator.pop(context);
                      } else {
                        showCustomToast(
                          context,
                          "Greška prilikom upravljanja podacima o jeziku kanala",
                          Colors.red,
                        );
                      }
                    }
                  },
                  child: Text('Spremi'),
                ),
              ],
            ));
          },
        );
      },
    );
  }

  void showCustomToast(
      BuildContext context, String message, Color backgroundColor) {
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.1,
        right: MediaQuery.of(context).size.width * 0.01,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)?.insert(overlayEntry);

    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
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
                    label: Text("Kultura jezika"),
                  ),
                  DataColumn(
                    label: Text("Aktivna"),
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
    await _channelLanguageProvider?.deleteById(id);
    setState(() {
      currentPage = 1;
      loadData("", currentPage, pageSize);
      paginatorKey.currentState?.dispose();
      paginatorKey = GlobalKey();
    });
  }
}
