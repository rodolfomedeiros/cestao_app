import 'package:flutter/material.dart';

import 'package:cestao_app/models/ItemsSearchForm.dart';
import 'package:cestao_app/services/CestaoService.dart' as cestaoService;

class ItemsSearchResultView extends StatefulWidget {
  ItemsSearchResultView({Key key, this.title}) : super(key: key);

  static const String routeName = "/search-result";

  final String title;

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<ItemsSearchResultView> {
  String _query;
  ItemsSearchForm searchForm = ItemsSearchForm(query: null);

  void changeButtonQuery(String query) {
    setState(() {
      print(query);
      this._query = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    searchForm = ModalRoute.of(context).settings.arguments;

    this._query = this._query == null ? searchForm.query : this._query;

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Result View'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text(this._query),
          onPressed: () {},
        ),
      ),
    );
  }
}
