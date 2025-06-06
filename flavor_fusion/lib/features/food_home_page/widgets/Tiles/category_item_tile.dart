import 'package:flutter/material.dart';

class CategoryItemTile extends StatelessWidget {
  final double width;
  final double height;
  final String name;
  final String imageUrl;
  final double leftMargin;
  final double rightMargin;

  const CategoryItemTile({super.key, 
    required this.width,
    required this.height,
    required this.name,
    required this.imageUrl,
    required this.leftMargin,
    required this.rightMargin,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
          Navigator.of(context).pushNamed("/search",arguments: {'query':name});
      },
      child: Container(
        width: height*.52,
        margin: EdgeInsets.only(top: height*.03, bottom: 10, left: leftMargin, right: rightMargin),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(54, 65, 65, 65).withOpacity(0.5),
              spreadRadius: .5,
              blurRadius: 6,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  name,
                  style: TextStyle(color: const Color.fromARGB(253, 0, 0, 0), fontSize: width*.13, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8, right: 15),
                child: Image.network(imageUrl, width: width*.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}