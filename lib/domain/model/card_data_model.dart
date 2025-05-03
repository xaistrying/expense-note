import 'dart:convert';

class CardDataModel {
  String? id;
  String? name;
  num? price;
  num? times;

  CardDataModel({this.id, this.name, this.price, this.times});

  CardDataModel copyWith({String? id, String? name, num? price, num? times}) =>
      CardDataModel(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        times: times ?? this.times,
      );

  factory CardDataModel.fromRawJson(String str) =>
      CardDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CardDataModel.fromJson(Map<String, dynamic> json) => CardDataModel(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    times: json["times"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "times": times,
  };
}
