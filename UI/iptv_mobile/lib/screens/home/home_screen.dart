import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iptv_mobile/providers/dashboard_provider.dart';
import 'package:iptv_mobile/screens/channelCategories/channelCategory_list_screen.dart';
import 'package:iptv_mobile/screens/orders/order_list_screen.dart';
import 'package:iptv_mobile/widgets/master_screen.dart';
import '../../providers/login_provider.dart';
import '../packages/package_list_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DashboardProvider _dashboardProvider = DashboardProvider();
  Map<String, dynamic>? clientData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    var response = await _dashboardProvider.getClientData(LoginProvider.authResponse!.userId);
    setState(() {
      clientData = response;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Dobrodošli, ${LoginProvider.authResponse!.firstName} ${LoginProvider.authResponse!.lastName} 👋",
              style: GoogleFonts.montserrat(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade700,
              ),
            ),
            SizedBox(height: 20),

            isLoading
                ? Center(child: CircularProgressIndicator())
                : GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildCard(
                    "Paketi", Icons.card_giftcard_rounded, Colors.blue, PackageListScreen.routeName, clientData?['packages']),
                _buildCard("Kategorije kanala", Icons.category_rounded, Colors.green,
                    ChannelCategoryListScreen.routeName, clientData?['channelCategories']),
                _buildCard("Narudžbe", Icons.event_available_rounded, Colors.orange, OrderListScreen.routeName,
                    clientData?['orders']),
                _buildCard("Kanali", Icons.subscriptions_rounded, Colors.purple, 'channels', clientData?['channels']),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, IconData icon, Color color, String routeName, int? count) {
    return GestureDetector(
      onTap: () {
        Navigator.popAndPushNamed(context, routeName);
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                count != null ? count.toString() : "N/A",
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
