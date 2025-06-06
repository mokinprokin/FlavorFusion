import 'package:flavor_fusion/router/router.dart';
import 'package:flavor_fusion/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

class FoodApp extends StatefulWidget {
  const FoodApp({super.key});

  @override
  State<FoodApp> createState() => _FoodAppState();
}

late String initialRoute;

class _FoodAppState extends State<FoodApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flavor Fusion',
        theme: theme,
        initialRoute: '/',
        navigatorKey: navigatorKey,
        routes: routes);
  }
}

class UniServices {
  static String _query = '';
  static String get query => _query;
  static bool get hasQuery => _query.isNotEmpty;
  static void reset() => _query = "";

  static uniHandler(Uri? uri) {
    if (uri == null || uri.queryParameters.isEmpty) {
      initialRoute = "/";
      return;
    }
    Map<String, dynamic> param = uri.queryParameters;
    String recivedQuery = param["query"];
    _query = recivedQuery;
    initialRoute = "/search";
  }

  static init() async {
    try {
      final Uri? uri = await getInitialUri();
      uniHandler(uri);
    } on PlatformException {
      debugPrint("Falied to recive query");
      initialRoute = "/";
    } on FormatException {
      debugPrint("Wrong format query recived");
      initialRoute = "/";
    }

    uriLinkStream.listen((Uri? uri) {
      uniHandler(uri);
    }, onError: (error) => initialRoute = "/");
  }
}
