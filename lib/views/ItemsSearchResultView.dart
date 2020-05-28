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
  @override
  Widget build(BuildContext context) {
    ItemsSearchForm searchForm = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Result View'),
      ),
      body: Center(
        child: Text(searchForm.query),
      ),
    );
  }
}
