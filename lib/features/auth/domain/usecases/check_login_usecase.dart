import 'package:dartz/dartz.dart';
import 'package:mobile_security/core/error/failure.dart';
import 'package:mobile_security/features/auth/domain/repositories/auth_repository.dart';

class CheckLoginUsecase {
  final AuthRepository authRepository;

  CheckLoginUsecase(this.authRepository);

  Future<Either<Failure, void>> call() async {
    return await authRepository.checkLogin();
  }
}