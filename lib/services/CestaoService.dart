import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:cestao_app/models/ItemsSearchForm.dart';

const URL_CESTAO_BACKEND = String.fromEnvironment('URL_CESTAO_BACKEND');
const urlCestaoController = URL_CESTAO_BACKEND + '/cestao';
const urlNfceController = URL_CESTAO_BACKEND + '/nfce';

Future<ItemsSearchForm> search(String query) async {
  try {
    final response = await http.get(urlCestaoController + '?query=$query');

    if (response.statusCode == 200) {
      return ItemsSearchForm.fromJson(jsonDecode(response.body));
    } else {
      return Future<ItemsSearchForm>.error(
          "server failed: " + response.statusCode.toString());
    }
  } catch (error) {
    return Future<ItemsSearchForm>.error(error);
  }
}

Future nfceSend(String key) async {
  try {
    final response = await http.get(urlNfceController + '/$key');

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return Future.error("server failed: " + response.statusCode.toString());
    }
  } on SocketException catch (error) {
    return Future.error(error.toString());
  }
}

Future<ItemsSearchForm> searchDefault(String search) {
  return Future.microtask(() => ItemsSearchForm.fromJson({
        "query": "all",
        "soldItemsByBusiness": [
          {
            "cnpj": "10.670.811/0010-44",
            "name": "Hiper Queiroz Ltda",
            "address": "RUA JOAO PESSOA, 836, CENTRO, ASSU, RN, 59650-000",
            "phone": null,
            "lastSingleSoldItems": [
              {
                "id": 5,
                "resume": "SALG PIPPOS CHURRASCO 200G",
                "price": 5.29,
                "unitType": "UN",
                "dateTime": "03/02/2020 20:00:16"
              },
              {
                "id": 7,
                "resume": "CHOC EM PO PREDILECTA 200G",
                "price": 5.98,
                "unitType": "UN",
                "dateTime": "03/02/2020 20:00:16"
              },
              {
                "id": 9,
                "resume": "LEITE COND PIRACANJUBA 395G",
                "price": 3.29,
                "unitType": "UN",
                "dateTime": "03/02/2020 20:00:16"
              },
              {
                "id": 11,
                "resume": "BISC C CRACKER FORTALEZA 400G TRADICIONA",
                "price": 3.68,
                "unitType": "UN",
                "dateTime": "03/02/2020 20:00:16"
              },
              {
                "id": 13,
                "resume": "CREME LEITE ITALAC 200G",
                "price": 1.69,
                "unitType": "UN",
                "dateTime": "03/02/2020 20:00:16"
              },
              {
                "id": 15,
                "resume": "CEREAL BARRA RITTER 25G LIGHT CASTANHA P",
                "price": 1.49,
                "unitType": "UN",
                "dateTime": "03/02/2020 20:00:16"
              },
              {
                "id": 17,
                "resume": "PAO SAO FRANCISCO KG FORMA",
                "price": 9.49,
                "unitType": "KG",
                "dateTime": "03/02/2020 20:00:16"
              },
              {
                "id": 19,
                "resume": "QUEIJO NATVILLE KG MUSSARELA",
                "price": 21.88,
                "unitType": "KG",
                "dateTime": "03/02/2020 20:00:16"
              },
              {
                "id": 21,
                "resume": "PRESUNTO SEARA KG MAGRO OVAL COZIDO",
                "price": 18.98,
                "unitType": "KG",
                "dateTime": "03/02/2020 20:00:16"
              },
              {
                "id": 23,
                "resume": "BISC MAIZENA FORTALEZA 400G TRAD",
                "price": 4.69,
                "unitType": "UN",
                "dateTime": "03/02/2020 20:00:16"
              }
            ]
          }
        ]
      }));
}
