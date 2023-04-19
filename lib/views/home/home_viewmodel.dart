import 'package:stacked/stacked.dart';
import 'package:stacked_tech_idara/base/app.locator.dart';
import 'package:stacked_tech_idara/services/auth_services.dart';

class HomeViewModel extends BaseViewModel {
  String? email = locator<AuthService>().email;
}
