// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// class ProductResponseModel {
//   List<Product>? data;
//   Links? links;
//   Meta? meta;

//   ProductResponseModel({
//     this.data,
//     this.links,
//     this.meta,
//   });

//   factory ProductResponseModel.fromJson(String str) =>
//       ProductResponseModel.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory ProductResponseModel.fromMap(Map<String, dynamic> json) =>
//       ProductResponseModel(
//         data: json["data"] == null
//             ? []
//             : List<Product>.from(json["data"]!.map((x) => Product.fromMap(x))),
//         links: json["links"] == null ? null : Links.fromMap(json["links"]),
//         meta: json["meta"] == null ? null : Meta.fromMap(json["meta"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "data":
//             data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
//         "links": links?.toMap(),
//         "meta": meta?.toMap(),
//       };
// }

// class Product {
//   int? id;
//   String? type;
//   String? model;
//   String? brand;
//   int? range;
//   int? powerMotor;
//   String? battery;
//   double? wheelSize;
//   String? wheelType;
//   double? maxLoad;
//   double? topSpeed;
//   String? waterproof;
//   double? weight;
//   String? bracketType;
//   int? price;
//   double? rating;
//   String? imageProduct;

//   Product({
//     this.id,
//     this.type,
//     this.model,
//     this.brand,
//     this.range,
//     this.powerMotor,
//     this.battery,
//     this.wheelSize,
//     this.wheelType,
//     this.maxLoad,
//     this.topSpeed,
//     this.waterproof,
//     this.weight,
//     this.bracketType,
//     this.price,
//     this.rating,
//     this.imageProduct,
//   });

//   factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory Product.fromMap(Map<String, dynamic> json) => Product(
//         id: json["id"],
//         type: json["type"],
//         model: json["model"],
//         brand: json["brand"],
//         range: json["range"],
//         powerMotor: json["powerMotor"],
//         battery: json["battery"],
//         wheelSize: json["wheelSize"]?.toDouble(),
//         wheelType: json["wheelType"],
//         maxLoad: json["maxLoad"]?.toDouble(),
//         topSpeed: json["topSpeed"]?.toDouble(),
//         waterproof: json["Waterproof"],
//         weight: json["Weight"]?.toDouble(),
//         bracketType: json["bracketType"],
//         price: json["price"],
//         rating: json["rating"]?.toDouble(),
//         imageProduct: json["imageProduct"],
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "type": type,
//         "model": model,
//         "brand": brand,
//         "range": range,
//         "powerMotor": powerMotor,
//         "battery": battery,
//         "wheelSize": wheelSize,
//         "wheelType": wheelType,
//         "maxLoad": maxLoad,
//         "topSpeed": topSpeed,
//         "Waterproof": waterproof,
//         "Weight": weight,
//         "bracketType": bracketType,
//         "price": price,
//         "rating": rating,
//         "imageProduct": imageProduct,
//       };

//   @override
//   bool operator ==(covariant Product other) {
//     if (identical(this, other)) return true;

//     return other.id == id &&
//         other.type == type &&
//         other.model == model &&
//         other.brand == brand &&
//         other.range == range &&
//         other.powerMotor == powerMotor &&
//         other.battery == battery &&
//         other.wheelSize == wheelSize &&
//         other.wheelType == wheelType &&
//         other.maxLoad == maxLoad &&
//         other.topSpeed == topSpeed &&
//         other.waterproof == waterproof &&
//         other.weight == weight &&
//         other.bracketType == bracketType &&
//         other.price == price &&
//         other.rating == rating &&
//         other.imageProduct == imageProduct;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//         type.hashCode ^
//         model.hashCode ^
//         brand.hashCode ^
//         range.hashCode ^
//         powerMotor.hashCode ^
//         battery.hashCode ^
//         wheelSize.hashCode ^
//         wheelType.hashCode ^
//         maxLoad.hashCode ^
//         topSpeed.hashCode ^
//         waterproof.hashCode ^
//         weight.hashCode ^
//         bracketType.hashCode ^
//         price.hashCode ^
//         rating.hashCode ^
//         imageProduct.hashCode;
//   }
// }

// class Links {
//   String? first;
//   String? last;
//   dynamic prev;
//   String? next;

//   Links({
//     this.first,
//     this.last,
//     this.prev,
//     this.next,
//   });

//   factory Links.fromJson(String str) => Links.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory Links.fromMap(Map<String, dynamic> json) => Links(
//         first: json["first"],
//         last: json["last"],
//         prev: json["prev"],
//         next: json["next"],
//       );

//   Map<String, dynamic> toMap() => {
//         "first": first,
//         "last": last,
//         "prev": prev,
//         "next": next,
//       };
// }

// class Meta {
//   int? currentPage;
//   int? from;
//   int? lastPage;
//   List<Link>? links;
//   String? path;
//   int? perPage;
//   int? to;
//   int? total;

//   Meta({
//     this.currentPage,
//     this.from,
//     this.lastPage,
//     this.links,
//     this.path,
//     this.perPage,
//     this.to,
//     this.total,
//   });

//   factory Meta.fromJson(String str) => Meta.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory Meta.fromMap(Map<String, dynamic> json) => Meta(
//         currentPage: json["current_page"],
//         from: json["from"],
//         lastPage: json["last_page"],
//         links: json["links"] == null
//             ? []
//             : List<Link>.from(json["links"]!.map((x) => Link.fromMap(x))),
//         path: json["path"],
//         perPage: json["per_page"],
//         to: json["to"],
//         total: json["total"],
//       );

//   Map<String, dynamic> toMap() => {
//         "current_page": currentPage,
//         "from": from,
//         "last_page": lastPage,
//         "links": links == null
//             ? []
//             : List<dynamic>.from(links!.map((x) => x.toMap())),
//         "path": path,
//         "per_page": perPage,
//         "to": to,
//         "total": total,
//       };
// }

// class Link {
//   String? url;
//   String? label;
//   bool? active;

//   Link({
//     this.url,
//     this.label,
//     this.active,
//   });

//   factory Link.fromJson(String str) => Link.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory Link.fromMap(Map<String, dynamic> json) => Link(
//         url: json["url"],
//         label: json["label"],
//         active: json["active"],
//       );

//   Map<String, dynamic> toMap() => {
//         "url": url,
//         "label": label,
//         "active": active,
//       };
// }

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
