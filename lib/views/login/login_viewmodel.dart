import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_tech_idara/base/app.locator.dart';
import 'package:stacked_tech_idara/base/app.router.dart';
import 'package:stacked_tech_idara/services/auth_services.dart';

class LoginViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final navigationService = locator<NavigationService>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  void onLoginTap(BuildContext context) async {
    isLoading = true;
    rebuildUi();
    if (!Form.of(context).validate()) {
      isLoading = false;
      rebuildUi();
      return;
    } else {
      log('Not Logged In lmfao loser');
    }
    var res = await runBusyFuture(_authService.loginService(
        emailController.text, passwordController.text));
    isLoading = false;
    rebuildUi();
    if (res == true) {
      navigationService.navigateTo(Routes.homeView);
    }
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter your email';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      log('Not Logged In lmfao loser');
      return 'Please enter your password';
    }
    if (value.length < 6) {
      log('Not Logged In lmfao loser');
      return 'Give me Strong passowrds';
    }
    return null;
  }
}
