import 'dart:convert';

class ProductResponseModel {
  List<Product>? data;

  ProductResponseModel({
    this.data,
  });

  factory ProductResponseModel.fromJson(String str) =>
      ProductResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductResponseModel.fromMap(Map<String, dynamic> json) =>
      ProductResponseModel(
        data: json["data"] == null
            ? []
            : List<Product>.from(json["data"]!.map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Product {
  int? id;
  String? type;
  String? model;
  String? brand;
  int? range;
  int? powerMotor;
  String? battery;
  double? wheelSize;
  String? wheelType;
  double? maxLoad;
  double? topSpeed;
  String? waterproof;
  double? weight;
  String? bracketType;
  int? price;
  String? imageProduct;
  double? rating;
  User? user;
  Category? category;

  Product({
    this.id,
    this.type,
    this.model,
    this.brand,
    this.range,
    this.powerMotor,
    this.battery,
    this.wheelSize,
    this.wheelType,
    this.maxLoad,
    this.topSpeed,
    this.waterproof,
    this.weight,
    this.bracketType,
    this.price,
    this.imageProduct,
    this.rating,
    this.user,
    this.category,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        type: json["type"],
        model: json["model"],
        brand: json["brand"],
        range: json["range"],
        powerMotor: json["powerMotor"],
        battery: json["battery"],
        wheelSize: json["wheelSize"]?.toDouble(),
        wheelType: json["wheelType"],
        maxLoad: json["maxLoad"]?.toDouble(),
        topSpeed: json["topSpeed"]?.toDouble(),
        waterproof: json["Waterproof"],
        weight: json["Weight"]?.toDouble(),
        bracketType: json["bracketType"],
        price: json["price"],
        imageProduct: json["imageProduct"],
        rating: json["rating"]?.toDouble(),
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        category: json["category"] == null
            ? null
            : Category.fromMap(json["category"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "model": model,
        "brand": brand,
        "range": range,
        "powerMotor": powerMotor,
        "battery": battery,
        "wheelSize": wheelSize,
        "wheelType": wheelType,
        "maxLoad": maxLoad,
        "topSpeed": topSpeed,
        "Waterproof": waterproof,
        "Weight": weight,
        "bracketType": bracketType,
        "price": price,
        "imageProduct": imageProduct,
        "rating": rating,
        "user": user?.toMap(),
        "category": category?.toMap(),
      };
}

class Category {
  int? id;
  String? name;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  Category({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class User {
  int? id;
  String? name;
  String? role;

  User({
    this.id,
    this.name,
    this.role,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        role: json["role"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "role": role,
      };
}
