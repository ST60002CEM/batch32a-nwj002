import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/app/constants/api_endpoint.dart';
import 'package:liquor_ordering_system/core/failure/failure.dart';
import 'package:liquor_ordering_system/core/networking/remote/http_service.dart';
import 'package:liquor_ordering_system/core/shared_prefs/user_shared_prefs.dart';
import 'package:liquor_ordering_system/features/auth/data/model/auth_api_model.dart';
import 'package:liquor_ordering_system/features/auth/domain/entity/auth_entity.dart';

final authRemoteDataSourceProvider = Provider(
  (ref) => AuthRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    authApiModel: ref.watch(authApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class AuthRemoteDataSource {
  final Dio dio;
  final AuthApiModel authApiModel;
  final UserSharedPrefs userSharedPrefs;

  AuthRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
    required this.authApiModel,
  });

  Future<Either<Failure, bool>> registerUser(AuthEntity authEntity) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.register,
        data: authApiModel.fromEntity(authEntity).toJson(),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      }
      return Left(
        Failure(
          error: response.data["message"],
          statusCode: response.statusCode.toString(),
        ),
      );
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> loginUser(
      {required String email, required String password}) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        final token = response.data['token'];
        print(token);
        await userSharedPrefs.setUserToken(token);

        return const Right(true);
      }
      return Left(
        Failure(
          error: response.data["message"] ?? 'Unknown error',
          statusCode: response.statusCode.toString(),
        ),
      );
    } on DioException catch (e) {
      if (e.response != null) {
        print('DioError! Response data: ${e.response?.data}');
        print('DioError! Response headers: ${e.response?.headers}');
        print('DioError! Response request: ${e.response?.requestOptions}');
      } else {
        print('DioError! Error message: ${e.message}');
      }
      return Left(
        Failure(
          error: e.message ?? 'Unknown error',
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    } catch (e) {
      print('Unexpected error: $e');
      return Left(
        Failure(
          error: e.toString(),
          statusCode: '0',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> verifyUser() async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );
      Response response = await dio.get(
        ApiEndpoints.verifyUser,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      }
      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }

  Future<Either<Failure, AuthEntity>> getMe() async {
    try {
      // Fetch token
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );

      // Fetch user data from API
      Response response = await dio.get(
        ApiEndpoints.getMe,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      // Print for debugging
      print(response.data); // Ensure this matches your expected model

      if (response.statusCode == 200) {
        // Adjust parsing to ensure type correctness
        final userData = response.data['data'];
        if (userData != null) {
          // Convert to AuthEntity
          final authEntity = AuthApiModel.fromJson(userData).toEntity();
          return Right(authEntity);
        } else {
          return Left(Failure(error: 'User data is missing in the response'));
        }
      }
      return Left(
        Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString(),
        ),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }

  Future<Either<Failure, bool>> updateUser(AuthEntity updateUser) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );

      if (token == null) {
        return Left(
          Failure(
            error: 'No token found',
          ),
        );
      }

      Response response = await dio.put(
        ApiEndpoints.updateUser,
        data: authApiModel.fromEntity(updateUser).toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> sentOtp(String phone) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.sentOtp,
        data: {
          "phone": phone,
        },
      );

      if (response.statusCode == 200) {
        return const Right(true);
      }

      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> resetPassword(
      {required String phone,
      required String otp,
      required String newPassword}) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.verifyOtp,
        data: {
          "phone": phone,
          "otp": otp,
          "newPassword": newPassword,
        },
      );

      if (response.statusCode == 200) {
        return const Right(true);
      }

      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }
}
