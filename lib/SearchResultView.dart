import 'package:cestao_app/models/SearchForm.dart';
import 'package:flutter/material.dart';

class SearchResultView extends StatefulWidget {
  SearchResultView({Key key, this.title}) : super(key: key);

  static const String routeName = "/search/result";

  final String title;

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResultView> {
  @override
  Widget build(BuildContext context) {
    final SearchForm searchForm = ModalRoute.of(context).settings.arguments;

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
