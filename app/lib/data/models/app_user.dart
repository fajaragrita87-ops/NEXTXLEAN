import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nextclean/data/models/user_role.dart';

class AppUser {
  final String id;
  final String? name;
  final String? email;
  final String? phone;
  final String? photoUrl;
  final UserRole role;
  final String? branchId;
  final bool isActive;

  const AppUser({
    required this.id,
    required this.role,
    required this.isActive,
    this.name,
    this.email,
    this.phone,
    this.photoUrl,
    this.branchId,
  });

  factory AppUser.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    final role = UserRole.fromString(data['role'] as String?) ?? UserRole.customer;
    return AppUser(
      id: doc.id,
      role: role,
      isActive: (data['isActive'] as bool?) ?? true,
      name: data['name'] as String?,
      email: data['email'] as String?,
      phone: data['phone'] as String?,
      photoUrl: data['photoUrl'] as String?,
      branchId: data['branchId'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
      'role': role.key,
      'branchId': branchId,
      'isActive': isActive,
    };
  }
}

