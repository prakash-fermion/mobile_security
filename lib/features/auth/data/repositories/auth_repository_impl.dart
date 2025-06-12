import 'package:dartz/dartz.dart';
import 'package:mobile_security/core/error/failure.dart';
import 'package:mobile_security/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:mobile_security/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDatasource authLocalDatasource;
  AuthRepositoryImpl({required this.authLocalDatasource});

  @override
  Future<Either<Failure, bool>> checkLogin() async {
    try {
      final result = await authLocalDatasource.checkLogin();
      if (result == true) {
        return Right(result);
      } else {
        return Left(CacheFailure('User is not logged in'));
      }
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> login(String username, String password) async {
    try {
      final result = await authLocalDatasource.login(username, password);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final result = await authLocalDatasource.logout();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> register(
    String username,
    String password,
    String mpin,
  ) async {
    try {
      final result = await authLocalDatasource.register(
        username,
        password,
        mpin,
      );
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> loginWithMPIN(String mpin) async {
    try {
      final result = await authLocalDatasource.loginWithMPIN(mpin);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
