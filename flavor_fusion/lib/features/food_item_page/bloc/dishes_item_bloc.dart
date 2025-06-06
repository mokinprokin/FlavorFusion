import 'package:flavor_fusion/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'dishes_item_event.dart';
part 'dishes_item_state.dart';
class DishBloc extends Bloc<DishEvent, DishState> {
  DishBloc(this._repository) : super(DishInitial()) {
    on<LoadDish>((event, emit) async {
      emit(DishLoading());
      try{
        if(state is! DishLoaded){
          emit(DishLoading());
        }
        final dishesList= await _repository.getDishItem(event.url,event.rating,event.cookTime,event.date);
        emit(DishLoaded(dish:dishesList));
      }
      catch(e){
          emit(DishError(errorMessage:e));
      }

    });

  }
  final DishItemRepository _repository;
}