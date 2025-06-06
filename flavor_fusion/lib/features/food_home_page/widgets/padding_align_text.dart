import 'package:flutter/material.dart';

class PaddingAlignText extends StatelessWidget {
  final String text;
  final FontWeight weight;
  final double fontSize;
  final Alignment alignment;
  final EdgeInsets padding;

  const PaddingAlignText({super.key, 
    required this.weight, 
    required this.fontSize, 
    required this.text, 
    required this.alignment, 
    required this.padding
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child:Align(
        alignment: alignment,
        child:
          Text(text,textAlign: TextAlign.left,style: TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: weight),)       
    ));
  }

}