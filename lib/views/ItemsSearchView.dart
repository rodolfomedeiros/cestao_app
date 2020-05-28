import 'package:cestao_app/views/ItemsSearchResultView.dart';
import 'package:cestao_app/models/ItemsSearchForm.dart';
import 'package:flutter/material.dart';

class ItemsSearchView extends StatefulWidget {
  ItemsSearchView({Key key, this.title}) : super(key: key);

  static const String routeName = "/search";

  final String title;

  @override
  _ItemsSearchViewState createState() => _ItemsSearchViewState();
}

class _ItemsSearchViewState extends State<ItemsSearchView> {
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
                  Navigator.pushNamed(context, ItemsSearchResultView.routeName,
                      arguments:
                          ItemsSearchForm(query: searchFieldController.text));
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
