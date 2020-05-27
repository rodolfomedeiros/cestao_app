import 'package:cestao_app/SearchResultView.dart';
import 'package:cestao_app/SearchView.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CestaoApp());
}

class CestaoApp extends StatelessWidget {
  var routes = <String, WidgetBuilder>{
    SearchView.routeName: (context) => SearchView(),
    SearchResultView.routeName: (context) => SearchResultView(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cestão App",
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: SearchView(),
      routes: routes,
    );
  }
}
