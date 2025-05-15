import 'package:dartz/dartz.dart';
import 'package:mobile_security/prakash/core/error/failure.dart';
import 'package:mobile_security/prakash/features/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository authRepository;
  RegisterUsecase(this.authRepository);

  Future<Either<Failure, void>> call({
    required String username,
    required String password,
    required String mpin,
  }) async {
    return await authRepository.register(username, password, mpin);
  }
}
