import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cestao_app/models/ItemsSearchForm.dart';

const urlCestaoBackend = 'http://192.168.0.107:8080/cestao';

Future<ItemsSearchForm> search(ItemsSearchForm search) async {
  final response = await http.get(urlCestaoBackend + '?query=${search.query}');

  if (response.statusCode == 200) {
    return ItemsSearchForm.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('search failed');
  }
}

Future<ItemsSearchForm> searchDefault(ItemsSearchForm search) {
  return Future.delayed(
      Duration(seconds: 3), () => ItemsSearchForm(query: 'teste'));
}
