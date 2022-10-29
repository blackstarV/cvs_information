import 'package:cvs_information/models/productCU.dart';
import 'package:cvs_information/screens/mappage.dart';
import 'package:cvs_information/screens/wishlistpage.dart';
import 'package:cvs_information/widgets/filter_chip_convenience.dart';
import 'package:cvs_information/widgets/flexiblespace.dart';
import 'package:cvs_information/widgets/membership.dart';
import 'package:cvs_information/widgets/navigation_drawer.dart';
import 'package:cvs_information/widgets/scroll_hide.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

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
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20))),
            collapsedHeight: 245, // 접힌 높이
            expandedHeight: 245, // 펴진 높이
            floating: true,
            snap: true,
            centerTitle: true,
            flexibleSpace: FlexibleSpace(),
          )
        ];
      },
      body: CustomScrollView(slivers: [
        Consumer<List<ProductCU>?>(
          builder: (_, productCU, __) => SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                mainAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 224, 146, 146)),
                      child: (productCU != null)
                          ? GridTile(
                              child: Center(child: Text(productCU[index].name)))
                          : const Center(child: CircularProgressIndicator()));
                },
                childCount: productCU?.length,
              )),
        ),
      ]),
    ),
    Column(
      children: [
        const SizedBox(height: 10),
        Expanded(
          child: Scaffold(
            body: ListView.builder(
                controller: scrollController,
                itemCount: 20,
                itemBuilder: ((context, index) {
                  return Card(
                      child: ListTile(
                    leading: const Icon(
                        size: 60, Icons.image), // 이벤트 페이지 사진 (Image로 대체 예정)
                    title: const Text('Title'), // 이벤트 페이지 제목
                    subtitle: const Text("subTitle"), // 이벤트 페이지 부제목
                    onTap: () {}, // 이벤트 페이지 링크로 접속
                  ));
                })),
            bottomNavigationBar: const SingleChildScrollView(
                // 편의점 필터 Chip
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                scrollDirection: Axis.horizontal,
                child: FilterChipConvenience()),
          ),
        ),
      ],
    ),
    const MapPage(),
    const WishlistPage()
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
              NavigationDestination(
                  icon: Icon(Icons.event_note_sharp), label: '이벤트'),
              NavigationDestination(icon: Icon(Icons.map), label: '지도'),
              NavigationDestination(icon: Icon(Icons.favorite), label: '찜'),
            ],
          )),
      floatingActionButton: ScrollToHideWidget(
        scrollController: scrollController,
        child: FloatingActionButton(
          child: const Icon(Icons.qr_code),
          onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              context: context,
              builder: (context) => const MemberShipWidget()),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
