import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nextclean/data/models/app_user.dart';

class UserRepository {
  final FirebaseFirestore firestore;

  UserRepository({required this.firestore});

  CollectionReference<Map<String, dynamic>> get _users => firestore.collection('users');

  Future<AppUser?> getUserById(String userId) async {
    final doc = await _users.doc(userId).get();
    if (!doc.exists) return null;
    return AppUser.fromDoc(doc);
  }

  Stream<AppUser?> watchUserById(String userId) {
    return _users.doc(userId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return AppUser.fromDoc(doc);
    });
  }
}

