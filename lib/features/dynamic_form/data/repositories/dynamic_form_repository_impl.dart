import 'package:dartz/dartz.dart';
import 'package:mobile_security/core/error/failure.dart';
import 'package:mobile_security/features/dynamic_form/data/datasources/remote/dynamic_form_remote_datasource.dart';
import 'package:mobile_security/features/dynamic_form/domain/entities/form_entity.dart';
import 'package:mobile_security/features/dynamic_form/domain/repositories/dynamic_form_repository.dart';

class DynamicFormRepositoryImpl implements DynamicFormRepository {
  final DynamicFormRemoteDatasource dynamicFormRemoteDatasource;
  DynamicFormRepositoryImpl({required this.dynamicFormRemoteDatasource});
  @override
  Future<Either<Failure, List<FormEntity>>> getDynamicFormList() async {
    try {
      final formList = await dynamicFormRemoteDatasource.getDynamicFormList();
      return Right(formList.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
