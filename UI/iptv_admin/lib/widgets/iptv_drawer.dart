import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iptv_admin/screens/clients/client_list_screen.dart';
import 'package:iptv_admin/screens/orders/order_list_screen.dart';
import 'package:iptv_admin/screens/requests24h/request24h_list_screen.dart';

import '../providers/login_provider.dart';
import '../screens/applications/application_list_screen.dart';
import '../screens/channelCategories/channelCategory_list_screen.dart';
import '../screens/channelLanguages/channelLanguage_list_screen.dart';
import '../screens/channels/channel_list_screen.dart';
import '../screens/cities/city_list_screen.dart';
import '../screens/countries/country_list_screen.dart';
import '../screens/deviceTypes/deviceType_list_screen.dart';
import '../screens/devices/device_list_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/packages/package_list_screen.dart';

class iptvDrawer extends StatefulWidget {
  @override
  _iptvDrawerState createState() => _iptvDrawerState();
}

class _iptvDrawerState extends State<iptvDrawer> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[280],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.home),
            title: Text(
              "Početna",
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.man_sharp),
            title: Text(
              "Klijenti",
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ClientListScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.apps),
            title: Text(
              "Aplikacije",
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ApplicationListScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.padding_sharp),
            title: Text(
              "Paketi",
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PackageListScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.reorder),
            title: Text(
              "Narudžbe",
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OrderListScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.reorder),
            title: Text(
              "Dnevni zahtjevi",
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Request24hListScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.computer),
            title: Text(
              "Tipovi uređaja",
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DeviceTypeListScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.computer),
            title: Text(
              "Uređaji",
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DeviceListScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text(
              "Kategorije kanala",
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChannelCategoryListScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.flag),
            title: Text(
              "Jezici kanala",
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChannelLanguageListScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.wifi_channel),
            title: Text(
              "Kanali",
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChannelListScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.pin_drop),
            title: Text(
              "Države",
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CountryListScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.pin_drop),
            title: Text(
              "Gradovi",
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CityListScreen(),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(
              "Odjava",
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            onTap: () {
              LoginProvider.setResponseFalse();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
