import 'package:dartz/dartz.dart';
import 'package:mobile_security/prakash/core/error/failure.dart';
import 'package:mobile_security/prakash/features/dynamic_form/domain/entities/form_entity.dart';

abstract class DynamicFormRepository {
  Future<Either<Failure, List<FormEntity>>> getDynamicFormList();
}
