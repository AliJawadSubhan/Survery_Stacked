import 'dart:developer';

import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_tech_idara/model/question_model.dart';
import 'package:stacked_tech_idara/views/home/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onViewModelReady: (viewModel) {
        viewModel.readQuestions();
        viewModel.getCurrentUserModel();
        // viewModel.showfancyBox(context);
      },
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            title: StreamBuilder(
              stream: viewModel.surveryusers,
              builder: (context, snap) {
                if (snap.data == null) {
                  return const Text(
                    'username',
                    style: TextStyle(
                      color: Colors.white, // Set text color to white
                      fontSize: 24,
                      // Set custom font
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
                return Text(
                  snap.data!.username!,
                  style: const TextStyle(
                    color: Colors.white, // Set text color to white
                    fontSize: 24,
                    // Set custom font
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            actions: [
              IconButton(
                onPressed: () {
                  viewModel.logout();
                },
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Colors.white, // Set icon color to white
                ),
              )
            ],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF00ACC1),
                    Color(0xFF00796B),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[600]!,
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              padding: EdgeInsets.only(bottom: 5),
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 1,
                color: Colors.grey[400],
              ),
            ),
          ),
          body: StreamBuilder(
              stream: viewModel.readQuestions(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                  ));
                }
                log(snapshot.error.toString());
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Question questionList = snapshot.data![index];
                    return AnimatedCard(
                      // keepAlive: false,
                      direction: AnimatedCardDirection.right,
                      duration: const Duration(milliseconds: 500),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Q) ${questionList.question}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                CheckboxListTile(
                                  activeColor: const Color(0xFF00796B),
                                  title: const Text('Agree'),
                                  value: viewModel.agree,
                                  onChanged: (value) {
                                    viewModel.onChange(
                                      value,
                                      'agree',
                                      Question(
                                        disagree: questionList.disagree,
                                        neutral: questionList.neutral,
                                        question: questionList.question,
                                        id: questionList.id,
                                        agree: viewModel.agree
                                            ? questionList.agree
                                            : questionList.agree,
                                      ),
                                    );
                                  },
                                ),
                                CheckboxListTile(
                                  activeColor: const Color(0xFF00796B),
                                  title: const Text('Disagree'),
                                  value: viewModel.disagree,
                                  onChanged: (value) {
                                    viewModel.onChange(
                                      value,
                                      'disagree',
                                      Question(
                                        disagree: viewModel.disagree
                                            ? questionList.disagree
                                            : questionList.disagree,
                                        neutral: questionList.neutral,
                                        question: questionList.question,
                                        id: questionList.id,
                                        agree: questionList.agree,
                                      ),
                                    );
                                  },
                                ),
                                CheckboxListTile(
                                  activeColor: const Color(0xFF00796B),
                                  title: const Text('Neutral'),
                                  value: viewModel.neutral,
                                  onChanged: (value) {
                                    viewModel.onChange(
                                      value,
                                      'neutral',
                                      Question(
                                        disagree: questionList.disagree,
                                        neutral: viewModel.neutral
                                            ? questionList.neutral
                                            : questionList.neutral,
                                        question: questionList.question,
                                        id: questionList.id,
                                        agree: questionList.agree,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
        );
      },
    );
  }
}
