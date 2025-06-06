import 'package:flavor_fusion/features/food_home_page/widgets/widgets.dart';
import 'package:flavor_fusion/repositories/dish_item/models/energy_value_model.dart';
import 'package:flutter/material.dart';
import 'energy_value_tile.dart';

class EnergyValueWidget extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final EnergyValueModel energyValueModel;

  const EnergyValueWidget({super.key,  
    required this.screenHeight, required this.screenWidth, required this.energyValueModel, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom:screenHeight*.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          EnergyValueTile(padding: const EdgeInsets.all(8), nameText: "Калорийность", countText: energyValueModel.calories, width: screenWidth*1.15,fontSizeName: screenWidth*.04,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              EnergyValueTile(padding: const EdgeInsets.all(8), nameText: "белки", countText: energyValueModel.protein, width: screenWidth,fontSizeName: screenWidth*.04,),
              EnergyValueTile(padding: const EdgeInsets.all(8), nameText: "жиры", countText: energyValueModel.fat, width: screenWidth,fontSizeName: screenWidth*.04,),
              EnergyValueTile(padding: const EdgeInsets.all(8), nameText: "углеводы", countText: energyValueModel.carbs, width: screenWidth,fontSizeName: screenWidth*.04,),
            ],
          ),
          PaddingAlignText(weight: FontWeight.w600, fontSize: screenWidth*.045, text: "* Пищевая ценность на 100г", alignment: Alignment.centerLeft, padding: EdgeInsets.only(top: 5,left: screenWidth*.05))
        ],
      ),
    );
  }
}
