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
      },
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            // title: Text(viewModel.surveryusers.listen((eve)),
            title: StreamBuilder(
                stream: viewModel.surveryusers,
                builder: (context, snap) {
                  if (snap.data == null) {
                    return const Text('username');
                  }
                  return Text(snap.data!.username!);
                }),
            actions: [
              IconButton(
                onPressed: () {
                  viewModel.readQuestions();
                },
                icon: const Icon(Icons.exit_to_app),
              )
            ],
          ),
          body: StreamBuilder(
              stream: viewModel.readQuestions(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const CircularProgressIndicator();
                }

                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var questionList = snapshot.data![index];
                      return Column(
                        children: [
                          Text(snapshot.data![index].question),
                          CheckboxListTile(
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
                                viewModel,
                              );
                            },
                          ),
                          CheckboxListTile(
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
                                viewModel,
                              );
                            },
                          ),
                          CheckboxListTile(
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
                                viewModel,
                              );
                            },
                          ),
                        ],
                      );
                    });
              }),
        );
      },
    );
  }
}
