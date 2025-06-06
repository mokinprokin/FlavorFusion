
import 'package:flavor_fusion/features/food_home_page/bloc/dishes_list_bloc.dart';
import 'package:flavor_fusion/features/search_page/widgets/result_food_tile.dart';
import 'package:flavor_fusion/food_app.dart';
import 'package:flavor_fusion/repositories/repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _dishesListBloc = DishesListBloc(GetIt.I<DishesListRepository>());
  late dynamic args;
  late dynamic query;
  late List<DishModel> dishesList;
  final _scrollController = ScrollController();
  double currentPosition=0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {

      if(UniServices.query == ""){
        args = ModalRoute.of(context)?.settings.arguments;
        query = args as Map;
      }
      else{
        query = {"query":UniServices.query};
      }
      
      _dishesListBloc.add(LoadDishesList(query["query"] ?? "", 1, []));
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    // final Themes=Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Поиск'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.jumpTo(0);
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.arrow_upward,color: Colors.white,), // Цвет FAB
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: RefreshIndicator(
        color: Colors.red,
        backgroundColor: Colors.white,
        onRefresh: () async {

        },
        child: ListView(
          controller: _scrollController, // 
          children: [
            Container(
              child: BlocBuilder<DishesListBloc,DishesListState>(
                builder: (context, state) {
                  if (state is DishesListLoaded) {
                    dishesList = state.dishes;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (currentPosition > 0) {
                        _scrollController.animateTo(currentPosition, duration: Durations.long3, curve: Curves.bounceOut);
                      }
                    });
                    return Column(
                      children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: CupertinoSearchTextField(
                              controller: TextEditingController(text: ""),
                              placeholder: "Поиск...",
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              onSubmitted: (String value){
                                setState(() {
                                  query["query"] = value;
                                  _dishesListBloc.add(LoadDishesList(value, 1,[]));
                                });
                              },
                          ),     
                          ),

                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            
                            children: List.generate(query['query'].toString().contains("[only]")?1:state.dishes.length, (index) {
                              final dish=state.dishes[index];
                              return Container(
                                child: ResultFoodTile(width: screenWidth*.9, height: screenHeight*.148, name: dish.name,rating: dish.rating,description: dish.description,date: dish.date,time: dish.cookingTime, imageUrl: dish.imageUrl,recipeLink: dish.recipeLink, leftMargin: 17, rightMargin: 10),
                              );
                            }),
                            
                          ),
                        ),
                          
                          
                        (state.dishes.length%20) == 0 && !query['query'].toString().contains("[only]")? Padding(
                          padding: const EdgeInsets.all(20),
                          child:Center(
                            child: InkWell(  
                              child: Text('ещё...', style: TextStyle(fontSize: screenWidth*.04,color: const Color.fromARGB(255, 114, 114, 114)),),  
                              onTap: () {
                                // 2. Сохраните текущее положение прокрутки
                                currentPosition = _scrollController.position.pixels;
                                setState(() {
                                  print(state.page);
                                  _dishesListBloc.add(LoadDishesList(query["query"], state.page+1,state.dishes));
                                  // 3. Восстановите сохраненное положение прокрутки
                                });
                              },
                            ),
                        )):const SizedBox(),     
                      ],
                      
                    );     
                  }
                  if (state is DishesListError){
                    return Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Something went wrong",
                          ),
                          const Text(
                            "Please try again later",
                            ),
                          const SizedBox(height: 10,),
                          TextButton(child: const Text("Try again",),
                            onPressed: ()  {_dishesListBloc.add(LoadDishesList(query["query"], 1,[]));}
                          )
                      ],
                      ),
                      
                    );
                  }
                  return const Center(child: CircularProgressIndicator(color: Colors.red,));
                },
                bloc: _dishesListBloc,
              )
              
            )
            
          ],
        ),
      )
    );
  }

}