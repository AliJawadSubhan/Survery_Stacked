import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_tech_idara/views/login/login_viewmodel.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({super.key});

  @override
  Widget builder(
      BuildContext context, LoginViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFB0E0E6),
        actions: [
          GestureDetector(
            onTap: () {
              viewModel.init(context);
            },
            child: Container(
              margin: const EdgeInsets.all(12),
              child: const Icon(
                Icons.info_outline,
                size: 22,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFB0E0E6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Welcome, Take a survey.",
                style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Form(
              child: Builder(builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                          controller: viewModel.usernameController,
                          validator: (value) {
                            return viewModel.validateUsername(value!);
                          },
                          decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: const TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 20),
                      viewModel.isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.blueGrey,
                            )
                          : SizedBox(
                              width: 250,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  viewModel.onLoginTap(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                child: const Text(
                                  "Go to Survey",
                                  style: TextStyle(
                                    color: Color(0xFFB0E0E6),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onViewModelReady(LoginViewModel viewModel) {}

  @override
  bool get reactive {
    return true;
  }

  @override
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel();
}
