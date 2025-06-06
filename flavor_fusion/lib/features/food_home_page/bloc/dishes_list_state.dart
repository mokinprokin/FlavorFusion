part of 'dishes_list_bloc.dart';
abstract class DishesListState {}
class DishesListInitial extends DishesListState {}

class DishesListLoading extends DishesListState {}

class DishesListLoaded extends DishesListState {
  final List<DishModel> dishes;
  final int page;
  DishesListLoaded({required this.dishes,required this.page});}

class DishesListError extends DishesListState {
  final Object? errorMessage;

  DishesListError({required this.errorMessage});
}