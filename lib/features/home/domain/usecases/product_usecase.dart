import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/core/failure/failure.dart';
import 'package:liquor_ordering_system/features/home/domain/entity/product_entity.dart';
import 'package:liquor_ordering_system/features/home/domain/repository/i_product_repository.dart';

final productUsecaseProvider = Provider<ProductUsecase>((ref) {
  final productRepository = ref.watch(productRepositoryProvider);
  return ProductUsecase(productRepository: productRepository);
});

class ProductUsecase {
  final IProductRepository productRepository;

  ProductUsecase({required this.productRepository});

  Future<Either<Failure, List<ProductEntity>>> pagination(int page, int limit)  {
    return  productRepository.pagination(page, limit);
  }
}
