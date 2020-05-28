import 'package:cestao_app/views/ItemsSearchResultView.dart';
import 'package:cestao_app/views/ItemsSearchView.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CestaoApp());
}

class CestaoApp extends StatelessWidget {
  var routes = <String, WidgetBuilder>{
    ItemsSearchView.routeName: (context) => ItemsSearchView(),
    ItemsSearchResultView.routeName: (context) => ItemsSearchResultView(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cestão App",
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: ItemsSearchView(),
      routes: routes,
    );
  }
}
