import 'package:dio/dio.dart';
import 'package:flavor_fusion/repositories/dish_item/models/cooking_stap.dart';
import 'package:flavor_fusion/repositories/dish_item/models/dish_structure.dart';
import 'package:flavor_fusion/repositories/dish_item/models/dish_item_model.dart';
import 'package:flavor_fusion/repositories/dish_item/models/energy_value_model.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;

class DishItemRepository {
  Future<List<DishItemModel>> getDishItem(String url,String rating, String cookTime,String date) async {
    List<DishItemModel> dishesList;
    try {
      dishesList = await _fetchDishItem(url,rating,cookTime,date);
    }on Exception catch (e, st) {
      debugPrint("$e,$st");
      dishesList = [];
    }
    return dishesList;
  }

  Future<List<DishItemModel>> _fetchDishItem(String url,String rating, String cookTime,String date) async {
    final response = await Dio().get(url);
    var document = parse(response.data);
    var dishes = document.querySelectorAll('.hrecipe');
    List<DishItemModel> dishesList=[];
    for(var i in dishes){
      final name = i.querySelector('.fn')!.text;
      final imageUrl = i.querySelector('.bigImgBox .stepphotos img')!.attributes['src'];
      final bigDescription = i.querySelector('.detailed_full span')!.text;
      List<DishStructure> structureRecipe=[];
      List<CookingStap> cookingSteps=[];
      late EnergyValueModel energyValue;
      for(var j in i.querySelectorAll(".flex-dot-line")){
        final nameIngredient = j.querySelector('.name')!.text;
        var countIngredient =j.querySelectorAll('span')[2].text;
        countIngredient=="По вкусу"?debugPrint("2"):countIngredient="$countIngredient ${j.querySelectorAll('span')[3].text}";
        structureRecipe.add(DishStructure(nameIngredient: nameIngredient, countIngredient: countIngredient));
      }

      for(var j in i.querySelectorAll(".instruction")){
        final imageStepUrl = j.querySelector('.detailed_step_photo_big a img')!.attributes["src"];
        final stepDescription = j.querySelector('.detailed_step_description_big')!.text;
        cookingSteps.add(CookingStap(imageUrl: imageStepUrl!, stepDescription: stepDescription));
      }

      try {
        final tab = document.querySelector(".calories_info");
        final energyList = tab!.querySelectorAll(".tab .circle span");
        final calories= energyList[0].text;
        final protein= energyList[1].text;
        final fat= energyList[2].text;
        final carbs= energyList[3].text;
        
        energyValue = EnergyValueModel(calories: calories, protein: protein, fat: fat, carbs: carbs);
      }catch (e, st) {
        debugPrint("$e,$st");
        energyValue = EnergyValueModel(calories: "none", protein: "none", fat: "none", carbs: "none");
      }
      dishesList.add(DishItemModel(name: name, imageUrl: imageUrl!, bigDescription: bigDescription, rating: rating, 
      cookingTime: cookTime, date: date,structureRecipe: structureRecipe,cookingSteps: cookingSteps,energyValueModel: energyValue));
    }
    return dishesList;
  }
}