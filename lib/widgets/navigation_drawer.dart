import 'package:cvs_information/Screens/main_page.dart';
import 'package:cvs_information/screens/privacy_policy_page.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({super.key});
  String membershipGuide = 'CU\n\n'
      'SKT\n'
      '(VIP,GOLD) 1천 원당 100원 할인, (SILVER) 1천 원당 50원 할인\n'
      '※ 할인/적립 횟수: 1일 1회\n'
      '※ 포인트 사용 횟수: 제한 없음\n'
      '※ 일 최대 할인 가능: VIP/GOLD 20,000원, SILVER 10,000원\n'
      '※ 1천 원 이상 금액 결제 시 혜택 적용\n'
      '※ 타 쿠폰, 할인 행사, 제휴 카드, 타 포인트 사용 등 중복 적용 불가\n'
      '- 할인/적립/사용 제외 상품 : 행사 상품(1+1, 2+1 등), 담배, 주류, 종량제 봉투, 안전상비의약품, 유가증권(상품권, 교통카드 충전) 등\n'
      '- 할인/적립/사용 제외 서비스 : 매장 서비스 전체 (택배, 복권, 인쇄·복사), 주문 대행 판매(배달·픽업·예약 구매) 등\n'
      '\n'
      '네이버플러스멤버십\n'
      '1. 최대 10%더블혜택(1일 1회, 최대 1만원)\n'
      '대상조건 : 네이버플러스 멤버십 가입 & 네이버페이에서 CU멤버십 등록한 ID 한정\n'
      '대상혜택 : CU에서 현장결제하면 최대 5%즉시적립(최대 5천원)+최대5%즉시할인(최대 5천원)\n'
      '단, 더블혜택은 통신사(할인&적립&사용혜택) 및 CU멤버십(적립)과 함께 받을 수 없습니다.\n'
      '본 혜택은 복합결제 혹은 구매하신 품목에 따라서 적립 혹은 할인 혜택만 적용될 수 있습니다.\n'
      '본 혜택은 네이버플러스 멤버십의 기존 혜택 한도와는 무관하게 적립됩니다.\n'
      '* 할인/적립 제외 품목\n'
      '담배, 주류, 쓰레기봉투, 유가증권(교통카드, 상품권), 서비스상품(택배, 공공요금 수납), 신문의 경우 할인&적립 모두 제외 됩니다.\n'
      '* 서비스 제외 매장\n'
      'CU 일부 특수 매장(휴게소, 리조트, 전시관, 테마파크, 병원, 공항, 학교, 회사, 법인점포 등)에서는 더블혜택(5%,할인 및 5%적립) 적용 불가합니다.\n'
      '\n\n'
      'GS25\n\n'
      'KT\n'
      '※ 할인율은 멤버십 등급별 차등 할인 적용됩니다. (VVIP/VIP/골드 : 천원 당 100원 할인 | 실버/화이트/일반 : 천원 당 50원 할인)\n'
      '(단, 주류/담배/서비스/안전상비의약품 등 일부 품목은 천원 당 100원/50원 할인 대상에서 제외됩니다.)\n'
      '※ 휴게소 등 일부 GS25에서는 천원 당 100원/50원 할인 적용이 불가합니다.\n'
      '※ 천원(1,000원) 미만 금액은 KT멤버십 포인트 할인 적용에서 제외됩니다.\n'
      '※ 일1회, 결제 금액(이용금액) 최대 20만원 한도 내 할인 적용됩니다.\n'
      '※ 할인 금액 상당 포인트 차감 / 포인트 부족 시 할인 불가\n'
      '※ 원단위 절사 후 할인 제공\n'
      '\n'
      'LGU+\n'
      '※ 할인율은 멤버십 등급별 차등 할인 적용됩니다. (VVIP / VIP : 10% | 다이아몬드 : 5%)\n'
      '(단, 주류/담배/서비스/안전상비의약품 등 일부 품목은 10%/5% 할인 대상에서 제외됩니다.)\n'
      '※ 일1회, 결제 금액(이용금액) 최대 20만원 한도 내 할인 적용됩니다.\n'
      '※ 20년 7월 1일 이후, 월 최대 할인 한도 총 10만원으로 변경됩니다.\n'
      '※ 휴게소 등 일부 GS25에서는 10% / 5% 할인 적용이 불가합니다.\n'
      '\n\n'
      '세븐일레븐\n\n'
      'SKT\n'
      '※ VIP / 골드회원 : 1천원당 100원 할인 또는 적립\n'
      '※ 실버 회원 : 1천원당 50원 할인 또는 적립\n'
      '※ 1일 1회 최대 2만원 할인/적립 가능(등급별 차등)\n'
      '※ 단, 담배, 주류, 서비스상품, +1 행사상품 등 일부 상품 제외\n'
      '\n\n'
      '이마트24\n\n'
      'KT\n'
      '<상시 할인 혜택>\n'
      '▶VVIP/VIP/GOLD\n'
      '- 1,000원당 100원 차감할인\n'
      '▶SILVER/WHITE/일반\n'
      '- 1,000원당 50원 차감할인\n'
      '※ 기타 유의사항\n'
      '- 일 1회, 결제 금액(이용 금액) 최대 20만원 한도 내 할인 적용\n'
      '- 할인 금액 상당 포인트 차감/ 포인트 부족 시 할인 불가\n'
      '- 주류, 담배, 안전상비의약품, 서비스 등 일부 품목 제외\n'
      '- 특수매장/임시매장 등 일부 매장 제외\n'
      '\n\n'
      '미니스톱\n\n'
      '카카오페이\n'
      '- 멤버십 가입고객 카카오페이로 결제 시 5% 할인\n'
      '- 멤버십 가입고객 결제 금액의 0.1% 적립\n'
      '- 미니스톱멤버십 가입 고객에 한해 할인 및 적립 가능합니다.\n'
      '- 1일 1회 최대 1만원 할인, 1회 최대 5회 적립 가능합니다.\n'
      '- 주류, 담배, 유가증권, 의약품, 종량제봉투, 비닐봉투, 서비스 상품은 혜택 불가합니다.\n'
      '- 할인의 경우, 카카오페이 결제수단에 한해서만 적용되며, 타 결제수단과 복합결제 시 할인 불가합니다.\n'
      '- 적립의 경우 카카오페이 및 모든 결제수단에 대해 적립 가능합니다.\n'
      '(카카오페이 결제 시 자동 적립/카카오페이 외 결제 수단 결제 시 멤버십 바코드로 적립 가능)\n'
      '- 타 제휴할인과 중복 혜택 불가합니다.\n'
      '- N+1, 매가할인 행사와 중복 혜택 가능합니다.\n';

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
                leading: const Icon(Icons.card_membership),
                title: const Text('멤버십 안내'),
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: true, // 바깥 영역 터치 시 닫음.
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Container(
                            height: 400,
                            child: SingleChildScrollView(
                              child: Text(membershipGuide),
                            ),
                          ),
                          insetPadding:
                              const EdgeInsets.fromLTRB(10, 40, 10, 40),
                          actions: [
                            TextButton(
                              child: const Text('확인'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                }),
            ListTile(
                leading: const Icon(Icons.privacy_tip_outlined),
                title: const Text('개인정보처리방침'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyPage()));
                }),
          ],
        ),
      );
}
