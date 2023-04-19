import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_tech_idara/base/app.locator.dart';
import 'package:stacked_tech_idara/base/app.router.dart';
import 'package:stacked_tech_idara/services/auth_services.dart';
import 'package:stacked_tech_idara/views/login/login_view.dart';

class SplashViewModel extends BaseViewModel {
  final BuildContext context;

  SplashViewModel(this.context);

  void init() async {
    await Future.delayed(Duration(seconds: 2), () {
      if (locator<AuthService>().email != null) {
        locator<NavigationService>().pushNamedAndRemoveUntil(Routes.homeView);
        return;
      }
      locator<NavigationService>().pushNamedAndRemoveUntil(Routes.loginView);
    });
  }
}
