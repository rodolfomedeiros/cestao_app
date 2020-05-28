import 'package:cestao_app/models/LastSingleSoldItemForm.dart';

class BusinessForm {
  final String cnpj;
  final String name;
  final String address;
  final String phone;

  final List<LastSingleSoldItemForm> lastSingleSoldItems;

  BusinessForm(
      {this.cnpj,
      this.name,
      this.address,
      this.phone,
      this.lastSingleSoldItems});

  factory BusinessForm.fromJson(Map<String, dynamic> json) {
    BusinessForm businessForm = BusinessForm(
        cnpj: json['cnpj'],
        name: json['name'],
        address: json['address'],
        phone: json['phone'],
        lastSingleSoldItems: List<LastSingleSoldItemForm>());

    List.from(json['lastSingleSoldItems']).forEach((value) => businessForm
        .lastSingleSoldItems
        .add(LastSingleSoldItemForm.fromJson(value)));

    return businessForm;
  }
}
