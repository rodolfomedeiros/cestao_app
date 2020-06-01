import 'package:flutter/material.dart';

import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

import 'package:cestao_app/models/BusinessForm.dart';
import 'package:cestao_app/models/LastSingleSoldItemForm.dart';
import 'package:cestao_app/models/ItemsSearchForm.dart';
import 'package:cestao_app/services/CestaoService.dart' as cestaoService;

class ItemsSearchPage extends StatefulWidget {
  ItemsSearchPage({Key key, this.title}) : super(key: key);

  static const String routeName = "/search";

  final String title;

  @override
  _ItemsSearchPageState createState() => _ItemsSearchPageState();
}

class _ItemsSearchPageState extends State<ItemsSearchPage> {
  final searchFieldController = TextEditingController();

  bool _searchEmpty = true;
  bool _searchFail = false;
  bool _searchFinished = false;
  bool _searchLoading = false;

  ItemsSearchForm result = null;

  void _searchAction() {
    setState(() {
      this._searchEmpty = false;
      this._searchLoading = true;
      this._searchFinished = false;
      this._searchFail = false;
      cestaoService.search(searchFieldController.text).then((value) {
        if (value.soldItemsByBusiness.length < 1) {
          setState(() {
            this._searchFail = true;
            this._searchLoading = false;
            this._searchFinished = false;
          });
        } else {
          this.setState(() {
            this.result = value;
            this._searchLoading = false;
            this._searchFail = false;
            this._searchFinished = true;
          });
        }
      }).catchError((error) {
        print(error);
      });
    });
  }

  @override
  void dispose() {
    searchFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Buscar Produto'),
        ),
        body: Column(children: <Widget>[
          if (_searchEmpty) _searchEmptyWidget('Nenhuma busca...'),
          if (_searchFail)
            _searchEmptyWidget('Nenhum resultado para essa busca...'),
          if (_searchFinished) _listItemsByBusiness(result),
          if (_searchLoading) _loading(),
          _searchInput(),
        ]));
  }

  Widget _searchInput() {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Expanded(
                child: TextField(
              autofocus: true,
              decoration:
                  InputDecoration(hintText: 'digite o nome e aperte Enter'),
              onSubmitted: (value) => _searchAction(),
              style: TextStyle(fontSize: 20.0),
              controller: searchFieldController,
            )),
          ],
        ));
  }

  Widget _loading() {
    return Expanded(
        child: Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Loading(
                indicator: BallPulseIndicator(),
                color: Theme.of(context).primaryColor,
                size: 70.0)
          ]),
    ));
  }

  Widget _searchEmptyWidget(String msg) {
    return Expanded(
        child: Container(
      alignment: Alignment.center,
      child: Text(
        msg,
        style: TextStyle(color: Colors.grey),
      ),
    ));
  }

  Widget _listItemsByBusiness(ItemsSearchForm result) {
    return Expanded(
        child: ListView.separated(
            padding: const EdgeInsets.all(10.0),
            itemCount: result.soldItemsByBusiness.length,
            separatorBuilder: (context, i) => Divider(),
            itemBuilder: (context, i) =>
                _buildBusinessRow(result.soldItemsByBusiness[i])));
  }

  Widget _buildBusinessRow(BusinessForm business) {
    return ExpansionTile(
      title: Text(business.name),
      initiallyExpanded: false,
      children: business.lastSingleSoldItems.map(_buildItemsRow).toList(),
    );
  }

  Widget _buildItemsRow(LastSingleSoldItemForm lastSingleSoldItemForm) {
    return ListTile(
      title: Text(lastSingleSoldItemForm.resume),
      subtitle: Text('Inserido: ${lastSingleSoldItemForm.dateTime}'),
      trailing: Text(lastSingleSoldItemForm.price.toString()),
    );
  }
}
