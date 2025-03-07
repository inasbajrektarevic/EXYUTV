import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:iptv_admin/screens/channelCategories/channelCategory_list_screen.dart';
import 'package:iptv_admin/screens/channels/channel_list_screen.dart';
import 'package:iptv_admin/screens/clients/client_list_screen.dart';
import 'package:iptv_admin/screens/deviceTypes/deviceType_list_screen.dart';
import 'package:iptv_admin/screens/orders/order_list_screen.dart';
import 'package:iptv_admin/screens/packages/package_list_screen.dart';
import 'package:iptv_admin/widgets/master_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../providers/dashboard_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DashboardProvider _dashboardProvider = DashboardProvider();
  Map<String, dynamic>? data;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    var response = await _dashboardProvider.getAdminData();
    setState(() {
      data = response;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pregled sistema",
                    style: GoogleFonts.montserrat(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade700,
                    ),
                  ),
                  SizedBox(height: 20),
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 4,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      _buildCard(
                          "Klijenti",
                          Icons.people,
                          data!['clients'].toString(),
                          Colors.blue,
                          ClientListScreen.routeName),
                      _buildCard(
                          "Paketi",
                          Icons.card_giftcard_rounded,
                          data!['packages'].toString(),
                          Colors.green,
                          PackageListScreen.routeName),
                      _buildCard(
                          "Narudžbe",
                          Icons.shopping_cart,
                          data!['orders'].toString(),
                          Colors.orangeAccent,
                          OrderListScreen.routeName),
                      _buildCard(
                          "Kategorije kanala",
                          Icons.category,
                          data!['channelCategories'].toString(),
                          Colors.purple,
                          ChannelCategoryListScreen.routeName),
                      _buildCard(
                          "Kanali",
                          Icons.live_tv,
                          data!['channels'].toString(),
                          Colors.redAccent,
                          ChannelListScreen.routeName),
                      _buildCard(
                          "Tipovi uređaja",
                          Icons.devices,
                          data!['deviceTypes'].toString(),
                          Colors.teal,
                          DeviceTypeListScreen.routeName),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          "Registrovani klijenti zadnjih 7 dana",
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 300,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: LineChart(_buildChartData()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildCard(String title, IconData icon, String value, Color color,
      String routeName) {
    return GestureDetector(
      onTap: () {
        Navigator.popAndPushNamed(context, routeName);
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: 40, color: color),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    value,
                    style: GoogleFonts.montserrat(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  LineChartData _buildChartData() {
    if (data == null || !data!.containsKey('lastSevenDaysRegistrationClients')) {
      return LineChartData();
    }

    Map<String, dynamic> clientData = data!['lastSevenDaysRegistrationClients'];

    List<DateTime> last7Days = List.generate(
        7, (index) => DateTime.now().subtract(Duration(days: 6 - index)));

    // Lista za FlChart
    List<FlSpot> spots = [];
    for (int i = 0; i < last7Days.length; i++) {
      String dateKey = last7Days[i].toIso8601String().split('T')[0] + "T00:00:00Z";
      double yValue = clientData.containsKey(dateKey)
          ? (clientData[dateKey] as num).toDouble()
          : 0.0;

      spots.add(FlSpot(i.toDouble(), yValue));
    }

    return LineChartData(
      gridData: FlGridData(show: true, drawVerticalLine: false),
      titlesData: FlTitlesData(
        topTitles: AxisTitles(),
        rightTitles: AxisTitles(),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            interval: 1,
            getTitlesWidget: (value, meta) {
              return Text(value.toInt().toString(), style: TextStyle(fontSize: 12));
            },
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            interval: 1,
            getTitlesWidget: (value, meta) {
              int index = value.toInt();
              if (index >= 0 && index < last7Days.length) {
                return Text(DateFormat('dd.MM').format(last7Days[index]),
                    style: TextStyle(fontSize: 12));
              }
              return Container();
            },
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.grey, width: 1),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: Colors.blue,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(show: true),
          belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.2)),
        ),
      ],
      minY: 0,
      maxY: 1.2,
    );
  }

}
