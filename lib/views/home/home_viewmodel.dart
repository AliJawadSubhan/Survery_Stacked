import 'dart:developer';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_tech_idara/base/app.locator.dart';
import 'package:stacked_tech_idara/base/app.router.dart';
import 'package:stacked_tech_idara/model/question_model.dart';
import 'package:stacked_tech_idara/model/user_model.dart';
import 'package:stacked_tech_idara/services/auth_services.dart';
import 'package:stacked_tech_idara/services/db_services.dart';

class HomeViewModel extends BaseViewModel {
  var authService = locator<AuthService>();
  var firestoreService = locator<FireStoreServices>();
  final navigationService = locator<NavigationService>();

  bool agree = false;
  bool disagree = false;
  bool neutral = false;

  Stream<Surveryusers>? surveryusers;
  getCurrentUserModel() {
    surveryusers =
        firestoreService.getSurveryUsers(authService.userUid.toString());
  }

  void onChange(
    bool? value,
    String checkboxType,
    Question questionModel,
    checkBoxState,
  ) async {
    switch (checkboxType) {
      case 'agree':
        if (value == true) {
          if (checkBoxState.agree == false) {
            if (checkBoxState.disagree == true) {
              checkBoxState.disagree = false;
              questionModel.disagree -= 1;
            } else if (checkBoxState.neutral == true) {
              checkBoxState.neutral = false;
              questionModel.neutral += 1;
            }
            checkBoxState.agree = true;
            questionModel.agree -= 1;
          }
        } else {
          checkBoxState.agree = false;
          questionModel.agree += 1;
        }
        break;
      case 'disagree':
        if (value == true) {
          if (checkBoxState.disagree == false) {
            if (checkBoxState.agree == true) {
              checkBoxState.agree = false;
              questionModel.agree += 1;
            } else if (checkBoxState.neutral == true) {
              checkBoxState.neutral = false;
              questionModel.neutral += 1;
            }
            checkBoxState.disagree = true;
            questionModel.disagree -= 1;
          }
        } else {
          checkBoxState.disagree = false;
          questionModel.disagree += 1;
        }
        break;
      case 'neutral':
        if (value == true) {
          if (checkBoxState.neutral == false) {
            if (checkBoxState.agree == true) {
              checkBoxState.agree = false;
              questionModel.agree += 1;
            } else if (checkBoxState.disagree == true) {
              checkBoxState.disagree = false;
              questionModel.disagree += 1;
            }
            checkBoxState.neutral = true;
            questionModel.neutral -= 1;
          }
        } else {
          checkBoxState.neutral = false;
          questionModel.neutral += 1;
        }
        break;
      default:
        break;
    }

    await firestoreService.updateData(questionModel);
    rebuildUi();
  }

  String? email = '';
  logout() {
    runBusyFuture(authService.logout());
    navigationService.navigateTo(Routes.loginView);
  }

  // String? selecetedOption;
  // checkBox(value, newOption) {
  //   selecetedOption = newOption;
  //   rebuildUi();
  // }
  String selectedOption = '';

  // read

  Stream<List<Question>> readQuestions() {
    try {
      firestoreService.readData();
    } catch (e) {
      log(e.toString());
    }
    return firestoreService.readData();
  }

  Future<void> updatedQuestion(Question question) async {
    await firestoreService.updateData(question);
    rebuildUi();
  }

  checkBox(value, newOption) {
    if (value == true) {
      selectedOption = newOption;
      notifyListeners();
    }
  }
}
