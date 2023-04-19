import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_tech_idara/views/home/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Center(
              child: Text(viewModel.email.toString()),
            ),
          );
        });
  }
}
