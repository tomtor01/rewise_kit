part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await cacheInit();
  await initData();
  await initUseCases();
}

Future<void> cacheInit() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage();

  sl.registerLazySingleton(() => sharedPrefs);
  sl.registerLazySingleton(() => secureStorage);
  sl.registerLazySingleton<CacheHelper>(
    () => CacheHelper(sl<SharedPreferences>(), sl<FlutterSecureStorage>()),
  );
}

Future<void> initData() async {
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<FirebaseAuth>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()),
  );
}

Future<void> initUseCases() async {
  sl
    ..registerLazySingleton(() => SignUpUseCase(sl<AuthRepository>()))
    ..registerLazySingleton(() => SignInUseCase(sl<AuthRepository>()))
    ..registerLazySingleton(() => LogoutUseCase(sl<AuthRepository>()));
}
