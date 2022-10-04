import 'package:flutter/material.dart';

import '../widgets/flexiblespace.dart';
import '../widgets/home_gridview.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        const SliverAppBar(
          collapsedHeight: 302, // 접힌 높이
          expandedHeight: 302, // 펴진 높이
          floating: true,
          snap: true,
          centerTitle: true,
          flexibleSpace: FlexibleSpace(),
        ),
      ],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            /*CupertinoSlidingSegmentedControl<int>(
              groupValue: convenienceGroupValue,
              children: {
                0: Text('전체'),
                1: Text('CU'),
                2: Text('GS25'),
                3: Text('세븐일레븐'),
                4: Text('미니스톱'),
                5: Text('emart24'),
              },
              onValueChanged: (groupValue) {
                setState(() => this.convenienceGroupValue = groupValue!);
              },
            ),
            CupertinoSlidingSegmentedControl<int>(
              groupValue: eventGroupValue,
              children: {
                0: Text('전체'),
                1: Text('1+1'),
                2: Text('2+1'),
                3: Text('3+1'),
                4: Text('덤증정'),
              },
              onValueChanged: (groupValue) {
                setState(() => this.eventGroupValue = groupValue!);
              },
            ),*/

            const Expanded(child: GridViewHome())
          ],
        ),
      ),
    );
  }
}
