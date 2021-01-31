import 'package:VTOP_Extended/models/faculty.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:VTOP_Extended/models/clubs.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  Future updateUserData(
      String name, String email, String rollno, List<String> clubnames) async {
    return await userCollection.doc(uid).set({
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
      FirebaseFirestore.instance.collection('clubs');
  Future updateClubData(String name, String president, String faculty,
      String bio, String logo) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'president': president,
      'faculty': faculty,
      'bio': bio,
      'logo': logo,
    });
  }

  List<Club> _clubListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Club(
        name: doc.data()['name'] ?? '',
        president: doc.data()['president'] ?? '',
        faculty: doc.data()['faculty'] ?? '',
        bio: doc.data()['bio'] ?? '',
        logo: doc.data()['logo'] ?? '',
      );
    }).toList();
  }

  Stream<List<Club>> get clubs {
    return clubsCollection.snapshots().map(_clubListFromSnapshot);
  }

  Future<List<Club>> getClubs() async {
    QuerySnapshot querySnapshot = await _firestore.collection('clubs').get();
    return querySnapshot.docs.map((document) => Club(
        name: document.data()['name'] ?? '',
        president: document.data()['president'] ?? '',
      faculty: document.data()['faculty'] ?? '',
      bio: document.data()['bio'] ?? '',
      logo: document.data()['logo'] ?? '',
      clubType: document.data()['clubType'] ?? ''
    )).toList();
  }

  Future<List<Faculty>> getFaculty() async {
    QuerySnapshot querySnapshot = await _firestore.collection('faculty').get();
    return querySnapshot.docs.map((document) => Faculty(
      name: document.data()['name'] ?? '',
      department: document.data()['department'] ?? '',
      email: document.data()['email'] ?? '',
      photoLink: document.data()['profilepic'] ?? '',
    )).toList();

  }
}
