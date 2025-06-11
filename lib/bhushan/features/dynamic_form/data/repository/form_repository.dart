import 'package:mobile_security/bhushan/core/network/apiservice.dart';

import '../models/dynamic_form_model.dart';

class FormRepository {
  final ApiService _apiService;

  FormRepository(this._apiService);

  Future<List<DynamicFormModel>> fetchFormData() async {
    final response = await _apiService.getRequest("webjsontest/data.json");
    if (response.statusCode == 200) {
      final List jsonData = response.data;
      final formData =
          jsonData.map((data) => DynamicFormModel.fromJson(data)).toList();
      return formData;
    } else {
      throw Exception('Failed to fetch form data');
    }
  }
}
