

// class UniServices{
//   static String _query='';
//   static String get query => _query;
//   static bool get hasQuery => _query.isNotEmpty;
//   static void reset() => _query="";

//   static  uniHandler(Uri? uri){
//     if(uri == null || uri.queryParameters.isEmpty){
//       return;
//     }
//     Map<String,dynamic> param = uri.queryParameters;
//     String recivedQuery = param["query"] ?? "apple";
//     ContextUtility.navigator!.pushNamed("/search",arguments: {"query": recivedQuery});
//   }
//   static init() async {
//     try{
//       final Uri? uri = await getInitialUri();
//       uniHandler(uri);
//     } on PlatformException catch (e){
//       debugPrint("Falied to recive query");
//     } on FormatException catch (e){
//       debugPrint("Wrong format query recived");
//     }

//     uriLinkStream.listen((Uri? uri){
//       uniHandler(uri);
//     },onError: (error) => debugPrint(error));
//   }
// }