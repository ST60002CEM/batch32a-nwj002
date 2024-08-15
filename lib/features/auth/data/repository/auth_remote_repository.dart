import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/core/failure/failure.dart';
import 'package:liquor_ordering_system/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:liquor_ordering_system/features/auth/domain/entity/auth_entity.dart';
import 'package:liquor_ordering_system/features/auth/domain/repository/auth_repository.dart';

final authRemoteRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthRemoteRepository(
    ref.read(authRemoteDataSourceProvider),
  );
});

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRemoteRepository(this.authRemoteDataSource);

  @override
  Future<Either<Failure, bool>> loginUser(String email, String password) {
    return authRemoteDataSource.loginUser(email: email, password: password);
  }

  @override
  Future<Either<Failure, bool>> registerUser(AuthEntity user) {
    return authRemoteDataSource.registerUser(user);
  }

  @override
  Future<Either<Failure, bool>> verifyUser() {
    return authRemoteDataSource.verifyUser();
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    return authRemoteDataSource.getMe();
  }

  @override
  Future<Either<Failure, bool>> updateUser(AuthEntity user) {
    return authRemoteDataSource.updateUser(user);
  }
}
