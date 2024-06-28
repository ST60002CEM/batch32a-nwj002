import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comments.g.dart';

@JsonSerializable()
class Product extends Equatable {
  final String productName;
  final String productPrice;
  final String productImage;
  final String productDescription;
  final String productCategory;

  const Product({
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.productDescription,
    required this.productCategory,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object?> get props =>
      [productName, productPrice, productImage, productDescription];
}
