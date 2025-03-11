import 'dart:typed_data';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iptv_admin/models/listItem.dart';
import 'package:iptv_admin/providers/dropdown_provider.dart';
import 'package:http/http.dart' as http;
import 'package:iptv_admin/providers/packages_provider.dart';
import 'package:iptv_admin/screens/packages/package_list_screen.dart';
import '../../widgets/master_screen.dart';

class PackageAddScreen extends StatefulWidget {
  static const String routeName = "package/add";
  const PackageAddScreen({super.key});

  @override
  State<PackageAddScreen> createState() => _PackageAddScreenState();
}

class _PackageAddScreenState extends State<PackageAddScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController iconUrlController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  bool isPromotional = false;
  bool requiresSubscription = false;
  PackageProvider? _packageProvider;
  DropdownProvider? _dropdownProvider;
  dynamic bytes = null;
  Uint8List? _imageBytes;
  List<ListItem> countries = [];
  List<ListItem> statuses = [];
  List<ListItem> channelCategories = [];
  List<int> selectedChannelCategories = [];
  ListItem? _selectedCountry = null;
  ListItem? _selectedStatus = null;

  Future<void> _selectImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      Uint8List bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _packageProvider = new PackageProvider();
    _dropdownProvider = new DropdownProvider();
    loadCountries();
    loadStatuses();
    loadChannelCategories(); // Add this line
  }

  Future loadCountries() async {
    var response = await _dropdownProvider?.getItems("countries");
    setState(() {
      countries = response as List<ListItem>;
      if (countries.isNotEmpty) {
        _selectedCountry = countries[0];
      }
    });
  }

  Future loadStatuses() async {
    var response = await _dropdownProvider?.getItems("packageStatuses");
    setState(() {
      statuses = response as List<ListItem>;
      if (statuses.isNotEmpty) {
        _selectedStatus = statuses[0];
      }
    });
  }

  Future loadChannelCategories() async {
    var response = await _dropdownProvider?.getItems("channelCategories");
    setState(() {
      channelCategories = response as List<ListItem>;
      selectedChannelCategories =
          channelCategories.map((category) => category.key).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Dodavanje paketa"),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          Container(
              margin: EdgeInsets.symmetric(),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                  //padding: EdgeInsets.symmetric(horizontal: 200.0),
                  child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                onChanged: () {
                  _formKey.currentState!.validate();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          child: _imageBytes != null
                              ? Image.memory(_imageBytes!,
                                  width: 150, height: 100)
                              : Image.asset("assets/images/new_default.png",
                                  width: 150, height: 100),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: _selectImage,
                              child: Text('Odaberi sliku'),
                            ),
                          ],
                        ),
                      ],
                    )),
                    Expanded(
                      child: Column(children: [
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Naziv',
                            border: OutlineInputBorder(),
                            hintText: 'Unesite naziv kanala',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Molimo unesite naziv';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        Container(
                            height: 48,
                            width: double.infinity,
                            child: DropdownButtonFormField<ListItem>(
                              key: Key('countryDropdown'),
                              value: _selectedCountry,
                              onChanged: (ListItem? newValue) {
                                setState(() {
                                  _selectedCountry = newValue!;
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Država",
                                hintStyle: TextStyle(color: Colors.grey),
                                prefixIcon: Icon(Icons.near_me_sharp),
                              ),
                              validator: (value) {
                                if (value == null || value.key == 0) {
                                  return 'Molimo odaberite državu';
                                }
                                return null;
                              },
                              items: countries.map((ListItem country) {
                                return DropdownMenuItem<ListItem>(
                                  value: country,
                                  child: Text(country.value),
                                );
                              }).toList(),
                              hint: Text('Odaberi državu'),
                            )),
                        SizedBox(height: 16),
                        Container(
                            height: 48,
                            width: double.infinity,
                            child: DropdownButtonFormField<ListItem>(
                              key: Key('statusDropdown'),
                              value: _selectedStatus,
                              onChanged: (ListItem? newValue) {
                                setState(() {
                                  _selectedStatus = newValue!;
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Status",
                                hintStyle: TextStyle(color: Colors.grey),
                                prefixIcon:
                                    Icon(Icons.real_estate_agent_rounded),
                              ),
                              validator: (value) {
                                if (value == null || value.key == 0) {
                                  return 'Molimo odaberite status paketa';
                                }
                                return null;
                              },
                              items: statuses.map((ListItem status) {
                                return DropdownMenuItem<ListItem>(
                                  value: status,
                                  child: Text(status.value),
                                );
                              }).toList(),
                              hint: Text('Odaberi status paketa'),
                            )),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Text('Promocija'),
                            Checkbox(
                              key: Key('isPromotionalCheckbox'),
                              value: isPromotional,
                              onChanged: (bool? value) {
                                setState(() {
                                  isPromotional = value!;
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Obavezna pretplata'),
                            Checkbox(
                              key: Key('requiresSubscriptionCheckbox'),
                              value: requiresSubscription,
                              onChanged: (bool? value) {
                                setState(() {
                                  requiresSubscription = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ]),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                        child: Column(children: [
                      TextFormField(
                        controller: priceController,
                        decoration: InputDecoration(
                          labelText: 'Cijena',
                          border: OutlineInputBorder(),
                          hintText: 'Unesite cijenu',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Molimo unesite cijenu';
                          }
                          final number = double.tryParse(value);
                          if (number == null) {
                            return 'Molimo unesite validan broj';
                          }
                          if (number < 0) {
                            return 'Cijena ne može biti negativna';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: discountController,
                        decoration: InputDecoration(
                          labelText: 'Popust',
                          border: OutlineInputBorder(),
                          hintText: 'Unesite popust',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Molimo unesite popust';
                          }
                          final number = double.tryParse(value);
                          if (number == null) {
                            return 'Molimo unesite validan broj';
                          }
                          if (number < 0) {
                            return 'Popust ne može biti negativan';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: descriptionController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: 'Opis',
                          border: OutlineInputBorder(),
                          hintText: 'Unesite tekst ovdje...',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Molimo unesite opis';
                          }
                          return null;
                        },
                      ),
                    ])),
                  ],
                ),
              ))),
          SizedBox(height: 20),
          Column(
            children: [
              ExpansionTileCard(
                title: Text(
                  "Odabir kategorija kanala",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  SizedBox(
                    height: 300, // Set a fixed height
                    child: selectedChannelCategories.isNotEmpty
                        ? ListView.builder(
                            itemCount: channelCategories.length,
                            itemBuilder: (context, index) {
                              final category = channelCategories[index];
                              return CheckboxListTile(
                                title: Text(category.value),
                                value: selectedChannelCategories
                                    .contains(category.key),
                                onChanged: (bool? selected) {
                                  setState(() {
                                    if (selected != null && selected) {
                                      selectedChannelCategories
                                          .add(category.key);
                                    } else {
                                      selectedChannelCategories
                                          .remove(category.key);
                                    }
                                  });
                                },
                              );
                            },
                          )
                        : Center(child: Text("Nema odabranih kategorija.")),
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(right: 20, bottom: 20),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final Map<String, dynamic> formData = {
                      'id': '0',
                      'name': nameController.text,
                      'price': double.tryParse(priceController.text) ?? 0,
                      'discount': double.tryParse(discountController.text) ?? 0,
                      'status': _selectedStatus?.key,
                      'countryId': _selectedCountry?.key,
                      'description': descriptionController.text,
                      'isPromotional': isPromotional,
                      'requiresSubscription': requiresSubscription,
                      'iconUrl': '/',
                      'channelCategorieIds': selectedChannelCategories,
                    };
                    if (_imageBytes != null) {
                      formData['file'] = http.MultipartFile.fromBytes(
                        'file',
                        _imageBytes as List<int>,
                        filename: 'image.jpg',
                      );
                    }
                    bool? result =
                        await _packageProvider?.insertFormData(formData);
                    if (result != null && result) {
                      showCustomToast(
                        context,
                        "Paket uspješno dodan",
                        Colors.green,
                      );
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PackageListScreen(),
                        ),
                      );
                    } else {
                      showCustomToast(
                        context,
                        "Greška prilikom dodavanja paketa",
                        Colors.green,
                      );
                    }
                  }
                },
                child: Text("Spremi"),
              ),
            ),
          )
        ]),
      )),
    ));
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
}
