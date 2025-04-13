import 'dart:convert';

class CardDataModel {
  String? name;
  num? price;
  num? times;

  CardDataModel({this.name, this.price, this.times});

  CardDataModel copyWith({String? name, num? price, num? times}) =>
      CardDataModel(
        name: name ?? this.name,
        price: price ?? this.price,
        times: times ?? this.times,
      );

  factory CardDataModel.fromRawJson(String str) =>
      CardDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CardDataModel.fromJson(Map<String, dynamic> json) => CardDataModel(
    name: json["name"],
    price: json["price"],
    times: json["times"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "times": times,
  };
}
