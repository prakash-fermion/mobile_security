import 'package:dartz/dartz.dart';
import 'package:mobile_security/core/error/failure.dart';
import 'package:mobile_security/features/home/domain/repositories/home_repository.dart';

class VerifySimBindingUsecase {
  final HomeRepository homeRepository;

  VerifySimBindingUsecase(this.homeRepository);

  Future<Either<Failure, void>> call({
    required String phoneNumber,
    required String deviceId,
  }) async {
    return await homeRepository.verifySimBinding(phoneNumber, deviceId);
  }
}
