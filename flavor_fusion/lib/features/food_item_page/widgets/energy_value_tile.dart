
import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:flutter/material.dart';

class EnergyValueTile extends StatelessWidget {
  final String nameText;
  final String countText;
  final double width;
  final EdgeInsets padding;
  final double fontSizeName;

  const EnergyValueTile({super.key,  
    required this.padding, 
    required this.nameText, 
    required this.countText, 
    required this.width, 
    required this.fontSizeName
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:padding,
      child: Column(
        children: [
          SizedBox(
            width: width*.203,
            child: CircleProgressBar(
            foregroundColor: const Color.fromARGB(255, 41, 199, 10), 
            value: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(countText,textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: width*.05,fontWeight: FontWeight.w500))),
            ),
            ),
          ),
          Text(nameText,textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: fontSizeName,fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}
