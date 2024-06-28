
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/core/failure/failure.dart';
import 'package:liquor_ordering_system/features/home/domain/entity/product_entity.dart';
import 'package:liquor_ordering_system/features/home/domain/repository/i_product_repository.dart';

final petRemoteRepository = Provider<IProductRepository>((ref) {
  final productRemoteDataSource = ref.watch(productRemoteDataSourceProvider);
  return PetRemoteRepository(petRemoteDataSource: productRemoteDataSource);
});

class PetRemoteRepository implements IProductRepository {
  final ProductRemoteDataSource petRemoteDataSource;

  PetRemoteRepository({required this.petRemoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> pagination(int page, int limit) {
    return petRemoteDataSource.pagination(page: page, limit: limit);
  }
}
