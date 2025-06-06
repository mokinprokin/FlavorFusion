import 'package:flavor_fusion/repositories/dish_favorites_repository/dish_favorites_repository.dart';
import 'package:flavor_fusion/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';

class StackImageWidget extends StatefulWidget {
  final double width;
  final double height;
  final List<DishItemModel> dish;
  final args;

  const StackImageWidget({super.key, 
    required this.width,
    required this.height,    
    required this.dish,
    required this.args
  });

  @override
  State<StackImageWidget> createState() => _StackImageWidgetState();
}

class _StackImageWidgetState extends State<StackImageWidget> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool> (
      future: _inFavorites(DishModel(
        name: widget.dish[0].name,
        imageUrl: widget.dish[0].imageUrl,
        description:widget.args["description"],
        rating: widget.dish[0].rating.replaceAll('\n', '').replaceAll(" ", ""),
        cookingTime: widget.args["time"],
        recipeLink: widget.args["recipeLink"],
        date: widget.dish[0].date,
      )),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
      
      final inFavorites = snapshot.data ?? false;
      return Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: widget.height * .02),
            child: Center(
              child: Container(
                width: widget.width * .89,
                height: widget.width * .6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(
                        widget.dish[0].imageUrl),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: widget.width*.05,
            top: widget.height*.02,
            child:InkWell(
              onTap: () async{
                await writeDishToFavorites(widget.dish[0].rating.replaceAll('\n', '').replaceAll(" ", ""), context); 
              },
              child:Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                padding: const EdgeInsets.all(3),
                child:Row(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Image.network(!inFavorites?"https://cdn-icons-png.flaticon.com/512/4340/4340223.png":"https://cdn-icons-png.flaticon.com/512/5644/5644698.png", width: widget.width*.07,),
                  ) ,
            ],
            ),))
        ),
          Positioned(
            right: 0,
            bottom: -1,
            child:Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(45)),
              ),
              padding: const EdgeInsets.all(3),
              child:Row(
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child:Padding(
                    padding: const EdgeInsets.only(left: 9,right: 5),
                    child: Image.network("https://cdn-icons-png.flaticon.com/512/9736/9736173.png", width: widget.width*.074,),
                )) ,
                Align(
                  alignment: Alignment.bottomRight,
                  child:Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(widget.dish[0].cookingTime,textAlign: TextAlign.left,style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0),fontSize: widget.width*.035,fontWeight: FontWeight.w700),overflow: TextOverflow.ellipsis, maxLines: 1,),
                )),
              ],
              ),)
            )
        ],
      );
    }
    );
    }

  Future<void> writeDishToFavorites(String rate, BuildContext context) async {
    var box=GetIt.I<Box<DishModel>>();
    final dish_ = DishModel(
        name: widget.dish[0].name,
        imageUrl: widget.dish[0].imageUrl,
        description: widget.args["description"],
        rating: widget.dish[0].rating.replaceAll('\n', '').replaceAll(" ", ""),
        cookingTime: widget.args["time"],
        recipeLink: widget.args["recipeLink"],
        date: widget.dish[0].date,
      );
    if(!await DishFavoritesRepository().isDishInFavorites(dish_)){
      await box.add(dish_);
    }
    else{
      for (var key in box.keys) {
        var dish = box.get(key);
        if (dish!.name == dish.name) {
          await box.delete(key); // Удаляем элемент по ключу
          break; // Завершаем цикл после удаления
        }
      }
    }
    setState(() {
      
    });
  }

  Future<bool> _inFavorites(DishModel dish) async {
    return DishFavoritesRepository().isDishInFavorites(dish);
  }
}