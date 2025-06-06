part of 'dishes_item_bloc.dart';
abstract class DishEvent {}

class LoadDish extends DishEvent {
  final String url;
  final String rating;
  final String cookTime;
  final String date;
  
  LoadDish(this.url, this.rating, this.cookTime, this.date);
}

  
