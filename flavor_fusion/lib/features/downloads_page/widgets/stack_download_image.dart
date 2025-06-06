import 'dart:convert';

import 'package:flavor_fusion/repositories/dish_favorites_repository/dish_favorites_repository.dart';
import 'package:flavor_fusion/repositories/dish_item/models/dish_downloads_model.dart';
import 'package:flavor_fusion/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';

class StackDownloadWidget extends StatefulWidget {
  final double width;
  final double height;
  final DishDownloadModel dish;
  final args;

  const StackDownloadWidget({super.key, 
    required this.width,
    required this.height,    
    required this.dish,
    required this.args
  });

  @override
  State<StackDownloadWidget> createState() => _StackDownloadWidgetState();
}

class _StackDownloadWidgetState extends State<StackDownloadWidget> {

  @override
  Widget build(BuildContext context) {
    return Builder (
      
      builder: (context) {
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
                    image: MemoryImage(base64Decode(widget.dish.image)),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
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
                    child: Text(widget.dish.cookingTime,textAlign: TextAlign.left,style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0),fontSize: widget.width*.035,fontWeight: FontWeight.w700),overflow: TextOverflow.ellipsis, maxLines: 1,),
                )),
              ],
              ),)
            )
        ],
      );
    }
    );
    }

  
}