// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProductResponseModel {
  final String? status;
  final List<Product>? data;

  ProductResponseModel({
    this.status,
    this.data,
  });

  factory ProductResponseModel.fromJson(String str) =>
      ProductResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductResponseModel.fromMap(Map<String, dynamic> json) =>
      ProductResponseModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Product>.from(json["data"]!.map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Product {
  final int? id;
  final int? categories_id;
  final String? name;
  final String? description;
  final String? image;
  final String? price;
  final int? stock;
  final int? status;
  final int? is_favorite;
  final DateTime? created_at;
  final DateTime? updated_at;
  final dynamic deleted_at;
  final Categories? categories;

  Product({
    this.id,
    this.categories_id,
    this.name,
    this.description,
    this.image,
    this.price,
    this.stock,
    this.status,
    this.is_favorite,
    this.created_at,
    this.updated_at,
    this.deleted_at,
    this.categories,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        categories_id: json["categories_id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
        stock: json["stock"],
        status: json["status"],
        is_favorite: json["is_favorite"],
        created_at: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updated_at: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deleted_at: json["deleted_at"],
        categories: json["categories"] == null
            ? null
            : Categories.fromMap(json["categories"]),
      );

  factory Product.fromLocalMap(Map<String, dynamic> json) => Product(
        id: json["products_id"],
        categories_id: json["categories_id"],
        categories: Categories(
            id: json["categories_id"], name: json["categories_name"]),
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
        stock: json["stock"],
        status: json["status"],
        is_favorite: json["is_favorite"],
        created_at: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updated_at: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deleted_at: json["deleted_at"],
      );

  Map<String, dynamic> toLocalMap() => {
        "products_id": id,
        "categories_id": categories_id,
        'categories_name': categories?.name,
        "name": name,
        "description": description,
        "image": image,
        "price": price,
        "stock": stock,
        "status": status,
        "is_favorite": is_favorite,
        "created_at": created_at?.toIso8601String(),
        "updated_at": updated_at?.toIso8601String(),
        "deleted_at": deleted_at,
      };
  Map<String, dynamic> toMap() => {
        "id": id,
        "categories_id": categories_id,
        "name": name,
        "description": description,
        "image": image,
        "price": price,
        "stock": stock,
        "status": status,
        "is_favorite": is_favorite,
        "created_at": created_at?.toIso8601String(),
        "updated_at": updated_at?.toIso8601String(),
        "deleted_at": deleted_at,
        "categories": categories?.toMap(),
      };

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.categories_id == categories_id &&
        other.name == name &&
        other.description == description &&
        other.image == image &&
        other.price == price &&
        other.stock == stock &&
        other.status == status &&
        other.is_favorite == is_favorite &&
        other.created_at == created_at &&
        other.updated_at == updated_at &&
        other.deleted_at == deleted_at &&
        other.categories == categories;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        categories_id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        image.hashCode ^
        price.hashCode ^
        stock.hashCode ^
        status.hashCode ^
        is_favorite.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode ^
        deleted_at.hashCode ^
        categories.hashCode;
  }
}

class Categories {
  final int? id;
  final String? name;
  final String? description;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  Categories({
    this.id,
    this.name,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Categories.fromJson(String str) =>
      Categories.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Categories.fromMap(Map<String, dynamic> json) => Categories(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
