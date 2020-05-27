import 'package:cestao_app/SearchResultView.dart';
import 'package:cestao_app/models/SearchForm.dart';
import 'package:flutter/material.dart';

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
                onPressed: () {
                  Navigator.pushNamed(context, SearchResultView.routeName,
                      arguments: SearchForm(searchFieldController.text));
                },
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
