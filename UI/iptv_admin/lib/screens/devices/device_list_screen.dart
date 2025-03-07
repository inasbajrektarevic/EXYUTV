import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:iptv_admin/models/listItem.dart';
import 'package:iptv_admin/providers/devices_provider.dart';
import 'package:iptv_admin/providers/dropdown_provider.dart';
import 'package:iptv_admin/screens/deviceTypes/deviceType_list_screen.dart';
import 'package:iptv_admin/widgets/master_screen.dart';
import 'package:number_paginator/number_paginator.dart';
import '../../enums/enums.dart';
import '../../models/device.dart';
import '../../utils/colorized_text_avatar.dart';
import '../../utils/exstenzions/iterable_extension.dart';

class DeviceListScreen extends StatefulWidget {
  static const String routeName = "devices";
  const DeviceListScreen({Key? key}) : super(key: key);

  @override
  State<DeviceListScreen> createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen> {
  DeviceProvider? _deviceProvider = null;
  DropdownProvider? _dropdownProvider = null;
  TextEditingController _searchController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _manufacturerController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _serialNumberController = TextEditingController();
  GlobalKey<NumberPaginatorState> paginatorKey = GlobalKey();
  List<Device> data = [];
  List<ListItem> deviceTypes = [];
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
    _deviceProvider = new DeviceProvider();
    _dropdownProvider = new DropdownProvider();
    loadDeviceTypes();
    loadData(searchFilter, page, pageSize);
  }

  Future loadDeviceTypes() async {
    var response =
        await _dropdownProvider?.getItems(DeviceTypeListScreen.routeName);
    setState(() {
      deviceTypes = response as List<ListItem>;
    });
  }

  Future loadData(searchFilter, page, pageSize) async {
    if (searchFilter != '') {
      page = 1;
    }
    var response = await _deviceProvider?.getForPagination({
      'SearchFilter': searchFilter.toString() ?? "",
      'PageNumber': page.toString(),
      'PageSize': pageSize.toString()
    });
    setState(() {
      data = response?.items as List<Device>;
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
                                Device device = new Device();
                                device.deviceType = null;
                                showAddEditModal(context, device, false);
                              },
                              icon: Icon(Icons.add),
                              label: Text('Dodaj uređaj'),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
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
                  )));
  }

  DataRow recentDataRow(Device device, BuildContext context) {
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
                text: device.name!,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  device.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(device.serialNumber)),
        DataCell(Text(device.manufacturer)),
        DataCell(Text(device.model)),
        DataCell(Text(device.deviceType!.name)),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  showAddEditModal(context, device, true);
                },
              ),
              SizedBox(width: 6),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showDeleteModal(context, device);
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
        "Uređaji",
        style: TextStyle(
            color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }

  void showDeleteModal(BuildContext context, Device device) {
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
                              "Da li želite obrisati uređaj ${device.name}(${device.serialNumber})?"),
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
                                    await deleteById(device.id);
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

  void showAddEditModal(BuildContext context, Device device, bool isEdit) {
    ListItem? selectedDeviceType = deviceTypes[0];
    _nameController.text = device.name ?? '';
    _manufacturerController.text = device.manufacturer ?? '';
    _serialNumberController.text = device.serialNumber ?? '';
    _modelController.text = device.model ?? '';
    if (device.deviceType != null) {
      selectedDeviceType =
          deviceTypes.firstOrNull((x) => x.key == device.deviceTypeId);
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
                home: AlertDialog(
              title: isEdit ? Text('Uredi uređaj') : Text("Dodaj uređaj"),
              content: IntrinsicWidth(
                child: Form(
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
                              prefixIcon: Icon(Icons.device_unknown),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Molimo unesite skraćenicu';
                              }
                              return null;
                            },
                          ))
                        ]),
                        SizedBox(height: 16),
                        Row(children: [
                          Expanded(
                              child: TextFormField(
                            key: Key('serialNumberTextField'),
                            controller: _serialNumberController,
                            decoration: InputDecoration(
                              labelText: 'Oznaka',
                              border: OutlineInputBorder(),
                              hintText: 'Unesite oznaku',
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(Icons.numbers),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Molimo unesite oznaku';
                              }
                              return null;
                            },
                          )),
                          SizedBox(width: 20),
                          Expanded(
                              child: TextFormField(
                            key: Key('manufacturerTextField'),
                            controller: _manufacturerController,
                            decoration: InputDecoration(
                              labelText: 'Proizvođač',
                              border: OutlineInputBorder(),
                              hintText: 'Unesite proizvođača',
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(Icons.business_outlined),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Molimo unesite proizvođača';
                              }
                              return null;
                            },
                          ))
                        ]),
                        SizedBox(height: 16),
                        Row(children: [
                          Expanded(
                              child: TextFormField(
                            key: Key('modelTextField'),
                            controller: _modelController,
                            decoration: InputDecoration(
                              labelText: 'Model',
                              border: OutlineInputBorder(),
                              hintText: 'Unesite model',
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(Icons.model_training),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Molimo unesite model';
                              }
                              return null;
                            },
                          )),
                          SizedBox(width: 20),
                          Expanded(
                              child: Container(
                            height: 50,
                            width: double.infinity,
                            child: DropdownButtonFormField<ListItem>(
                              key: Key('deviceTypeDropdown'),
                              value: selectedDeviceType,
                              onChanged: (ListItem? newValue) {
                                setState(() {
                                  selectedDeviceType = newValue!;
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Tip uređaja",
                                hintStyle: TextStyle(color: Colors.grey),
                                prefixIcon: Icon(Icons.devices_outlined),
                              ),
                              validator: (value) {
                                if (value == null || value.key == 0) {
                                  return 'Molimo odaberite tip uređaja';
                                }
                                return null;
                              },
                              items: deviceTypes.map((ListItem deviceType) {
                                return DropdownMenuItem<ListItem>(
                                  value: deviceType,
                                  child: Text(deviceType.value),
                                );
                              }).toList(),
                              hint: Text('Odaberi tip uređaja'),
                            ),
                          ))
                        ]),
                        SizedBox(height: 16),
                      ],
                    )),
              ),
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
                      device.name = _nameController.text;
                      device.model = _modelController.text;
                      device.manufacturer = _manufacturerController.text;
                      device.serialNumber = _serialNumberController.text;
                      device.deviceTypeId = selectedDeviceType!.key;
                      bool? result = false;
                      if (isEdit) {
                        result =
                            await _deviceProvider?.update(device.id, device);
                      } else {
                        result = await _deviceProvider?.insert(device);
                      }
                      if (result != null && result) {
                        showCustomToast(
                          context,
                          isEdit ? "Uređaj uspješno izmjenjen" : "Uređaj uspješno dodan",
                          Colors.green,
                        );
                        loadData("", 1, pageSize);
                        Navigator.pop(context);
                      } else {
                        showCustomToast(
                          context,
                          "Greška prilikom upravljanja podacima o uređaju",
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

  void showCustomToast(BuildContext context, String message, Color backgroundColor) {
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
                    label: Text("Oznaka"),
                  ),
                  DataColumn(
                    label: Text("Model"),
                  ),
                  DataColumn(
                    label: Text("Proizvođač"),
                  ),
                  DataColumn(
                    label: Text("Tip uređaja"),
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
    await _deviceProvider?.deleteById(id);
    setState(() {
      currentPage = 1;
      loadData("", currentPage, pageSize);
      paginatorKey.currentState?.dispose();
      paginatorKey = GlobalKey();
    });
  }
}
