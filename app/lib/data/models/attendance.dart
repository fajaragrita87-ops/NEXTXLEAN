import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance {
  final String id;
  final String userId;
  final String? branchId;
  final String type;
  final double? latitude;
  final double? longitude;
  final String? photoUrl;
  final DateTime createdAt;

  const Attendance({
    required this.id,
    required this.userId,
    required this.type,
    required this.createdAt,
    this.branchId,
    this.latitude,
    this.longitude,
    this.photoUrl,
  });

  factory Attendance.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    return Attendance(
      id: doc.id,
      userId: (data['userId'] as String?) ?? '',
      branchId: data['branchId'] as String?,
      type: (data['type'] as String?) ?? 'unknown',
      latitude: (data['latitude'] as num?)?.toDouble(),
      longitude: (data['longitude'] as num?)?.toDouble(),
      photoUrl: data['photoUrl'] as String?,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'branchId': branchId,
      'type': type,
      'latitude': latitude,
      'longitude': longitude,
      'photoUrl': photoUrl,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}

