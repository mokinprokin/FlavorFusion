import 'package:flutter/material.dart';

import '../../food_home_page/widgets/widgets.dart';

class CarouselItem extends StatelessWidget {
  final double width;
  final double height;
  final String stepDescription;
  final String cookingStep;

  const CarouselItem({super.key, 
    required this.width,
    required this.height,
    required this.stepDescription,
    required this.cookingStep,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(left: 3, right: 15, top: 10, bottom: height * .04),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 71, 71, 71).withOpacity(.5),
            blurRadius: 3.0, // soften the shadow
            spreadRadius: 0.04, //extend the shadow
          )
        ],
      ),
      child: ListView(
        children: [
          Column(
            children: [
              Container(
                width: width * .89,
                height: width * .6,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(cookingStep),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              PaddingAlignText(
                  weight: FontWeight.w400,
                  fontSize: height * .024,
                  text: stepDescription,
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.only(left: 8, right: 5, top: 8, bottom: 8))
            ],
          ),
        ],
      ),
    );
  }
}
