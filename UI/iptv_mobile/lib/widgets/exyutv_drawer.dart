import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iptv_mobile/screens/channelCategories/channelCategory_list_screen.dart';
import 'package:iptv_mobile/screens/orders/order_list_screen.dart';
import 'package:iptv_mobile/screens/packages/package_list_screen.dart';
import 'package:iptv_mobile/screens/payments/payment_list_screen.dart';
import '../providers/login_provider.dart';
import '../screens/home/home_screen.dart';
import '../screens/login/login_screen.dart';

class ExyutvDrawer extends StatelessWidget {
  const ExyutvDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 160,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal.shade600,
              ),
              margin: EdgeInsets.zero,
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: LoginProvider.authResponse?.profilePhoto !=  ''
                        ? NetworkImage(LoginProvider.authResponse!.profilePhoto!)
                        : AssetImage('assets/images/default-avatar.png') as ImageProvider,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '${LoginProvider.authResponse!.firstName} ${LoginProvider.authResponse!.lastName}',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildMenuItem(
                  icon: Icons.home_rounded,
                  text: 'Početna',
                  onTap: () {
                    Navigator.popAndPushNamed(context, HomeScreen.routeName);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.card_giftcard_rounded,
                  text: 'Paketi',
                  onTap: () {
                    Navigator.popAndPushNamed(context, PackageListScreen.routeName);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.category_rounded,
                  text: 'Kategorije kanala',
                  onTap: () {
                    Navigator.popAndPushNamed(context, ChannelCategoryListScreen.routeName);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.event_available_rounded,
                  text: 'Narudžbe',
                  onTap: () {
                    Navigator.popAndPushNamed(context, OrderListScreen.routeName);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.payment,
                  text: 'Računi',
                  onTap: () {
                    Navigator.popAndPushNamed(context, PaymentListScreen.routeName);
                  },
                ),
                Divider(thickness: 0.7, color: Colors.grey.shade300),
                _buildMenuItem(
                  icon: Icons.exit_to_app_rounded,
                  text: 'Odjavi se',
                  onTap: () {
                    LoginProvider.setResponseFalse();
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({required IconData icon, required String text, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, size: 22, color: Colors.teal.shade700),
      title: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      dense: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      tileColor: Colors.grey.shade100,
      hoverColor: Colors.teal.shade200,
    );
  }
}
