import 'package:flutter/material.dart';
import '../models/image_filter_chip_data.dart';

class FilterChipConvenience extends StatefulWidget {
  const FilterChipConvenience({super.key});

  @override
  State<FilterChipConvenience> createState() => _FilterChipConvenienceState();
}

class _FilterChipConvenienceState extends State<FilterChipConvenience> {
  final double spacing = 8;
  List<ImageFilterChipData> filterChips = FilterChips.all;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: spacing,
      spacing: spacing,
      children: filterChips
          .map((filterChip) => FilterChip(
                avatar: filterChip.image,
                label: Text(filterChip.label),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: filterChip.color,
                ),
                backgroundColor: filterChip.color.withOpacity(0.1),

                // 선택이 됬을 때
                onSelected: (isSelected) => setState(() {
                  filterChips = filterChips.map((otherChip) {
                    return filterChip == otherChip
                        ? otherChip.copy(
                            isSelected: isSelected,
                            color: filterChip.color,
                            image: filterChip.image,
                            label: filterChip.label,
                          )
                        : otherChip;
                  }).toList();
                }),
                selected: filterChip.isSelected,
                checkmarkColor: filterChip.color,
                selectedColor: Color.fromARGB(255, 201, 114, 107),
              ))
          .toList(),
    );
  }
}

class FilterChips {
  static final all = <ImageFilterChipData>[
    const ImageFilterChipData(
      label: 'CU',
      image: Image(image: AssetImage('images/cu.jpg')),
      isSelected: false,
      color: Colors.purple,
    ),
    const ImageFilterChipData(
      label: 'GS25',
      image: Image(image: AssetImage('images/gs25.png')),
      isSelected: false,
      color: Colors.blue,
    ),
    const ImageFilterChipData(
      label: '세븐일레븐',
      image: Image(image: AssetImage('images/seven_eleven.png')),
      isSelected: false,
      color: Colors.green,
    ),
    const ImageFilterChipData(
      label: '이마트24',
      image: Image(image: AssetImage('images/emart24.jpg')),
      isSelected: false,
      color: Colors.orange,
    ),
    const ImageFilterChipData(
      label: '미니스톱',
      image: Image(image: AssetImage('images/ministop.jpg')),
      isSelected: false,
      color: Colors.yellow,
    ),
  ];
}
