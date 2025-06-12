import 'package:dartz/dartz.dart';
import 'package:mobile_security/core/error/failure.dart';

abstract class HomeRepository {
  Future<Either<Failure, void>> verifySimBinding(String phoneNumber, String deviceId);
  Future<Either<Failure, bool>> checkBindingStatus(String deviceId);
}