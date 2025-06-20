part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage();

  sl.registerLazySingleton(() => sharedPrefs);
  sl.registerLazySingleton(() => secureStorage);
  sl.registerLazySingleton<CacheHelper>(
    () => CacheHelper(sl<SharedPreferences>(), sl<FlutterSecureStorage>()),
  );
}
