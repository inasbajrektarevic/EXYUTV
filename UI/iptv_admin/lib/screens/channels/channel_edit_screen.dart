import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iptv_admin/models/listItem.dart';
import 'package:iptv_admin/providers/dropdown_provider.dart';
import 'package:iptv_admin/screens/channels/channel_list_screen.dart';
import 'package:http/http.dart' as http;
import '../../models/channel.dart';
import '../../providers/channels_provider.dart';
import '../../widgets/master_screen.dart';
import '../../utils/exstenzions/iterable_extension.dart';

class ChannelEditScreen extends StatefulWidget {
  static const String routeName = "channel/edit";
  final int id;
  const ChannelEditScreen({super.key, required this.id});

  @override
  State<ChannelEditScreen> createState() => _ChannelEditScreenState();
}

class _ChannelEditScreenState extends State<ChannelEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late Channel? data = null;
  TextEditingController nameController = TextEditingController();
  TextEditingController frequencyController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController streamUrlController = TextEditingController();
  TextEditingController channelNumberController = TextEditingController();
  TextEditingController ownerController = TextEditingController();
  bool isHD = false;
  late bool loading = true;
  ChannelProvider? _channelProvider;
  DropdownProvider? _dropdownProvider;
  dynamic bytes = null;
  Uint8List? _imageBytes;
  String? imageUrl = null;
  String apiUrl = "";
  List<ListItem> countries = [];
  List<ListItem> channelLanguages = [];
  List<ListItem> channelCategories = [];
  ListItem? _selectedCountry = null;
  ListItem? _selectedChannelLanguage = null;
  ListItem? _selectedChannelCategory = null;

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
    apiUrl = dotenv.env['API_URL']!;
    _channelProvider = new ChannelProvider();
    _dropdownProvider = new DropdownProvider();
    loadCountries();
    loadChannelCategories();
    loadChannelLanguages();
    loadData();
  }

  Future<void> loadData() async {
    loading = true;
    Channel? item = await _channelProvider?.getById(widget.id, null);
    setState(() {
      this.data = item!;
      final data = this.data;
      if (data != null) {
        nameController.text = data.name;
        frequencyController.text = data.frequency.toString();
        descriptionController.text = data.description;
        streamUrlController.text = data.streamUrl;
        channelNumberController.text = data.channelNumber.toString();
        ownerController.text = data.owner;
        imageUrl = data.logoUrl ?? "";
        isHD = data.isHD;
        if (data.country != null) {
          _selectedCountry =
              countries.firstOrNull((x) => x.key == data.countryId);
        }
        if (data.channelLanguage != null) {
          _selectedChannelLanguage = channelLanguages
              .firstOrNull((x) => x.key == data.channelLanguageId);
        }
        if (data.channelCategory != null) {
          _selectedChannelCategory = channelCategories
              .firstOrNull((x) => x.key == data.channelCategoryId);
        }
      }
      loading = false;
    });
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

  Future loadChannelCategories() async {
    var response = await _dropdownProvider?.getItems("channelCategories");
    setState(() {
      channelCategories = response as List<ListItem>;
      if (channelCategories.isNotEmpty) {
        _selectedChannelCategory = channelCategories[0];
      }
    });
  }

  Future loadChannelLanguages() async {
    var response = await _dropdownProvider?.getItems("channelLanguages");
    setState(() {
      channelLanguages = response as List<ListItem>;
      if (channelLanguages.isNotEmpty) {
        _selectedChannelLanguage = channelLanguages[0];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Izmjena podataka o kanalu"),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
                                    ? Image.memory(
                                        Uint8List.fromList(_imageBytes as List<int>),
                                        fit: BoxFit.cover,
                                        width: 150,
                                        height: 100,
                                      )
                                    : (imageUrl != null &&
                                            imageUrl!.isNotEmpty &&
                                            data?.logoUrl != null)
                                        ? Image.network(
                                            '$apiUrl${data!.logoUrl}',
                                            fit: BoxFit.cover,
                                            width: 150,
                                            height: 100,
                                          )
                                        : Image.asset(
                                            "assets/images/new_default.png",
                                            fit: BoxFit.cover,
                                            width: 150,
                                            height: 100,
                                          ),
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
                                    key: Key('channelCategoryDropdown'),
                                    value: _selectedChannelCategory,
                                    onChanged: (ListItem? newValue) {
                                      setState(() {
                                        _selectedChannelCategory = newValue!;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Kategorija kanala",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      prefixIcon: Icon(Icons.category),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.key == 0) {
                                        return 'Molimo odaberite kateoriju kanala';
                                      }
                                      return null;
                                    },
                                    items: channelCategories
                                        .map((ListItem channelCategory) {
                                      return DropdownMenuItem<ListItem>(
                                        value: channelCategory,
                                        child: Text(channelCategory.value),
                                      );
                                    }).toList(),
                                    hint: Text('Odaberi kategoriju kanala'),
                                  )),
                              SizedBox(height: 16),
                              Container(
                                  height: 48,
                                  width: double.infinity,
                                  child: DropdownButtonFormField<ListItem>(
                                    key: Key('channelLanguageDropdown'),
                                    value: _selectedChannelLanguage,
                                    onChanged: (ListItem? newValue) {
                                      setState(() {
                                        _selectedChannelLanguage = newValue!;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Jezik kanala",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      prefixIcon: Icon(Icons.flag),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.key == 0) {
                                        return 'Molimo odaberite jezik kanala';
                                      }
                                      return null;
                                    },
                                    items: channelLanguages
                                        .map((ListItem channelLanguage) {
                                      return DropdownMenuItem<ListItem>(
                                        value: channelLanguage,
                                        child: Text(channelLanguage.value),
                                      );
                                    }).toList(),
                                    hint: Text('Odaberi jezik kanala'),
                                  )),
                              SizedBox(height: 16),
                              TextFormField(
                                controller: frequencyController,
                                decoration: InputDecoration(
                                  labelText: 'Frekvencija',
                                  border: OutlineInputBorder(),
                                  hintText: 'Unesite frekveciju',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Molimo unesite frekvenciju';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Text('HD kanal'),
                                  Checkbox(
                                    key: Key('isHDCheckbox'),
                                    value: isHD,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isHD = value!;
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
                              controller: streamUrlController,
                              decoration: InputDecoration(
                                labelText: 'Ştream url',
                                border: OutlineInputBorder(),
                                hintText: 'Unesite stream url',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Molimo unesite stream url';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              controller: channelNumberController,
                              decoration: InputDecoration(
                                labelText: 'Broj kanala',
                                border: OutlineInputBorder(),
                                hintText: 'Unesite broj kanala',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Molimo unesite broj kanala';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              controller: ownerController,
                              decoration: InputDecoration(
                                labelText: 'Proizvođač',
                                border: OutlineInputBorder(),
                                hintText: 'Unesite proizvođača',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Molimo unesite proizvođača';
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
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20, bottom: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final Map<String, dynamic> formData = {
                            'id': data!.id,
                            'name': nameController.text,
                            'frequency':
                                double.tryParse(frequencyController.text) ?? 0,
                            'channelCategoryId': _selectedChannelCategory?.key,
                            'channelLanguageId': _selectedChannelLanguage?.key,
                            'countryId': _selectedCountry?.key,
                            'description': descriptionController.text,
                            'isHD': isHD,
                            'streamUrl': streamUrlController.text,
                            'channelNumber': channelNumberController.text,
                            'owner': ownerController.text,
                            'logoUrl': data?.logoUrl
                          };
                          if (_imageBytes != null) {
                            formData['file'] = http.MultipartFile.fromBytes(
                              'file',
                              _imageBytes as List<int>,
                              filename: 'image.jpg',
                            );
                          }
                          bool? result =
                              await _channelProvider?.updateFormData(formData);
                          if (result != null && result) {
                            showCustomToast(
                              context,
                              "Kanal uspješno izmjenjen",
                              Colors.green,
                            );
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ChannelListScreen(),
                              ),
                            );
                          } else {
                            showCustomToast(
                              context,
                              "Greška prilikom izmjene kanala",
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

  void submitData(data) async {
    await _channelProvider?.insert(data);
  }
}
