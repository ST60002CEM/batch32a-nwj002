import 'package:liquor_ordering_system/features/home/data/model/product_api_model.dart';

class ProductState {
  final List<ProductModel> product;
  final bool hasReachedMax;
  final int page;
  final bool isLoading;

  ProductState({
    required this.product,
    required this.hasReachedMax,
    required this.page,
    required this.isLoading,
  });

  factory ProductState.initial() {
    return ProductState(
      product: [],
      hasReachedMax: false,
      page: 0,
      isLoading: false,
    );
  }

  ProductState copyWith({
    List<ProductModel>? products,
    bool? hasReachedMax,
    int? page,
    bool? isLoading,
  }) {
    return ProductState(
      product: product,
      // comments: comments ?? this.comments,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
