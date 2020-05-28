import 'dart:convert';

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
    final ItemsSearchForm searchForm =
        ModalRoute.of(context).settings.arguments;

    // cestaoService.search(searchForm).then((value) =>
    //     value.soldItemsByBusiness.forEach((element) => print(element)));

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
