import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_tech_idara/base/app.locator.dart';
import 'package:stacked_tech_idara/base/app.router.dart';
import 'package:stacked_tech_idara/services/auth_services.dart';

class LoginViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final navigationService = locator<NavigationService>();
  TextEditingController usernameController = TextEditingController();
  bool isLoading = false;
  void onLoginTap(BuildContext context) async {
    isLoading = true;
    rebuildUi();
    if (!Form.of(context).validate()) {
      isLoading = false;
      rebuildUi();
    } else {
      log('Form error');
    }
    var res = await runBusyFuture(
      _authService.loginService(
        usernameController.text.trim(),
      ),
    );
    isLoading = false;
    rebuildUi();
    if (res == true) {
      navigationService.pushNamedAndRemoveUntil(Routes.homeView);
    }
    if (res == false) {}
  }

  String? validateUsername(String? value) {
    if (value!.length < 3) {
      return 'Type your full name';
    }
    if (value == '') {
      return 'Please enter your name';
    }
    return null;
  }
}
