import 'package:get_it/get_it.dart';
import 'package:test_app/services/sharedprefs_services.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  final sharedPrefsService = await SharedPrefsService.getInstance();
  locator.registerSingleton(sharedPrefsService);
  // locator.registerLazySingleton<AnalyticsService>(() => AnalyticsService());
}
