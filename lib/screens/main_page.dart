import 'package:cvs_information/models/productAll.dart';
import 'package:cvs_information/screens/map_page.dart';
import 'package:cvs_information/widgets/membership.dart';
import 'package:cvs_information/widgets/navigation_drawer.dart';
import 'package:cvs_information/widgets/scroll_hide.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
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
  late List<String> _filtersCvs;
  late List<String> _filtersEvent;
  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = <String>[];
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
          selected: _filtersCvs.contains(convenience.name),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _filtersCvs.clear();
                _filtersCvs.add(convenience.name);
              } else {
                if (_filtersCvs.contains('전체') == false) {
                  _filtersCvs.removeWhere((String name) {
                    return name == convenience.name;
                  });
                  _filtersCvs.add('전체');
                }
              }
              print(_filtersCvs);
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
          selected: _filtersEvent.contains(eventType.name),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _filtersEvent.clear();
                _filtersEvent.add(eventType.name);
              } else {
                if (_filtersEvent.contains('전체') == false) {
                  _filtersEvent.removeWhere((String name) {
                    return name == eventType.name;
                  });
                  _filtersEvent.add('전체');
                }
              }
              print(_filtersEvent);
            });
          },
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    items.addAll(duplicateItems);
    _filtersCvs = <String>['전체'];
    _filtersEvent = <String>['전체'];
    _conveniences = <Convenience>[
      const Convenience('전체', ''),
      const Convenience('CU', 'images/cu.jpg'),
      const Convenience('GS25', 'images/gs25.png'),
      const Convenience('세븐일레븐', 'images/seven_eleven.png'),
      const Convenience('이마트24', 'images/emart24.jpg'),
      const Convenience('미니스톱', 'images/ministop.jpg'),
    ];
    _eventTypes = <EventType>[
      const EventType('전체'),
      const EventType('1+1'),
      const EventType('2+1'),
      const EventType('3+1'),
      const EventType('할인'),
      const EventType('덤증정'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    void filterSearchResults(String query) {
      List<String> dummySearchList = <String>[];
      dummySearchList.addAll(duplicateItems);
      if (query.isNotEmpty) {
        List<String> dummyListData = <String>[];
        dummySearchList.forEach((item) {
          if (item.contains(query)) {
            dummyListData.add(item);
          }
        });
        setState(() {
          items.clear();
          items.addAll(dummyListData);
        });
        return;
      } else {
        setState(() {
          items.clear();
          items.addAll(duplicateItems);
        });
      }
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
                collapsedHeight: 245, // 접힌 높이
                expandedHeight: 245, // 펴진 높이
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
                              filterSearchResults(value);
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
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 224, 146, 146)),
                        child: (Provider.of<List<ProductAll>?>(context,
                                    listen: true) !=
                                null)
                            ? GridTile(
                                child: Center(
                                  child: Text(Provider.of<List<ProductAll>>(
                                          context,
                                          listen: false)[index]
                                      .name),
                                ),
                                /*Image.network(
                                    'https://tqklhszfkvzk6518638.cdn.ntruss.com/product/8801045303062.jpg',
                                    fit: BoxFit.scaleDown)*/

                                header: Text(Provider.of<List<ProductAll>>(
                                        context,
                                        listen: false)[index]
                                    .type), // 1+1 2+1 3+1 할인 덤증정 색깔 구분 예정

                                footer: GridTileBar(
                                    leading: FavoriteButton(
                                      valueChanged: (_isFavorite) {
                                        Provider.of<List<ProductAll>>(context,
                                                listen: false)[index]
                                            .isFavorite = _isFavorite;
                                      },
                                    ),
                                    title: Text(Provider.of<List<ProductAll>>(
                                            context,
                                            listen: false)[index]
                                        .name)),
                              )
                            : const Center(child: CircularProgressIndicator()));
                  },
                  childCount:
                      Provider.of<List<ProductAll>?>(context, listen: true)
                          ?.length,
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
                                    leading: (Provider.of<List<Event>>(context,
                                                    listen: false)[index]
                                                .company ==
                                            'CU')
                                        ? Image.asset('images/cu.jpg',
                                            width: 40)
                                        : (Provider.of<List<Event>>(context,
                                                        listen: false)[index]
                                                    .company ==
                                                'GS25')
                                            ? Image.asset('images/gs25.png',
                                                width: 40)
                                            : (Provider.of<List<Event>>(context,
                                                            listen:
                                                                false)[index]
                                                        .company ==
                                                    '세븐일레븐')
                                                ? Image.asset('images/seven_eleven.png', width: 40)
                                                : (Provider.of<List<Event>>(context, listen: false)[index].company == '이마트24')
                                                    ? Image.asset('images/emart24.jpg', width: 40)
                                                    : (Provider.of<List<Event>>(context, listen: false)[index].company == '미니스톱')
                                                        ? Image.asset('images/emart24.jpg', width: 40)
                                                        : Image.asset('', width: 40), // 이벤트 페이지 사진 (Image로 대체 예정)
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
                                      /*Image.network(
                                        '${Provider.of<List<Event>>(context, listen: false)[index].imageURL}',
                                        fit: BoxFit
                                            .scaleDown),*/
                                    }, // 이벤트 페이지 링크로 접속
                                  )
                                : Center(child: CircularProgressIndicator()));
                  })),
              bottomNavigationBar: SingleChildScrollView(
                  // 편의점 필터 Chip
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  scrollDirection: Axis.horizontal,
                  child: Wrap(children: convenienceWidgets.toList())),
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
            onDestinationSelected: (index) =>
                setState(() => this.index = index),
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
