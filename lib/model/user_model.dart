import 'package:cloud_firestore/cloud_firestore.dart';

class Surveryusers {
  final String? username;

  Surveryusers(this.username);
  factory Surveryusers.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Surveryusers(data['username']);
  }
}
