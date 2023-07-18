import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked_tech_idara/model/question_model.dart';
import 'package:stacked_tech_idara/model/user_model.dart';

class FireStoreServices {
  var db = FirebaseFirestore.instance;

  Future sendUsertoDatabase(String username, String id) async {
    try {
      return await db
          .collection('surveryusers')
          .doc(id)
          .set({'username': username.trim()});
    } catch (e) {
      log('firestore: ${e.toString()}');
    }
  }

  Stream<Surveryusers> getSurveryUsers(String currentUserUid) {
    return db
        .collection('surveryusers')
        .doc(currentUserUid)
        .snapshots()
        .map((event) => Surveryusers.fromSnapshot(event));
  }

  final CollectionReference questionCollection =
      FirebaseFirestore.instance.collection('QuestionVoting');

  Stream<List<Question>> readData() {
    var questions = <Question>[];
    return questionCollection.snapshots().map((querySnapshot) {
      for (var singleQuestion in querySnapshot.docs) {
        Question question = Question.fromJson(singleQuestion);
        questions.add(question);
      }
      return questions;
    });
    // return questions;
  }

  Future<void> updateData(Question questionModel) async {
    final documentReference = questionCollection.doc(questionModel.id);

    var udpatedData = Question(
      agree: questionModel.agree,
      disagree: questionModel.disagree,
      neutral: questionModel.neutral,
      id: questionModel.id,
      question: questionModel.question,
    ).toJson();
    try {
      await documentReference.update(udpatedData);
    } catch (e) {
      log(e.toString());
    }
  }
}
