import 'package:cloud_firestore/cloud_firestore.dart';

class Branch {
  final String id;
  final String name;
  final double latitude;
  final double longitude;

  const Branch({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory Branch.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    return Branch(
      id: doc.id,
      name: (data['name'] as String?) ?? doc.id,
      latitude: (data['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (data['longitude'] as num?)?.toDouble() ?? 0,
    );
  }
}

