import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nextclean/data/models/branch.dart';

class BranchRepository {
  final FirebaseFirestore firestore;

  BranchRepository({required this.firestore});

  CollectionReference<Map<String, dynamic>> get _branches => firestore.collection('branches');

  Future<Branch?> getBranchById(String branchId) async {
    if (branchId.isEmpty) return null;
    final doc = await _branches.doc(branchId).get();
    if (!doc.exists) return null;
    return Branch.fromDoc(doc);
  }
}

