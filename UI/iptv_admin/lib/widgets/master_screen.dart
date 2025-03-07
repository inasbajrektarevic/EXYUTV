import 'package:flutter/material.dart';
import 'iptv_drawer.dart';

class MasterScreenWidget extends StatelessWidget {
  final Widget? child;

  MasterScreenWidget({this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isWideScreen = MediaQuery.of(context).size.width >= 1100;
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("EXYUTV Admin"),
        centerTitle: true,
      ),
      drawer: !isWideScreen ? iptvDrawer() : null,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isWideScreen)
              SizedBox(
                width: 250,
                child: iptvDrawer(),
              ),
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: child!,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
