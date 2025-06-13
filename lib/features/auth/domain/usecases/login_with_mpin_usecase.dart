import 'package:dartz/dartz.dart';
import 'package:mobile_security/core/error/failure.dart';
import 'package:mobile_security/features/auth/domain/repositories/auth_repository.dart';

class LoginWithMpinUsecase {
  final AuthRepository authRepository;

  LoginWithMpinUsecase(this.authRepository);

  Future<Either<Failure, bool>> call(String mpin) async {
    return await authRepository.loginWithMPIN(mpin);
  }
}
