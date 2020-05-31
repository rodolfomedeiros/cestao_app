import 'package:flutter/material.dart';

import 'package:cestao_app/pages/ItemsSearchPage.dart';

void main() {
  runApp(CestaoApp());
}

class CestaoApp extends StatelessWidget {
  var routes = <String, WidgetBuilder>{
    ItemsSearchPage.routeName: (context) => ItemsSearchPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cestão App",
      theme: ThemeData(
        primaryColor: Colors.orange[300],
      ),
      home: ItemsSearchPage(),
      routes: routes,
    );
  }
}
