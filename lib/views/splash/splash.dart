import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_tech_idara/views/splash/splash_viewmodel.dart';

class SplashView extends StackedView<SplashViewModel> {
  const SplashView({super.key});

  @override
  Widget builder(
      BuildContext context, SplashViewModel viewModel, Widget? child) {
    return const Scaffold(
      backgroundColor: Color(0xFFB0E0E6),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Survey Application',
            style: TextStyle(color: Colors.black, fontSize: 21),
          ),
          Center(
              child: CircularProgressIndicator(
            color: Colors.black,
          )),
        ],
      ),
    );
  }

  @override
  SplashViewModel viewModelBuilder(BuildContext context) =>
      SplashViewModel(context);

  @override
  bool get reactive {
    return true;
  }

  @override
  void onViewModelReady(SplashViewModel viewModel) {
    viewModel.init();
  }
}
