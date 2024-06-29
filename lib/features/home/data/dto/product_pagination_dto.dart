import 'package:json_annotation/json_annotation.dart';
import 'package:liquor_ordering_system/features/home/data/model/product_api_model.dart';

part 'pagination_dto.g.dart';

@JsonSerializable()
class ProductPaginationDto {
  final bool success;
  final String message;
  final List<ProductApiModel> products;

  ProductPaginationDto({
    required this.success,
    required this.message,
    required this.products,
  });

  Map<String, dynamic> toJson() => _$PaginationDtoToJson(this);

  factory ProductPaginationDto.fromJson(Map<String, dynamic> json) =>
      _$PaginationDtoFromJson(json);
}
