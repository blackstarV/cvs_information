import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KTScreen extends StatefulWidget {
  const KTScreen({super.key});

  @override
  State<KTScreen> createState() => _KTScreenState();
}

class _KTScreenState extends State<KTScreen> {
  String stringData = '';
  String cardNumber = '';
  late SharedPreferences preferences;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    init();
  }

  Future init() async {
    preferences = await SharedPreferences.getInstance();
    final String? cardNumber = preferences.getString('cardNumberKT');
    if (cardNumber == null) return;

    setState(() {
      this.cardNumber = cardNumber; // 멤버변수에 반영
      textEditingController.text = cardNumber; // 텍스트필드에 반영
      stringData = cardNumber; // 바코드에 반영
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      BarcodeWidget(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(5),
        width: 260,
        height: 100,
        barcode: Barcode.code128(),
        style: const TextStyle(color: Colors.black),
        data: stringData.replaceAll(' ', ''),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: TextField(
            controller: textEditingController,
            decoration: const InputDecoration(
                hintText: '0000 0000 0000 0000',
                labelText: '멤버십 번호 입력',
                prefixIcon: Icon(Icons.credit_card),
                counterText: ''),
            maxLength: 19,
            keyboardType: TextInputType.number,
            inputFormatters: [
              CreditCardFormatter(),
            ],
            onChanged: (value) async {
              setState(() {
                stringData = value; // 바코드에 반영
              });
              preferences.setString('cardNumberKT', stringData); // 사용자 디바이스에 저장
            },
          ),
        ),
      )
    ]);
  }
}
