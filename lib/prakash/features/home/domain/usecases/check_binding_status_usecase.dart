import 'package:dartz/dartz.dart';
import 'package:mobile_security/prakash/core/error/failure.dart';
import 'package:mobile_security/prakash/features/home/domain/repositories/home_repository.dart';

class CheckBindingStatusUseCase {
  final HomeRepository homeRepository;

  CheckBindingStatusUseCase(this.homeRepository);

  Future<Either<Failure, bool>> call(String deviceId) async {
    return await homeRepository.checkBindingStatus(deviceId);
  }
}
