import 'package:mobile_security/prakash/core/network/api_service.dart';
import 'package:mobile_security/prakash/features/dynamic_form/data/datasources/remote/dynamic_form_remote_datasource.dart';
import 'package:mobile_security/prakash/features/dynamic_form/data/models/form_model.dart';

class DynamicFormRemoteDatasourceImpl implements DynamicFormRemoteDatasource {
  final ApiService apiService;
  DynamicFormRemoteDatasourceImpl({required this.apiService});
  @override
  Future<List<FormModel>> getDynamicFormList() async {
    return await apiService.getDynamicFormList();
  }
}
