import 'package:cvs_information/screens/mappage.dart';
import 'package:cvs_information/widgets/flexiblespace.dart';
import 'package:cvs_information/widgets/navigation_drawer.dart';
import 'package:cvs_information/widgets/scroll_hide.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

List<String> items = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
];
final ScrollController scrollController = ScrollController();

@override
class _MainPageState extends State<MainPage> {
  int index = 0;

  final screens = [
    NestedScrollView(
      scrollDirection: Axis.vertical,
      controller: scrollController,
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          const SliverAppBar(
            collapsedHeight: 302, // 접힌 높이
            expandedHeight: 302, // 펴진 높이
            floating: true,
            snap: true,
            centerTitle: true,
            flexibleSpace: FlexibleSpace(),
          )
        ];
      },
      body: CustomScrollView(slivers: [
        SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              mainAxisSpacing: 10,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 224, 146, 146)),
                  child: GridTile(
                    child: Center(child: Text(items[index])),
                  ),
                );
              },
              childCount: items.length,
            )),
      ]),
    ),
    const MapPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[index],
        drawer: const NavigationDrawer(),
        bottomNavigationBar: ScrollToHideWidget(
            scrollController: scrollController,
            child: NavigationBar(
              height: 55,
              selectedIndex: index,
              onDestinationSelected: (index) =>
                  setState(() => this.index = index),
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: '홈'),
                NavigationDestination(icon: Icon(Icons.map), label: '지도'),
              ],
            )));
  }
}
