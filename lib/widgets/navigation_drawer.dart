import 'package:cvs_information/Screens/mainpage.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ]),
    ));
  }

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            ListTile(
                leading: const Icon(Icons.arrow_back),
                title: const Text('Back'),
                onTap: () => {
                      Navigator.of(context).pop(MaterialPageRoute(
                          builder: (context) => const MainPage()))
                    }),
            const Divider(color: Colors.black),
            ListTile(
                leading: const Icon(Icons.privacy_tip_outlined),
                title: const Text('개인정보처리방침'),
                onTap: () {}),
            ListTile(
                leading: const Icon(Icons.summarize_outlined),
                title: const Text('서비스 이용약관'),
                onTap: () {}),
          ],
        ),
      );
}
