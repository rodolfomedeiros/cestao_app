class LastSingleSoldItemForm {
  final int id;
  final String resume;
  final double price;
  final String unitType;
  final String dateTime;

  LastSingleSoldItemForm(
      {this.id, this.resume, this.price, this.unitType, this.dateTime});

  factory LastSingleSoldItemForm.fromJson(Map<String, dynamic> json) {
    return LastSingleSoldItemForm(
      id: json['id'],
      resume: json['resume'],
      price: json['price'],
      unitType: json['unitType'],
      dateTime: json['dateTime'],
    );
  }
}
