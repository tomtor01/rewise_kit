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

Future<void> initServices() async {

}

Future<void> initData() async {
  sl
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl<FirebaseAuth>()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()),
    )
    ..registerLazySingleton<LessonRemoteDataSource>(
      () => LessonRemoteDataSourceImpl(sl<FirebaseFirestore>()),
    )
    ..registerLazySingleton<LessonRepository>(
      () => LessonRepositoryImpl(
        sl<LessonRemoteDataSource>(),
        sl<FirebaseAuth>(),
      ),
    )
    ..registerLazySingleton<DashboardRemoteDataSource>(
      () => DashboardRemoteDataSourceImpl(sl<FirebaseFirestore>()),
    )
    ..registerLazySingleton<DashboardRepository>(
      () => DashboardRepositoryImpl(
        sl<DashboardRemoteDataSource>(),
        sl<FirebaseAuth>(),
      ),
    )
    ..registerLazySingleton<FlashcardRemoteDataSource>(
      () => FlashcardRemoteDataSourceImpl(sl<FirebaseFirestore>()),
    )
    ..registerLazySingleton<FlashcardRepository>(
      () => FlashcardRepositoryImpl(
        sl<FlashcardRemoteDataSource>(),
        sl<FirebaseAuth>(),
      ),
    );
}

Future<void> initUseCases() async {
  sl
    ..registerLazySingleton(() => SignUpUseCase(sl<AuthRepository>()))
    ..registerLazySingleton(() => SignInUseCase(sl<AuthRepository>()))
    ..registerLazySingleton(() => LogoutUseCase(sl<AuthRepository>()))
    ..registerLazySingleton(() => GetUserDataUseCase(sl<DashboardRepository>()))
    ..registerLazySingleton(() => CreateLessonUseCase(sl<LessonRepository>()))
    ..registerLazySingleton(
      () => GetCreatedLessonsUseCase(sl<LessonRepository>()),
    )
    ..registerLazySingleton(() => SaveLessonUseCase(sl<LessonRepository>()))
    ..registerLazySingleton(() => UnsaveLessonUseCase(sl<LessonRepository>()))
    ..registerLazySingleton(() => SearchLessonsUseCase(sl<LessonRepository>()))
    ..registerLazySingleton(() => GetLessonByIdUseCase(sl<LessonRepository>()))
    ..registerLazySingleton(
      () => GetSavedLessonsUseCase(sl<LessonRepository>()),
    )
    ..registerLazySingleton(() => DeleteLessonUseCase(sl<LessonRepository>()))
    ..registerLazySingleton(
      () => CreateFlashcardUseCase(sl<FlashcardRepository>()),
    )
    ..registerLazySingleton(
      () => GetFlashcardsBySetIdUseCase(sl<FlashcardRepository>()),
    )
    ..registerLazySingleton(
      () => UpdateFlashcardUseCase(sl<FlashcardRepository>()),
    )
    ..registerLazySingleton(
      () => DeleteFlashcardUseCase(sl<FlashcardRepository>()),
    )
    ..registerLazySingleton(
      () => UpdateFlashcardsProgressUseCase(sl<DashboardRepository>()),
    )
    ..registerLazySingleton(
      () => CreateFlashcardSetUseCase(sl<FlashcardRepository>()),
    )
      ..registerLazySingleton(
      () => GetFlashcardSetsUseCase(sl<FlashcardRepository>()),
    );
}
