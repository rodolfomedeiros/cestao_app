import 'package:cestao_app/models/BusinessForm.dart';

class ItemsSearchForm {
  final String query;
  List<BusinessForm> soldItemsByBusiness;

  ItemsSearchForm({this.query, this.soldItemsByBusiness});

  factory ItemsSearchForm.fromJson(Map<String, dynamic> json) {
    ItemsSearchForm searchForm = ItemsSearchForm(
        query: json['query'], soldItemsByBusiness: List<BusinessForm>());

    List.from(json['soldItemsByBusiness']).forEach((value) =>
        searchForm.soldItemsByBusiness.add(BusinessForm.fromJson(value)));

    return searchForm;
  }

  factory ItemsSearchForm.getEmpty(String query) {
    return ItemsSearchForm(query: query, soldItemsByBusiness: <BusinessForm>[]);
  }
}
