import 'dart:developer';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_tech_idara/base/app.locator.dart';
import 'package:stacked_tech_idara/base/app.router.dart';
import 'package:stacked_tech_idara/common/widgets/fancy_alertbox.dart';
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
  ) async {
    switch (checkboxType) {
      case 'agree':
        agree = value == true;
        if (agree) {
          disagree = false;
          neutral = false;
          questionModel.agree += 1;
          questionModel.disagree = 0;
          questionModel.neutral = 0;
        }
        break;
      case 'disagree':
        disagree = value == true;
        if (disagree) {
          agree = false;
          neutral = false;
          questionModel.agree = 0;
          questionModel.disagree += 1;
          questionModel.neutral = 0;
        }
        break;
      case 'neutral':
        neutral = value == true;
        if (neutral) {
          agree = false;
          disagree = false;
          questionModel.agree = 0;
          questionModel.disagree = 0;
          questionModel.neutral += 1;
        }
        break;
      default:
        break;
    }

    // Notify listeners that the ViewModel has changed
    notifyListeners();

    // Call the service or update data in firestore if needed
    await firestoreService.updateData(questionModel);
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
