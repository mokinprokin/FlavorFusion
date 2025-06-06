import 'package:flavor_fusion/repositories/dish_favorites_repository/dish_favorites_repository.dart';
import 'package:flavor_fusion/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
class PopularItemTile extends StatefulWidget {
  final double width;
  final double height;
  final String time;
  final String name;
  final String rating;
  final String description;
  final String date;
  final String imageUrl;
  final String recipeLink;
  final double leftMargin;
  final double rightMargin;

  const PopularItemTile({super.key, 
    required this.width,
    required this.height,    
    required this.name,
    required this.rating,
    required this.description,
    required this.date,
    required this.time,
    required this.imageUrl,
    required this.recipeLink,
    required this.leftMargin,
    required this.rightMargin,
  });

  @override
  State<PopularItemTile> createState() => _PopularItemTileState();
}

class _PopularItemTileState extends State<PopularItemTile> {
  @override
  Widget build(BuildContext context) {
    final rate=widget.rating.replaceAll('\n','').replaceAll(" ", "");
    return FutureBuilder<bool> (
      future: _inFavorites(DishModel(
        name: widget.name,
        imageUrl: widget.imageUrl,
        description: widget.description,
        rating: widget.rating.replaceAll('\n', '').replaceAll(" ", ""),
        cookingTime: widget.time,
        recipeLink: widget.recipeLink,
        date: widget.date,
      )),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
      
      final inFavorites = snapshot.data ?? false;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed("/dish",arguments: {
          'name':widget.name,
          'description':widget.description,
          'time': widget.time,
          'rate':widget.rating,
          'date':widget.date,
          'recipeLink':widget.recipeLink,
        });
      },
      child: Container(
        width: widget.width,
        height: widget.height/.32>590 ? widget.height:widget.height*.9,
        margin: EdgeInsets.only(top: 12, bottom: widget.height/.32>625?widget.height*.1:widget.height*.04, left: widget.leftMargin, right: widget.rightMargin),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(54, 65, 65, 65).withOpacity(0.5),
              spreadRadius: .5,
              blurRadius: 6,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          
          children: [
            Stack(
              children:[
                Container(
                  width: widget.width,
                  height: widget.height/.32>590 ? widget.height*.5:widget.height*.4, 
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.imageUrl),
                      fit: BoxFit.fill, 
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child:InkWell(
                    onTap: () async{
                      await writeDishToFavorites(rate, context);                      
                    },
                    child:Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      padding: const EdgeInsets.all(2),
                      margin: const EdgeInsets.all(3),
                      child:Row(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Image.network(!inFavorites?"https://cdn-icons-png.flaticon.com/512/4340/4340223.png":"https://cdn-icons-png.flaticon.com/512/5644/5644698.png", width: widget.width*.11,),
                        ) ,
                  ],
                  ),))
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child:Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
                    ),
                    padding: const EdgeInsets.all(4),
                    child:Row(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child:Padding(
                          padding: const EdgeInsets.only(left: 5,right: 5),
                          child: Image.network("https://cdn-icons-png.flaticon.com/512/1828/1828884.png", width: widget.height*.08,),
                      )) ,
                      Align(
                        alignment: Alignment.bottomRight,
                        child:Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Text(rate,textAlign: TextAlign.left,style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0),fontSize: widget.width*.085,fontWeight: FontWeight.w700),overflow: TextOverflow.ellipsis, maxLines: 1,),
                      )),
                    ],
                   ),)
                  )
              ]
            ),
            Padding(
              padding: EdgeInsets.only(left: 10,top: widget.height*.04,right: 10),
              child:Align(
                alignment: Alignment.centerLeft,
                child:
                  Text(widget.name,textAlign: TextAlign.left,style: TextStyle(color: Colors.black,fontSize: widget.width*.08,fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis, maxLines: 2,)       
            )),
            Row(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child:Padding(
                    padding: const EdgeInsets.only(left: 10,top: 10),
                    child: Image.network("https://cdn-icons-png.flaticon.com/512/9736/9736173.png", width: widget.height*.15,),
                )) ,
                Align(
                  alignment: Alignment.bottomCenter,
                  child:Padding(
                    padding: EdgeInsets.only(left: 5,top: widget.height*.05),
                    child: Text(widget.time,textAlign: TextAlign.left,style: TextStyle(color: const Color.fromARGB(186, 0, 0, 0),fontSize: widget.width*.085,fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis, maxLines: 1,),
                )),
              ],
            ),
          ],
        ),
      ),
    );}
    );
  }

    Future<void> writeDishToFavorites(String rate, BuildContext context) async {
    var box=GetIt.I<Box<DishModel>>();
    final dish = DishModel(name: widget.name, imageUrl: widget.imageUrl, description: widget.description, rating: rate, cookingTime: widget.time, recipeLink: widget.recipeLink, date: widget.date);
    if(!await DishFavoritesRepository().isDishInFavorites(dish)){
      await box.add(dish);
    }
    else{
      for (var key in box.keys) {
        var dish = box.get(key);
        if (dish!.name == widget.name) {
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