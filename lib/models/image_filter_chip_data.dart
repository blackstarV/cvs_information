import 'package:flutter/material.dart';

class ImageFilterChipData {
  final String label;
  final Color color;
  final Image image;
  final bool isSelected;

  const ImageFilterChipData({
    required this.label,
    required this.image,
    required this.color,
    this.isSelected = false,
  });

  ImageFilterChipData copy({
    required String label,
    required Image image,
    required Color color,
    required bool isSelected,
  }) =>
      ImageFilterChipData(
        label: label,
        image: image,
        color: color,
        isSelected: isSelected,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageFilterChipData &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          image == other.image &&
          color == other.color &&
          isSelected == other.isSelected;

  @override
  int get hashCode =>
      label.hashCode ^ image.hashCode ^ color.hashCode ^ isSelected.hashCode;
}
