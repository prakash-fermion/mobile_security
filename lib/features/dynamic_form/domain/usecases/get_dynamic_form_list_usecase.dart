import 'package:dartz/dartz.dart';
import 'package:mobile_security/core/error/failure.dart';
import 'package:mobile_security/features/dynamic_form/domain/entities/form_entity.dart';
import 'package:mobile_security/features/dynamic_form/domain/repositories/dynamic_form_repository.dart';

class GetDynamicFormListUsecase {
  final DynamicFormRepository dynamicFormRepository;
  GetDynamicFormListUsecase(this.dynamicFormRepository);
  Future<Either<Failure, List<FormEntity>>> call() async {
    return await dynamicFormRepository.getDynamicFormList();
  }
}
