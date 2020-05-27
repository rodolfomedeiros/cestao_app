import 'package:flutter/material.dart';

void main() {
  runApp(CestaoApp());
}

class CestaoApp extends StatelessWidget {
  var routes = <String, WidgetBuilder>{
    SearchView.routeName: (context) => SearchView(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cestão App",
      theme: ThemeData(
        primaryColor: Colors.orange,
      ),
      home: SearchView(),
      routes: routes,
    );
  }
}

class SearchView extends StatefulWidget {
  SearchView({Key key, this.title}) : super(key: key);

  static const String routeName = "/search";

  final String title;

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final searchFieldController = TextEditingController();

  @override
  void dispose() {
    searchFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search View'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                style: TextStyle(fontSize: 20.0),
                controller: searchFieldController,
              ),
              RaisedButton(
                onPressed: () {},
                child: Text(
                  'Buscar',
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                ),
                color: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
