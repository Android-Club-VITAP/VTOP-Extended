import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference clubCollection =
      Firestore.instance.collection('users');
  Future updateUserData(
      String name, String email, String rollno, List<String> clubnames) async {
    return await clubCollection.document(uid).setData({
      'name': name,
      'email': email,
      'rollno': rollno,
      'clubs': clubnames,
    });
  }

  Stream<QuerySnapshot> get users {
    return clubCollection.snapshots();
  }
}
