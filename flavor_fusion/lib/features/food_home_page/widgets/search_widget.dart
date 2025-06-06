import 'package:flutter/cupertino.dart';
class SearchWidget extends StatelessWidget {
  final EdgeInsets padding;
  final double borderRadius;
  const SearchWidget({super.key, 
    required this.padding,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: CupertinoSearchTextField(
        controller: TextEditingController(text: ""),
        placeholder: "Поиск...",
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        onSubmitted: (String value){
          Navigator.of(context).pushNamed("/search",arguments: {'query':value});
        },
    ),     
    );
  }
}