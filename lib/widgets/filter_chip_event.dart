import 'package:flutter/material.dart';
import '../models/normal_filter_chip_data.dart';

class FilterChipEvent extends StatefulWidget {
  const FilterChipEvent({super.key});

  @override
  State<FilterChipEvent> createState() => _FilterChipEventState();
}

class _FilterChipEventState extends State<FilterChipEvent> {
  final double spacing = 8;
  List<FilterChipData> filterChips = FilterChips.all;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: spacing,
      spacing: spacing,
      children: filterChips
          .map((filterChip) => FilterChip(
                label: Text(filterChip.label),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: filterChip.color,
                ),
                backgroundColor: filterChip.color.withOpacity(0.1),
                onSelected: (isSelected) => setState(() {
                  filterChips = filterChips.map((otherChip) {
                    return filterChip == otherChip
                        ? otherChip.copy(
                            isSelected: isSelected,
                            color: filterChip.color,
                            label: filterChip.label,
                          )
                        : otherChip;
                  }).toList();
                }),
                selected: filterChip.isSelected,
                checkmarkColor: filterChip.color,
                selectedColor: filterChip.color.withOpacity(0.45),
              ))
          .toList(),
    );
  }
}

class FilterChips {
  static final all = <FilterChipData>[
    const FilterChipData(
      label: '1+1',
      isSelected: false,
      color: Colors.purple,
    ),
    const FilterChipData(
      label: '2+1',
      isSelected: false,
      color: Colors.blue,
    ),
    const FilterChipData(
      label: '3+1',
      isSelected: false,
      color: Colors.green,
    ),
    const FilterChipData(
      label: '덤증정',
      isSelected: false,
      color: Colors.orange,
    ),
  ];
}
