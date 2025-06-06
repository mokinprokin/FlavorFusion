part of 'dishes_list_bloc.dart';
abstract class DishesListEvent {}

class LoadDishesList extends DishesListEvent {
  final String query;
  final int page;
  final List<DishModel> dishesList;
  
  LoadDishesList(this.query, this.page, this.dishesList);
}
class LoadDishesPopularList extends DishesListEvent {}
  
