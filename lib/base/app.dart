import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_tech_idara/services/auth_services.dart';
import 'package:stacked_tech_idara/services/db_services.dart';
import 'package:stacked_tech_idara/views/home/home_view.dart';
import 'package:stacked_tech_idara/views/login/login_view.dart';
import 'package:stacked_tech_idara/views/splash/splash.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: HomeView)
  ],
  dependencies: [
    Singleton(classType: NavigationService),
    LazySingleton(classType: AuthService),
    Singleton(classType: FireStoreServices),
  ],
)
class App {}
