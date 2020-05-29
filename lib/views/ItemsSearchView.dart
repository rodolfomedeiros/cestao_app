import 'package:cestao_app/views/ItemsSearchResultView.dart';
import 'package:cestao_app/models/ItemsSearchForm.dart';
import 'package:flutter/material.dart';

import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';

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
      body: Container(
        padding: EdgeInsets.all(20.0),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Loading(
                    indicator: BallSpinFadeLoaderIndicator(),
                    color: Theme.of(context).primaryColor,
                    size: 100.0)
              ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                  child: TextField(
                style: TextStyle(fontSize: 20.0),
                controller: searchFieldController,
              )),
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
          )
        ]),
      ),
    );
  }
}
