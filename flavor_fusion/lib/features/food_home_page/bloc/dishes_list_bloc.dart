import 'package:flavor_fusion/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
part 'dishes_list_event.dart';
part 'dishes_list_state.dart';
class DishesListBloc extends Bloc<DishesListEvent, DishesListState> {
  DishesListBloc(this._repository) : super(DishesListInitial()) {
    on<LoadDishesPopularList>((event, emit) async {
      emit(DishesListLoading());
      try{
        if(state is! DishesListLoaded){
          emit(DishesListLoading());
        }
        final dishesList= await _repository.getPopularDishesList("https://povar.ru/nasha_kuhnia/");
        emit(DishesListLoaded(dishes:dishesList,page:1));
      }
      catch(e){
          emit(DishesListError(errorMessage:e));
          GetIt.I<Talker>().handle(e);
      }

    });
    on<LoadDishesList>((event, emit) async {
      emit(DishesListLoading());
      try{
        if(state is! DishesListLoaded){
          emit(DishesListLoading());
        }
        var dishesList= await _repository.getDishesList(event.query,event.page);
        var dishList =event.dishesList+dishesList;
        emit(DishesListLoaded(dishes:dishList,page:event.page));
      }
      catch(e){
          emit(DishesListError(errorMessage:e));
      }

    });
  }
  final DishesListRepository _repository;
}