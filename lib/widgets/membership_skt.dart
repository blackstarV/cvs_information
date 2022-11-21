import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';

class SKTScreen extends StatefulWidget {
  const SKTScreen({super.key});

  @override
  State<SKTScreen> createState() => _SKTScreenState();
}

class _SKTScreenState extends State<SKTScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: ElevatedButton(
            onPressed: () async {
              await LaunchApp.openApp(
                androidPackageName: 'com.tms',
                iosUrlScheme: 'tms://',
                appStoreLink:
                    'itms-apps://itunes.apple.com/kr/app/t멤버십/id464205249',
                openStore: true,
              );
            },
            child: const Text('T 멤버십 열기'),
          ),
        ),
        SizedBox(
          height: 132,
        )
      ],
    );
  }
}
