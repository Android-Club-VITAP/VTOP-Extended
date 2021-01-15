import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:VTOP_Extended/models/clubs.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  Firestore _firestore = Firestore.instance;

  final CollectionReference userCollection =
      Firestore.instance.collection('users');
  Future updateUserData(
      String name, String email, String rollno, List<String> clubnames) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'email': email,
      'rollno': rollno,
      'clubs': clubnames,
    });
  }

  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }

  final CollectionReference clubsCollection =
      Firestore.instance.collection('clubs');
  Future updateClubData(String name, String president, String faculty,
      String bio, String logo) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'president': president,
      'faculty': faculty,
      'bio': bio,
      'logo': logo,
    });
  }

  List<Club> _clubListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Club(
        name: doc.data['name'] ?? '',
        president: doc.data['president'] ?? '',
        faculty: doc.data['faculty'] ?? '',
        bio: doc.data['bio'] ?? '',
        logo: doc.data['logo'] ?? '',
      );
    }).toList();
  }

  Stream<List<Club>> get clubs {
    return clubsCollection.snapshots().map(_clubListFromSnapshot);
  }

  Future<List<Club>> getClubs() async {
    QuerySnapshot querySnapshot = await _firestore.collection('clubs').getDocuments();
    return querySnapshot.documents.map((document) => Club(
        name: document.data['name'] ?? '',
        president: document.data['president'] ?? '',
      faculty: document.data['faculty'] ?? '',
      bio: document.data['bio'] ?? '',
      logo: document.data['logo'] ?? '',
      clubType: document.data['clubType'] ?? ''
    )).toList();
  }
}
