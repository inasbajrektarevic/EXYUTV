import 'package:iptv_mobile/models/dailyPackageRequest.dart';
import 'package:iptv_mobile/providers/dailyPackageRequest_provider.dart';
import 'package:iptv_mobile/providers/dropdown_provider.dart';
import 'package:iptv_mobile/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../models/listItem.dart';

class DailyPackageRequestScreen extends StatefulWidget {
  static const String routeName = "dailyPackageRequests";
  DailyPackageRequestScreen();

  @override
  State<DailyPackageRequestScreen> createState() =>
      _DailyPackageRequestScreenState();
}

class _DailyPackageRequestScreenState extends State<DailyPackageRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  DailyPackageRequestProvider? _dailyPackageRequestProvider;
  DropdownProvider? _dropdownProvider;
  List<ListItem> devices = [];
  List<ListItem> applications = [];
  ListItem? selectedDevice = null;
  ListItem? selectedApplication = null;
  dynamic bytes = null;
  bool isFirstSubmit = false;

  @override
  void initState() {
    super.initState();
    _dropdownProvider = context.read<DropdownProvider>();
    _dailyPackageRequestProvider = new DailyPackageRequestProvider();
    loadApplications();
    loadDevices();
  }

  Future loadApplications() async {
    var response = await _dropdownProvider?.getItems("applications");
    setState(() {
      applications = response!;
    });
  }

  Future loadDevices() async {
    var response = await _dropdownProvider?.getItems("devices");
    setState(() {
      devices = response!;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Zahtjev lista 24h"),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 0.0),
          child: Form(
              key: _formKey,
              onChanged: () {
                if (isFirstSubmit) _formKey.currentState!.validate();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: firstNameController,
                          decoration: InputDecoration(
                            labelText: 'Ime',
                            border: OutlineInputBorder(),
                            hintText: 'Unesite ime',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Molimo unesite ime';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: lastNameController,
                          decoration: InputDecoration(
                              labelText: 'Prezime',
                              border: OutlineInputBorder(),
                              hintText: 'Unesite ime',
                              hintStyle: TextStyle(color: Colors.grey)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Molimo unesite prezime';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            hintText: 'Unesite email',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Molimo unesite email';
                            }
                            RegExp emailRegExp =
                                RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                            if (!emailRegExp.hasMatch(value)) {
                              return 'Molimo unesite ispravan email';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          child: TextFormField(
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                          labelText: 'Broj telefona',
                          border: OutlineInputBorder(),
                          hintText: 'Unesite broj telefona',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Molimo unesite broj telefona';
                          }
                          RegExp phoneNumberRegExp = RegExp(r'^\d{9,15}$');
                          if (!phoneNumberRegExp.hasMatch(value)) {
                            return 'Broj telefona mora imati između 9 i 15 cifara';
                          }
                          return null;
                        },
                      ))
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 66.5,
                          width: double.infinity,
                          child: DropdownButtonFormField<ListItem>(
                            key: Key('applicationDropdown'),
                            value: selectedApplication,
                            onChanged: (ListItem? newValue) {
                              setState(() {
                                selectedApplication = newValue!;
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Aplikacija",
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(Icons.mobile_friendly),
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Molimo odaberite aplikaciju';
                              }
                              return null;
                            },
                            items: applications.map((ListItem item) {
                              return DropdownMenuItem<ListItem>(
                                value: item,
                                child: Text(item.value),
                              );
                            }).toList(),
                            hint: Text('Odaberite aplikaciju'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 66.5,
                          width: double.infinity,
                          child: DropdownButtonFormField<ListItem>(
                            key: Key('deviceDropdown'),
                            value: selectedDevice,
                            onChanged: (ListItem? newValue) {
                              setState(() {
                                selectedDevice = newValue!;
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Uređaj",
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(Icons.devices),
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Molimo odaberite uređaj';
                              }
                              return null;
                            },
                            items: devices.map((ListItem item) {
                              return DropdownMenuItem<ListItem>(
                                value: item,
                                child: Text(item.value),
                              );
                            }).toList(),
                            hint: Text('Odaberite uređaj'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .center, // Align content to the center
                    children: [
                      // Registration Button (Blue with White Text)
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            isFirstSubmit = true;
                            var package = new DailyPackageRequest();
                            package.id = 0;
                            package.firstName = firstNameController.text;
                            package.lastName = lastNameController.text;
                            package.email = emailController.text;
                            package.phoneNumber = phoneNumberController.text;
                            package.deviceId = selectedDevice!.key;
                            package.applicationId = selectedApplication!.key;
                            bool? result = await _dailyPackageRequestProvider
                                ?.insert(package);
                            if (result != null && result) {
                              Fluttertoast.showToast(
                                msg: "Zahtjev 24h uspješno poslan",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 5,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              Navigator.popAndPushNamed(
                                  context, LoginScreen.routeName);
                            } else {
                              Fluttertoast.showToast(
                                msg: "Greška prilikom dodavanja zahtjeva 24h",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 5,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                          }
                        },
                        child: _buildGradientButton(
                          text: "Pošalji zahtjev",
                          icon: Icons.send,
                          colors: [Color(0xFF00c853), Color(0xFFb2ff59)],
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ],
              )),
        ),
      )),
    );
  }

  Widget _buildGradientButton(
      {required String text,
      required IconData icon,
      required List<Color> colors}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: colors[0].withOpacity(0.5),
            blurRadius: 8,
            spreadRadius: 2,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
