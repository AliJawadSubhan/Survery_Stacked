import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  String question;
  String id;
  int agree;
  int disagree;
  int neutral;

  Question({
    required this.agree,
    required this.disagree,
    required this.neutral,
    required this.id,
    required this.question,
  });

  factory Question.fromJson(DocumentSnapshot json) {
    var data = json.data() as Map<String, dynamic>;
    return Question(
      id: data['id'],
      question: data['question'],
      agree: data['agree'],
      disagree: data['disagree'],
      neutral: data['neutral'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'agree': agree,
      'disagree': disagree,
      'neutral': neutral,
    };
  }
}
