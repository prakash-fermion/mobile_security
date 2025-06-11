import 'package:mobile_security/bhushan/core/network/apiservice.dart';
import 'package:mobile_security/bhushan/features/dynamic_form/bloc/dynamic_form_event.dart';
import 'package:mobile_security/bhushan/features/dynamic_form/bloc/dynamic_form_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_security/bhushan/features/dynamic_form/data/repository/form_repository.dart';

class DynamicFormBloc extends Bloc<DynamicFormEvent, DynamicFormState> {
  ApiService apiService;
  DynamicFormBloc({required this.apiService}) : super(DynamicFormInitial()) {
    on<DynamicFormEvent>(onFetchDynamicFormEvent);

  }

  Future<void> onFetchDynamicFormEvent(
    DynamicFormEvent event,
    Emitter<DynamicFormState> emit,
  ) async {
    try {
      emit(DynamicFormLoading());
      final repository = FormRepository(
        apiService,
      ); // Assuming you have a repository class
      final formData = await repository.fetchFormData();

      if (formData.isNotEmpty) {
        emit(DynamicFormLoaded(formData));
      } else {
        emit(DynamicFormFailure('No form data available'));
      }
    } catch (e) {
      emit(DynamicFormFailure(e.toString()));
    }
  }

  // Future<void> onFetchDynamicFormEvent(
  //   DynamicFormEvent event,
  //   Emitter<DynamicFormState> emit,
  // ) async {
  //   try {
  //     emit(DynamicFormLoading());
  //     final response = await http.get(
  //       Uri.parse("https://ajinkya-fermion.github.io/webjsontest/data.json"),
  //     );

  //     if (response.statusCode == 200) {
  //       // Assuming the response is a JSON object with a 'form' field
  //       final List<dynamic> jsonData = jsonDecode(
  //         response.body,
  //       ); // Decode the JSON response
  //       final formData =
  //           jsonData
  //               .map((data) => DynamicFormModel.fromJson(data))
  //               .toList(); // Map each item to DynamicFormModel
  //       emit(DynamicFormLoaded(formData));
  //     } else {
  //       emit(DynamicFormFailure('Failed to load form'));
  //     }
  //   } catch (e) {
  //     emit(DynamicFormFailure(e.toString()));
  //   }
  // }
}
