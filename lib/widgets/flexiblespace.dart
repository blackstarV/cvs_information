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
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.search),
                    hintText: '제품명',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: const FilterChipConvenience()),
            Container(
                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: const FilterChipEvent()),
          ],
        ));
  }
}
