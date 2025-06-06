import 'package:dio/dio.dart';
import 'package:flavor_fusion/repositories/dishes_list/models/dish_model.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;

class DishesListRepository {

  Future<List<DishModel>> getDishesList(String query,int page) async {
    List<DishModel> dishesList;
    try {
      dishesList = await _fetchDishesList(query,page);
    }on Exception catch (e, st) {
      debugPrint("$e,$st");
      dishesList = [];
    }
    return dishesList;
  }

  Future<List<DishModel>> _fetchDishesList(String query,int page) async {
    final response = await Dio().get('https://povar.ru/xmlsearch?query=$query&page=$page');
    var document = parse(response.data);
    var dishes = document.querySelectorAll('.recipe');
    List<DishModel> dishesList=[];
    for(var i in dishes){
        final name = i.querySelector('.listRecipieTitle')!.text;
        final imageUrl = i.querySelector('.hashString img')!.attributes['src'];
        final description = i.querySelector('.txt')!.text;
        final rating = i.querySelector('.rate')!.text;
        final cookTime = i.querySelector('.cook-time .value')!.text;
        final recipeLink = "https://povar.ru/${i.querySelector('.listRecipieTitle')!.attributes['href']}";
        final date = i.querySelector('.owner')!.text;
        dishesList.add(DishModel(name: name, imageUrl: imageUrl!, description: description, rating: rating, cookingTime: cookTime, recipeLink: recipeLink,date: date));
    }
    return dishesList;

  }
  Future<List<DishModel>> getPopularDishesList(String url) async {
    List<DishModel> dishesList;
    try {
      dishesList = await _fetchPopularDishesList(url);
    }on Exception catch (e, st) {
      debugPrint("$e,$st");
      dishesList = [];
    }
    return dishesList;
  }

  Future<List<DishModel>> _fetchPopularDishesList(String url) async {
    final response = await Dio().get(url);
    var document = parse(response.data);
    var dishes = document.querySelectorAll('.recipe');
    List<DishModel> dishesList=[];
    for(var i in dishes){
        final name = i.querySelector('.listRecipieTitle')!.text;
        final imageUrl = i.querySelector('.hashString img')!.attributes['src'];
        final description = i.querySelector('.txt')!.text;
        late var rating = "0";
        if(i.querySelector('.rate')!=null){
            rating = i.querySelector('.rate')!.text;
        }
        final cookTime = i.querySelector('.cook-time .value')!.text;
        final recipeLink = "https://povar.ru/${i.querySelector('.listRecipieTitle')!.attributes['href']}";
        final date = i.querySelector('.owner')!.text;
        dishesList.add(DishModel(name: name, imageUrl: imageUrl!, description: description, rating: rating, cookingTime: cookTime, recipeLink: recipeLink,date: date));
    }

    return dishesList;
  }
}