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
          children: const <Widget>[Expanded(child: GridViewHome())],
        ),
      ),
    );
  }
}
