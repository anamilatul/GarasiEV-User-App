import 'dart:convert';

class MyOrderResponseModel {
  final List<Order> data;

  MyOrderResponseModel({
    required this.data,
  });

  factory MyOrderResponseModel.fromJson(String str) =>
      MyOrderResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyOrderResponseModel.fromMap(Map<String, dynamic> json) =>
      MyOrderResponseModel(
        data: List<Order>.from(json["data"].map((x) => Order.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Order {
  final int id;
  final int userId;
  final int sellerId;
  final String number;
  final String totalPrice;
  final String paymentStatus;
  final String paymentUrl;
  final String deliveryAddress;
  final String orderStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<OrderItem> orderItems;

  Order({
    required this.id,
    required this.userId,
    required this.sellerId,
    required this.number,
    required this.totalPrice,
    required this.paymentStatus,
    required this.paymentUrl,
    required this.deliveryAddress,
    required this.orderStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.orderItems,
  });

  factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        id: json["id"],
        userId: json["user_id"],
        sellerId: json["seller_id"],
        number: json["number"],
        totalPrice: json["total_price"],
        paymentStatus: json["payment_status"],
        paymentUrl: json["payment_url"],
        deliveryAddress: json["delivery_address"],
        orderStatus: json["order_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        orderItems: List<OrderItem>.from(
            json["order_items"].map((x) => OrderItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "seller_id": sellerId,
        "number": number,
        "total_price": totalPrice,
        "payment_status": paymentStatus,
        "payment_url": paymentUrl,
        "delivery_address": deliveryAddress,
        "order_status": orderStatus,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "order_items": List<dynamic>.from(orderItems.map((x) => x.toMap())),
      };
}

class OrderItem {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Product product;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  factory OrderItem.fromJson(String str) => OrderItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderItem.fromMap(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        product: Product.fromMap(json["product"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "quantity": quantity,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "product": product.toMap(),
      };
}

class Product {
  final int id;
  final String imageUrl;
  final String type;
  final String model;
  final String brand;
  final int price;

  Product({
    required this.id,
    required this.imageUrl,
    required this.type,
    required this.model,
    required this.brand,
    required this.price,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        imageUrl: json["image_url"],
        type: json["type"],
        model: json["model"],
        brand: json["brand"],
        price: json["price"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "image_url": imageUrl,
        "type": type,
        "model": model,
        "brand": brand,
        "price": price,
      };
}
