// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_pagination_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductPaginationDto _$ProductPaginationDtoFromJson(
        Map<String, dynamic> json) =>
    ProductPaginationDto(
      success: json['success'] as bool,
      message: json['message'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductPaginationDtoToJson(
        ProductPaginationDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'products': instance.products,
    };
