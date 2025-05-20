import 'package:get_it/get_it.dart';
import 'package:mobile_security/prakash/core/utils/prefs_helper.dart';
import 'package:mobile_security/prakash/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:mobile_security/prakash/features/auth/data/datasources/local/auth_local_datasource_impl.dart';
import 'package:mobile_security/prakash/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mobile_security/prakash/features/auth/domain/repositories/auth_repository.dart';
import 'package:mobile_security/prakash/features/auth/domain/usecases/check_login_usecase.dart';
import 'package:mobile_security/prakash/features/auth/domain/usecases/login_usecase.dart';
import 'package:mobile_security/prakash/features/auth/domain/usecases/login_with_mpin_usecase.dart';
import 'package:mobile_security/prakash/features/auth/domain/usecases/logout_usecase.dart';
import 'package:mobile_security/prakash/features/auth/domain/usecases/register_usecase.dart';
import 'package:mobile_security/prakash/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mobile_security/prakash/features/home/data/datasources/local/home_local_datasource.dart';
import 'package:mobile_security/prakash/features/home/data/datasources/local/home_local_datasource_impl.dart';
import 'package:mobile_security/prakash/features/home/data/repositories/home_repository_impl.dart';
import 'package:mobile_security/prakash/features/home/domain/repositories/home_repository.dart';
import 'package:mobile_security/prakash/features/home/domain/usecases/check_binding_status_usecase.dart';
import 'package:mobile_security/prakash/features/home/domain/usecases/verify_sim_binding_usecase.dart';
import 'package:mobile_security/prakash/features/home/presentation/bloc/home_bloc.dart';
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

  // Usecases
  sl.registerLazySingleton(() => CheckLoginUsecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => RegisterUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUsecase(sl()));
  sl.registerLazySingleton(() => LoginWithMpinUsecase(sl()));

  sl.registerLazySingleton(() => CheckBindingStatusUseCase(sl()));
  sl.registerLazySingleton(() => VerifySimBindingUsecase(sl()));

  // Repository

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authLocalDatasource: sl()),
  );

  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(homeLocalDatasource: sl()),
  );

  // Datasources
  sl.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasourceImpl(sl()),
  );

  sl.registerLazySingleton<HomeLocalDatasource>(
    () => HomeLocalDatasourceImpl(prefsHelper: sl()),
  );

  // External

  SharedPreferences prefs = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => PrefsHelper(prefs));
}
