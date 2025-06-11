import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_security/bhushan/features/dynamic_form/bloc/dynamic_form_bloc.dart';

import '../network/apiservice.dart';

final GetIt sl = GetIt.instance;

void setupInjection() {
  sl.registerFactory(() => DynamicFormBloc(apiService: sl()));

  sl.registerLazySingleton<ApiService>(() => ApiService());
  sl.registerLazySingleton<Dio>(() => Dio());

  // Register your dependencies here
  // Example:
  // getIt.registerSingleton<YourService>(YourServiceImpl());
  // getIt.registerFactory<YourRepository>(() => YourRepositoryImpl());
}
