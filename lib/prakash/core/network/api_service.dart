import 'package:dio/dio.dart';
import 'package:mobile_security/prakash/features/dynamic_form/data/models/form_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://ajinkya-fermion.github.io')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/webjsontest/data.json')
  Future<List<FormModel>> getDynamicFormList();
}
