import 'package:flavor_fusion/features/food_home_page/widgets/padding_align_text.dart';
import 'package:flutter/material.dart';

class MaxSymbolsText extends StatelessWidget {
  final String text;
  final int maxCharacters;
  final FontWeight weight;
  final double fontSize;
  final Alignment alignment;
  final EdgeInsets padding;

  const MaxSymbolsText({super.key, 
    required this.weight, 
    required this.fontSize, 
    required this.text, 
    required this.maxCharacters,
    required this.alignment, 
    required this.padding
  });

  @override
  Widget build(BuildContext context) {
    if (text.length <= maxCharacters) {
      return PaddingAlignText(text:text,weight: weight,fontSize: fontSize,alignment: alignment,padding: padding);
    } else {
      return PaddingAlignText(text:'${text.substring(0, maxCharacters)}..',weight: weight,fontSize: fontSize,alignment: alignment,padding: padding);
    }
  }
}
