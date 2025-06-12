import 'package:mobile_security/features/dynamic_form/data/models/form_model.dart';

abstract class DynamicFormRemoteDatasource {
  Future<List<FormModel>> getDynamicFormList();
}
