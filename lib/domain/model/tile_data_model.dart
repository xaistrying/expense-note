import 'dart:convert';

class TileDataModel {
  String? name;
  num? price;
  num? times;

  TileDataModel({this.name, this.price, this.times});

  TileDataModel copyWith({String? name, num? price, num? times}) =>
      TileDataModel(
        name: name ?? this.name,
        price: price ?? this.price,
        times: times ?? this.times,
      );

  factory TileDataModel.fromRawJson(String str) =>
      TileDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TileDataModel.fromJson(Map<String, dynamic> json) => TileDataModel(
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
