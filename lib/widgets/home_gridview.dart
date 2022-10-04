import 'package:flutter/material.dart';

class GridViewHome extends StatefulWidget {
  const GridViewHome({super.key});

  @override
  State<GridViewHome> createState() => _GridViewHomeState();
}

class _GridViewHomeState extends State<GridViewHome> {
  List<String> items = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        mainAxisSpacing: 10,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Container(
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 224, 146, 146)),
          child: GridTile(
            child: Center(child: Text(items[index])),
          ),
        );
      },
    );
  }
}
