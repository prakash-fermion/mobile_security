import 'package:dartz/dartz.dart';
import 'package:mobile_security/prakash/core/error/failure.dart';
import 'package:mobile_security/prakash/features/home/data/datasources/local/home_local_datasource.dart';
import 'package:mobile_security/prakash/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDatasource homeLocalDatasource;
  HomeRepositoryImpl({required this.homeLocalDatasource});
  @override
  Future<Either<Failure, bool>> checkBindingStatus(String deviceId) async {
    try {
      final result = await homeLocalDatasource.checkBindingStatus(deviceId);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> verifySimBinding(
    String phoneNumber,
    String deviceId,
  ) async {
    try {
      await homeLocalDatasource.verifySimBinding(phoneNumber, deviceId);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
