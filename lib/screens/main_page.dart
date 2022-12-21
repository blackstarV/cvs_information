import 'package:cvs_information/models/productAll.dart';
import 'package:cvs_information/screens/map_page.dart';
import 'package:cvs_information/widgets/membership.dart';
import 'package:cvs_information/widgets/navigation_drawer.dart';
import 'package:cvs_information/widgets/scroll_hide.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/event.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

final ScrollController scrollController = ScrollController();

@override
class _MainPageState extends State<MainPage> {
  int index = 0;
  late List<Convenience> _conveniences;
  late List<EventType> _eventTypes;
  late List<String> _filtersCompany;
  late List<String> _filtersType;
  List<ProductAll> duplicateItems = List<ProductAll>.empty();
  var items = <ProductAll>[];
  var numberFormat = NumberFormat('###,###,###,###');
  String searchValue = '';
  TextEditingController editingController = TextEditingController(text: '');

  Iterable<Widget> get convenienceWidgets sync* {
    for (Convenience convenience in _conveniences) {
      yield Padding(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          avatar:
              (convenience.image != '') ? Image.asset(convenience.image) : null,
          label: Text(convenience.name),
          selected: _filtersCompany.contains(convenience.name),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _filtersCompany.clear();
                _filtersCompany.add(convenience.name);
              } else {
                if (_filtersCompany.contains('전체') == false) {
                  _filtersCompany.removeWhere((String name) {
                    return name == convenience.name;
                  });
                  _filtersCompany.add('전체');
                }
              }
              print(_filtersCompany);
              filterSearchResults(searchValue);
            });
          },
        ),
      );
    }
  }

  Iterable<Widget> get eventTypeWidgets sync* {
    for (EventType eventType in _eventTypes) {
      yield Padding(
        padding: const EdgeInsets.all(2.0),
        child: FilterChip(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          label: Text(eventType.name),
          selected: _filtersType.contains(eventType.name),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _filtersType.clear();
                _filtersType.add(eventType.name);
              } else {
                if (_filtersType.contains('전체') == false) {
                  _filtersType.removeWhere((String name) {
                    return name == eventType.name;
                  });
                  _filtersType.add('전체');
                }
              }
              print(_filtersType);
              filterSearchResults(searchValue);
            });
          },
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _filtersCompany = <String>['전체'];
    _filtersType = <String>['전체'];
    _conveniences = <Convenience>[
      const Convenience('전체', ''),
      const Convenience('CU', 'images/cu.png'),
      const Convenience('GS25', 'images/gs25.png'),
      const Convenience('7-ELEVEn', 'images/seven_eleven.png'),
      const Convenience('emart24', 'images/emart24.png'),
      const Convenience('MINISTOP', 'images/ministop.png'),
    ];
    _eventTypes = <EventType>[
      const EventType('전체'),
      const EventType('1+1'),
      const EventType('2+1'),
      const EventType('3+1'),
      const EventType('할인'),
    ];
  }

  void filterSearchResults(String query) {
    List<ProductAll> dummySearchList = <ProductAll>[];
    dummySearchList.addAll(duplicateItems);

    if (query.isNotEmpty) {
      List<ProductAll> dummyListData = <ProductAll>[];
      dummySearchList.forEach((item) {
        if (item.name.contains(query)) {
          if (_filtersCompany[0] == '전체') {
            if (_filtersType[0] == '전체') {
              dummyListData.add(item);
            } else if (item.type.contains(_filtersType[0])) {
              dummyListData.add(item);
            } else {}
          } else if (item.company.contains(_filtersCompany[0])) {
            // 필터 돼있는 회사랑 같은 회사면 item에 넣음

            if (_filtersType[0] == '전체') {
              dummyListData.add(item);
            } else if (item.type.contains(_filtersType[0])) {
              dummyListData.add(item);
            } else {}
          } else {}
        }
      });

      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      List<ProductAll> dummyListData = <ProductAll>[];
      dummySearchList.forEach((item) {
        if (item.name.contains(query)) {
          if (_filtersCompany[0] == '전체') {
            if (_filtersType[0] == '전체') {
              dummyListData.add(item);
            } else if (item.type.contains(_filtersType[0])) {
              dummyListData.add(item);
            } else {}
          } else if (item.company.contains(_filtersCompany[0])) {
            // 필터 돼있는 회사랑 같은 회사면 item에 넣음

            if (_filtersType[0] == '전체') {
              dummyListData.add(item);
            } else if (item.type.contains(_filtersType[0])) {
              dummyListData.add(item);
            } else {}
          } else {}
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (duplicateItems.isEmpty &&
        Provider.of<List<ProductAll>?>(context, listen: true) != null) {
      duplicateItems = List<ProductAll>.generate(
          Provider.of<List<ProductAll>>(context, listen: true).length,
          (index) =>
              Provider.of<List<ProductAll>>(context, listen: false)[index]);
      items.addAll(duplicateItems);
    }

    final screens = [
      NestedScrollView(
        scrollDirection: Axis.vertical,
        controller: scrollController,
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20))),
                collapsedHeight: 246, // 접힌 높이
                expandedHeight: 246, // 펴진 높이
                floating: true,
                snap: true,
                centerTitle: true,
                flexibleSpace: Scaffold(
                    appBar: AppBar(
                      title: Text('편의점 정보'),
                      centerTitle: true,
                      automaticallyImplyLeading: false,
                    ),
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // 제품명 검색창
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: TextField(
                            onChanged: (value) {
                              searchValue = value;
                              filterSearchResults(searchValue);
                            },
                            controller: editingController,
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.search),
                                labelText: '검색',
                                hintText: '제품명',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                )),
                          ),
                        ),
                        SingleChildScrollView(
                            // 편의점 필터 Chip
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            scrollDirection: Axis.horizontal,
                            child: Wrap(children: convenienceWidgets.toList())),
                        SingleChildScrollView(
                            // 행사 필터 Chip
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            scrollDirection: Axis.horizontal,
                            child: Wrap(children: eventTypeWidgets.toList())),
                      ],
                    )))
          ];
        },
        body: CustomScrollView(slivers: [
          Builder(builder: (context) {
            return SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250,
                  mainAxisSpacing: 10,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Container(
                        padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
                        child: (items != null)
                            ? GridTile(
                                child: Image.network('${items[index].imageURL}',
                                    fit: BoxFit.scaleDown),
                                header: Container(
                                  alignment: Alignment.topLeft,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: items[index].typeImage,
                                  ),
                                ),
                                footer: Container(
                                  height: 60,
                                  child: GridTileBar(
                                    title: (items[index].name.length >= 10)
                                        ? Text(
                                            '${items[index].name.substring(0, 10)}\n${items[index].name.substring(10)}')
                                        : Text(items[index].name),
                                    subtitle: Text(
                                        '${numberFormat.format(items[index].price)}원'),
                                    backgroundColor: Colors.black54,
                                    trailing: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: items[index].companyImage,
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: CircularProgressIndicator()));
                  },
                  childCount: items.length,
                ));
          }),
        ]),
      ),
      Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: Scaffold(
              body: ListView.builder(
                  controller: scrollController,
                  itemCount:
                      Provider.of<List<Event>?>(context, listen: true)?.length,
                  itemBuilder: ((context, index) {
                    return Card(
                        child:
                            (Provider.of<List<Event>?>(context, listen: true) !=
                                    null)
                                ? ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: Provider.of<List<Event>>(context,
                                              listen: false)[index]
                                          .companyImage,
                                    ),
                                    title: Text(Provider.of<List<Event>>(
                                            context,
                                            listen: false)[index]
                                        .name),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SingleChildScrollView(
                                                    child: Image.network(
                                                        '${Provider.of<List<Event>>(context, listen: false)[index].imageURL}',
                                                        fit: BoxFit.scaleDown),
                                                  )));
                                    },
                                  )
                                : Center(child: CircularProgressIndicator()));
                  })),
            ),
          ),
        ],
      ),
      const MapPage(),
    ];
    ////////////////////////

    return Scaffold(
      body: screens[index],
      drawer: NavigationDrawer(),
      bottomNavigationBar: ScrollToHideWidget(
          scrollController: scrollController,
          child: NavigationBar(
            height: 55,
            selectedIndex: index,
            onDestinationSelected: (index) => setState(() {
              if (index == 0) {
                scrollController.animateTo(0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              }
              this.index = index;
            }),
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: '홈'),
              NavigationDestination(
                  icon: Icon(Icons.event_note_sharp), label: '이벤트'),
              NavigationDestination(icon: Icon(Icons.map), label: '지도'),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class Convenience {
  const Convenience(this.name, this.image);
  final String name;
  final String image;
}

class EventType {
  const EventType(this.name);
  final String name;
}
