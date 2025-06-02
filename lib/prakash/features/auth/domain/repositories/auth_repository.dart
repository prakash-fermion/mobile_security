import 'package:dartz/dartz.dart';
import 'package:mobile_security/prakash/core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> checkLogin();
  Future<Either<Failure, void>> register(
    String username,
    String password,
    String mpin,
  );
  Future<Either<Failure, bool>> login(String username, String password);
  Future<Either<Failure, bool>> loginWithMPIN(String mpin);
  Future<Either<Failure, void>> logout();
}
