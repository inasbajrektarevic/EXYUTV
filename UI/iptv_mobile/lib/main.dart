import 'dart:io';
import 'package:iptv_mobile/helpers/my_http_overrides.dart';
import 'package:iptv_mobile/providers/dropdown_provider.dart';
import 'package:iptv_mobile/providers/login_provider.dart';
import 'package:iptv_mobile/providers/registration_provider.dart';
import 'package:iptv_mobile/screens/channelCategories/channelCategory_list_screen.dart';
import 'package:iptv_mobile/screens/dailyPackageRequest/dailyPackageRequest_screen.dart';
import 'package:iptv_mobile/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:iptv_mobile/screens/login/login_screen.dart';
import 'package:iptv_mobile/screens/orders/order_list_screen.dart';
import 'package:iptv_mobile/screens/packages/package_list_screen.dart';
import 'package:iptv_mobile/screens/payments/payment_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");
  HttpOverrides.global = MyHttpOverrides();
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override

  Widget build(BuildContext context) {

   return MultiProvider(
     providers: [ChangeNotifierProvider(create: (_) => DropdownProvider()),
                 ChangeNotifierProvider(create: (_) => RegistrationProvider()),
     ],
     child: MaterialApp(
     home:const LoginScreen(),
     onGenerateRoute: (settings) {
       if (settings.name == HomeScreen.routeName) {
         return MaterialPageRoute(
             builder: ((context) => HomeScreen()));
       }
       if (settings.name == PackageListScreen.routeName) {
         return MaterialPageRoute(
             builder: ((context) => PackageListScreen()));
       }
       if (settings.name == DailyPackageRequestScreen.routeName) {
         return MaterialPageRoute(
             builder: ((context) => DailyPackageRequestScreen()));
       }
       if (settings.name == ChannelCategoryListScreen.routeName) {
         return MaterialPageRoute(
             builder: ((context) => ChannelCategoryListScreen()));
       }
       if (settings.name == OrderListScreen.routeName) {
         return MaterialPageRoute(
             builder: ((context) => OrderListScreen()));
       }
       if (settings.name == PaymentListScreen.routeName) {
         return MaterialPageRoute(
             builder: ((context) => PaymentListScreen()));
       }
     },
   ));
  }
  }
