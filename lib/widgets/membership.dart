import 'package:cvs_information/widgets/membership_kakao.dart';
import 'package:cvs_information/widgets/membership_kt.dart';
import 'package:cvs_information/widgets/membership_lguplus.dart';
import 'package:cvs_information/widgets/membership_naver.dart';
import 'package:cvs_information/widgets/membership_skt.dart';
import 'package:flutter/material.dart';

class MemberShipWidget extends StatefulWidget {
  const MemberShipWidget({super.key});

  @override
  State<MemberShipWidget> createState() => _MemberShipWidgetState();
}

class _MemberShipWidgetState extends State<MemberShipWidget> {
  int index = 0;
  final List<double> opacity = [1, 0.3, 0.3, 0.3, 0.3];

  final screens = [
    const SKTScreen(),
    const KTScreen(),
    const LGUPlusScreen(),
    const NaverScreen(),
    const KakaoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Opacity(
                opacity: opacity[0],
                child: IconButton(
                  icon: Image.asset(width: 40, height: 40, 'images/skt.jpg'),
                  onPressed: () {
                    setState(() {
                      index = 0;
                      opacity[0] = 1;
                      opacity[1] = 0.3;
                      opacity[2] = 0.3;
                      opacity[3] = 0.3;
                      opacity[4] = 0.3;
                    });
                  },
                ),
              ),
              Opacity(
                opacity: opacity[1],
                child: IconButton(
                  icon: Image.asset(width: 40, height: 40, 'images/kt.jpg'),
                  onPressed: () {
                    setState(() {
                      index = 1;
                      opacity[0] = 0.3;
                      opacity[1] = 1;
                      opacity[2] = 0.3;
                      opacity[3] = 0.3;
                      opacity[4] = 0.3;
                    });
                  },
                ),
              ),
              Opacity(
                opacity: opacity[2],
                child: IconButton(
                  icon:
                      Image.asset(width: 40, height: 40, 'images/lguplus.png'),
                  onPressed: () {
                    setState(() {
                      index = 2;
                      opacity[0] = 0.3;
                      opacity[1] = 0.3;
                      opacity[2] = 1;
                      opacity[3] = 0.3;
                      opacity[4] = 0.3;
                    });
                  },
                ),
              ),
              Opacity(
                opacity: opacity[3],
                child: IconButton(
                  icon: Image.asset(width: 40, height: 40, 'images/naver.jpg'),
                  onPressed: () {
                    setState(() {
                      index = 3;
                      opacity[0] = 0.3;
                      opacity[1] = 0.3;
                      opacity[2] = 0.3;
                      opacity[3] = 1;
                      opacity[4] = 0.3;
                    });
                  },
                ),
              ),
              Opacity(
                opacity: opacity[4],
                child: IconButton(
                  icon:
                      Image.asset(width: 40, height: 40, 'images/kakaopay.jpg'),
                  onPressed: () {
                    setState(() {
                      index = 4;
                      opacity[0] = 0.3;
                      opacity[1] = 0.3;
                      opacity[2] = 0.3;
                      opacity[3] = 0.3;
                      opacity[4] = 1;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          screens[index]
        ],
      ),
    );
  }
}
