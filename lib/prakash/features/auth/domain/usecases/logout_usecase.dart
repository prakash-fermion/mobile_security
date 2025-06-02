import 'package:dartz/dartz.dart';
import 'package:mobile_security/prakash/core/error/failure.dart';
import 'package:mobile_security/prakash/features/auth/domain/repositories/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository authRepository;

  LogoutUsecase(this.authRepository);

  Future<Either<Failure, void>> call() async {
    return await authRepository.logout();
  }
}
