import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_security/core/network/api_service.dart';
import 'package:mobile_security/core/utils/prefs_helper.dart';
import 'package:mobile_security/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:mobile_security/features/auth/data/datasources/local/auth_local_datasource_impl.dart';
import 'package:mobile_security/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mobile_security/features/auth/domain/repositories/auth_repository.dart';
import 'package:mobile_security/features/auth/domain/usecases/check_login_usecase.dart';
import 'package:mobile_security/features/auth/domain/usecases/login_usecase.dart';
import 'package:mobile_security/features/auth/domain/usecases/login_with_mpin_usecase.dart';
import 'package:mobile_security/features/auth/domain/usecases/logout_usecase.dart';
import 'package:mobile_security/features/auth/domain/usecases/register_usecase.dart';
import 'package:mobile_security/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mobile_security/features/dynamic_form/data/datasources/remote/dynamic_form_remote_datasource.dart';
import 'package:mobile_security/features/dynamic_form/data/datasources/remote/dynamic_form_remote_datasource_impl.dart';
import 'package:mobile_security/features/dynamic_form/data/repositories/dynamic_form_repository_impl.dart';
import 'package:mobile_security/features/dynamic_form/domain/repositories/dynamic_form_repository.dart';
import 'package:mobile_security/features/dynamic_form/domain/usecases/get_dynamic_form_list_usecase.dart';
import 'package:mobile_security/features/dynamic_form/presentation/bloc/dynamic_form_bloc.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/data/datasources/local/fixed_deposit_calculator_local_datasource.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/data/datasources/local/fixed_deposit_calculator_local_datasource_impl.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/data/repositories/fixed_deposit_calculator_repository_impl.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/domain/repositories/fixed_deposit_calculator_repository.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/domain/usecases/calculate_fd_usecase.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/domain/usecases/get_citizen_dropdown_list_usecase.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/domain/usecases/get_interest_rate_list_usecase.dart';
import 'package:mobile_security/features/fixed_deposit_calculator/presentation/bloc/fixed_deposit_calculator_bloc.dart';
import 'package:mobile_security/features/home/data/datasources/local/home_local_datasource.dart';
import 'package:mobile_security/features/home/data/datasources/local/home_local_datasource_impl.dart';
import 'package:mobile_security/features/home/data/repositories/home_repository_impl.dart';
import 'package:mobile_security/features/home/domain/repositories/home_repository.dart';
import 'package:mobile_security/features/home/domain/usecases/check_binding_status_usecase.dart';
import 'package:mobile_security/features/home/domain/usecases/verify_sim_binding_usecase.dart';
import 'package:mobile_security/features/home/presentation/bloc/home_bloc.dart';
import 'package:mobile_security/features/sim_binding/bloc/sim_binding_bloc.dart';
import 'package:prefs/prefs.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features
  // Auth
  sl.registerFactory(
    () => AuthBloc(
      checkLoginUsecase: sl(),
      loginUsecase: sl(),
      registerUsecase: sl(),
      logoutUsecase: sl(),
      loginWithMpinUsecase: sl(),
    ),
  );

  sl.registerFactory(
    () => HomeBloc(
      checkBindingStatusUseCase: sl(),
      verifySimBindingUsecase: sl(),
    ),
  );

  sl.registerFactory(
    () => FixedDepositCalculatorBloc(
      getCitizenDropdownListUsecase: sl(),
      getInterestRateListUsecase: sl(),
      calculateFdUsecase: sl(),
    ),
  );

  sl.registerFactory(() => DynamicFormBloc(getDynamicFormListUsecase: sl()));

  sl.registerFactory(() => SimBindingBloc());

  // Usecases
  sl.registerLazySingleton(() => CheckLoginUsecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => RegisterUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUsecase(sl()));
  sl.registerLazySingleton(() => LoginWithMpinUsecase(sl()));

  sl.registerLazySingleton(() => CheckBindingStatusUseCase(sl()));
  sl.registerLazySingleton(() => VerifySimBindingUsecase(sl()));

  sl.registerLazySingleton(() => GetCitizenDropdownListUsecase(sl()));
  sl.registerLazySingleton(() => GetInterestRateListUsecase(sl()));
  sl.registerLazySingleton(() => CalculateFdUsecase(sl()));

  sl.registerLazySingleton(() => GetDynamicFormListUsecase(sl()));

  // Repository

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authLocalDatasource: sl()),
  );

  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(homeLocalDatasource: sl()),
  );

  sl.registerLazySingleton<FixedDepositCalculatorRepository>(
    () => FixedDepositCalculatorRepositoryImpl(
      fixedDepositCalculatorLocalDatasource: sl(),
    ),
  );

  sl.registerLazySingleton<DynamicFormRepository>(
    () => DynamicFormRepositoryImpl(dynamicFormRemoteDatasource: sl()),
  );

  // Datasources
  sl.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasourceImpl(sl()),
  );

  sl.registerLazySingleton<HomeLocalDatasource>(
    () => HomeLocalDatasourceImpl(prefsHelper: sl()),
  );

  sl.registerLazySingleton<FixedDepositCalculatorLocalDatasource>(
    () => FixedDepositCalculatorLocalDatasourceImpl(),
  );

  sl.registerLazySingleton<DynamicFormRemoteDatasource>(
    () => DynamicFormRemoteDatasourceImpl(apiService: sl()),
  );

  // External

  SharedPreferences prefs = await SharedPreferences.getInstance();

  sl.registerLazySingleton<PrefsHelper>(() => PrefsHelper(prefs));
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<ApiService>(() => ApiService(sl()));
}
