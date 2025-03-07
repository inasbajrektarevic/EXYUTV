import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iptv_admin/providers/applications_provider.dart';
import 'package:iptv_admin/providers/channelCategories_provider.dart';
import 'package:iptv_admin/providers/channels_provider.dart';
import 'package:iptv_admin/providers/cities_provider.dart';
import 'package:iptv_admin/providers/countries_provider.dart';
import 'package:iptv_admin/providers/deviceTypes_provider.dart';
import 'package:iptv_admin/providers/devices_provider.dart';
import 'package:iptv_admin/providers/packages_provider.dart';
import 'package:iptv_admin/screens/applications/application_list_screen.dart';
import 'package:iptv_admin/screens/channelCategories/channelCategory_list_screen.dart';
import 'package:iptv_admin/screens/channelLanguages/channelLanguage_list_screen.dart';
import 'package:iptv_admin/screens/channels/channel_list_screen.dart';
import 'package:iptv_admin/screens/cities/city_list_screen.dart';
import 'package:iptv_admin/screens/clients/client_list_screen.dart';
import 'package:iptv_admin/screens/countries/country_list_screen.dart';
import 'package:iptv_admin/screens/deviceTypes/deviceType_list_screen.dart';
import 'package:iptv_admin/screens/devices/device_list_screen.dart';
import 'package:iptv_admin/screens/home/home_screen.dart';
import 'package:iptv_admin/screens/login/login_screen.dart';
import 'package:iptv_admin/screens/orders/order_list_screen.dart';
import 'package:iptv_admin/screens/packages/package_list_screen.dart';
import 'package:iptv_admin/screens/requests24h/request24h_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'helpers/my_http_overrides.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CountryProvider()),
          ChangeNotifierProvider(create: (_) => CityProvider()),
          ChangeNotifierProvider(create: (_) => ApplicationProvider()),
          ChangeNotifierProvider(create: (_) => DeviceTypeProvider()),
          ChangeNotifierProvider(create: (_) => DeviceProvider()),
          ChangeNotifierProvider(create: (_) => ChannelCategoryProvider()),
          ChangeNotifierProvider(create: (_) => ChannelProvider()),
          ChangeNotifierProvider(create: (_) => PackageProvider())
        ],
        child: MaterialApp(
          home: LoginScreen(),
          onGenerateRoute: (settings) {
            if (settings.name == LoginScreen.routeName) {
              return MaterialPageRoute(
                builder: ((context) => LoginScreen()),
              );
            }
            if (settings.name == HomeScreen.routeName) {
              return MaterialPageRoute(
                builder: ((context) => HomeScreen()),
              );
            }
            if (settings.name == ApplicationListScreen.routeName) {
              return MaterialPageRoute(
                builder: ((context) => ApplicationListScreen()),
              );
            }
            if (settings.name == DeviceTypeListScreen.routeName) {
              return MaterialPageRoute(
                builder: ((context) => DeviceTypeListScreen()),
              );
            }
            if (settings.name == DeviceListScreen.routeName) {
              return MaterialPageRoute(
                builder: ((context) => DeviceListScreen()),
              );
            }
            if (settings.name == ChannelCategoryListScreen.routeName) {
              return MaterialPageRoute(
                builder: ((context) => ChannelCategoryListScreen()),
              );
            }
            if (settings.name == ChannelLanguageListScreen.routeName) {
              return MaterialPageRoute(
                builder: ((context) => ChannelLanguageListScreen()),
              );
            }
            if (settings.name == ChannelListScreen.routeName) {
              return MaterialPageRoute(
                builder: ((context) => ChannelListScreen()),
              );
            }
            if (settings.name == PackageListScreen.routeName) {
              return MaterialPageRoute(
                builder: ((context) => PackageListScreen()),
              );
            }
            if (settings.name == CountryListScreen.routeName) {
              return MaterialPageRoute(
                builder: ((context) => CountryListScreen()),
              );
            }
            if (settings.name == CityListScreen.routeName) {
              return MaterialPageRoute(
                builder: ((context) => CityListScreen()),
              );
            }
            if (settings.name == OrderListScreen.routeName) {
              return MaterialPageRoute(
                builder: ((context) => OrderListScreen()),
              );
            }
            if (settings.name == Request24hListScreen.routeName) {
              return MaterialPageRoute(
                builder: ((context) => Request24hListScreen()),
              );
            }
            if (settings.name == ClientListScreen.routeName) {
              return MaterialPageRoute(
                builder: ((context) => ClientListScreen()),
              );
            }
            return MaterialPageRoute(
              builder: ((context) => UnknownScreen()),
            );
          },
        ));
  }
}

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unknown Screen'),
      ),
      body: Center(
        child: Text('Unknown Screen'),
      ),
    );
  }
}
