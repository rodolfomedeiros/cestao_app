import 'package:barcode_scan/barcode_scan.dart';
import 'package:cestao_app/models/Nfce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  int _bottomNavigatorIndexSelected = 0;

  bool _searchEmpty = true;
  bool _searchFail = false;
  bool _searchFinished = false;
  bool _searchLoading = false;
  bool _searchReturnEmpty = false;

  ScanResult _scanResult;
  String _resultKey = "";
  String _resultKeyReturn = "";
  ItemsSearchForm result = null;

  List<Widget> widgets = <Widget>[];

  @override
  void dispose() {
    searchFieldController?.dispose();
    super.dispose();
  }

  Future scan() async {
    try {
      var options = ScanOptions(
        restrictFormat: [BarcodeFormat.qr],
        useCamera: -1,
        autoEnableFlash: false,
        android: AndroidOptions(
          useAutoFocus: true,
        ),
      );

      var result = await BarcodeScanner.scan(options: options);

      setState(() => _scanResult = result);
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'The user did not grant the camera permission!';
        });
      } else {
        result.rawContent = 'Unknown error: $e';
      }
      setState(() {
        _scanResult = result;
      });
    }
  }

  void _searchAction() {
    setState(() {
      this._searchEmpty = false;
      this._searchLoading = true;
      this._searchFinished = false;
      this._searchFail = false;
      this._searchReturnEmpty = false;
      cestaoService.search(searchFieldController.text).then((value) {
        if (value.soldItemsByBusiness.length < 1) {
          setState(() {
            this._searchFail = false;
            this._searchLoading = false;
            this._searchFinished = false;
            this._searchReturnEmpty = true;
          });
        } else {
          this.setState(() {
            this.result = value;
            this._searchLoading = false;
            this._searchFail = false;
            this._searchFinished = true;
            this._searchReturnEmpty = false;
          });
        }
      }).catchError((error) {
        print(error);
      });
    });
  }

  void _bottomNavigatorTapped(int index) async {
    if (index == 1) {
      await scan();

      if (_scanResult.rawContent.isNotEmpty) {
        _resultKey = Nfce.fromRawContent(_scanResult.rawContent).key;

        cestaoService.nfceSend(_resultKey).then((value) => setState(() {
              _scanResult;
              _resultKey;
              _resultKeyReturn = value;
              _bottomNavigatorIndexSelected = index;
            }));
      }
    } else {
      setState(() => _bottomNavigatorIndexSelected = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    widgets.insert(0, _searchPage());
    widgets.insert(1, _qrCodeScannerPage());

    return Scaffold(
      appBar: AppBar(
        title: Text('Cestão App'),
      ),
      body: widgets.elementAt(_bottomNavigatorIndexSelected),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text("Buscar Produto")),
          BottomNavigationBarItem(
              icon: Icon(Icons.add), title: Text('Adicionar Nova Chave'))
        ],
        currentIndex: _bottomNavigatorIndexSelected,
        onTap: _bottomNavigatorTapped,
      ),
    );
  }

  Widget _searchPage() {
    return Column(children: <Widget>[
      if (_searchEmpty) _searchEmptyWidget('Nenhuma busca...'),
      if (_searchReturnEmpty)
        _searchEmptyWidget('Nenhum resultado para essa busca...'),
      if (_searchFinished) _listItemsByBusiness(result),
      if (_searchLoading) _loading(),
      _searchInput(),
    ]);
  }

  Widget _qrCodeScannerPage() {
    return Column(children: [
      Expanded(
          child: Container(
              alignment: Alignment.center,
              child: _resultKeyReturn.compareTo("CREATED") == 0
                  ? _qrCodeSaveKeyCreated()
                  : _qrCodeSaveKeyConflict()))
    ]);
  }

  Widget _qrCodeSaveKeyCreated() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.beenhere,
          color: Colors.greenAccent,
          size: 40.0,
        ),
        Text("Nova chave adicionada com sucesso!")
      ],
    );
  }

  Widget _qrCodeSaveKeyConflict() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.assignment_late,
          color: Colors.redAccent,
          size: 40.0,
        ),
        Text("Não foi possível adicionar a chave!"),
        Text("Pode ser que ela já tenha sido adicionada...")
      ],
    );
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
      initiallyExpanded: true,
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
