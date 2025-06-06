part of 'dishes_item_bloc.dart';
abstract class DishState {}
class DishInitial extends DishState {}

class DishLoading extends DishState {}

class DishLoaded extends DishState {
  final List<DishItemModel> dish;
  DishLoaded({required this.dish});}

class DishError extends DishState {
  final Object? errorMessage;

  DishError({required this.errorMessage});
}