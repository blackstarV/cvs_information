import 'package:cvs_information/widgets/filter_chip_convenience.dart';
import 'package:cvs_information/widgets/filter_chip_event.dart';
import 'package:flutter/material.dart';

class FlexibleSpace extends StatefulWidget {
  const FlexibleSpace({super.key});

  @override
  State<FlexibleSpace> createState() => _FlexibleSpaceState();
}

class _FlexibleSpaceState extends State<FlexibleSpace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('편의점 정보'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // 제품명 검색창
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.search),
                    hintText: '제품명',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    )),
              ),
            ),
            const SingleChildScrollView(
                // 편의점 필터 Chip
                padding: EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                child: FilterChipConvenience()),
            const SingleChildScrollView(
                // 행사 필터 Chip
                padding: EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                child: FilterChipEvent()),
          ],
        ));
  }
}
