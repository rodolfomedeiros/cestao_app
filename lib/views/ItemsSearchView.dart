import 'package:cestao_app/models/BusinessForm.dart';
import 'package:cestao_app/models/LastSingleSoldItemForm.dart';
import 'package:flutter/material.dart';

import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

import 'package:cestao_app/models/ItemsSearchForm.dart';
import 'package:cestao_app/services/CestaoService.dart' as cestaoService;

class ItemsSearchView extends StatefulWidget {
  ItemsSearchView({Key key, this.title}) : super(key: key);

  static const String routeName = "/search";

  final String title;

  @override
  _ItemsSearchViewState createState() => _ItemsSearchViewState();
}

class _ItemsSearchViewState extends State<ItemsSearchView> {
  final searchFieldController = TextEditingController();

  bool _searchFinished = false;
  ItemsSearchForm result = null;

  void _searchAction() {
    cestaoService.search(searchFieldController.text).then((value) => {
          this.setState(() {
            this.result = value;
            this._searchFinished = true;
          })
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
          !_searchFinished ? _loading() : _listItemsByBusiness(result),
          _searchAndButton(),
        ]));
  }

  Widget _searchAndButton() {
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
