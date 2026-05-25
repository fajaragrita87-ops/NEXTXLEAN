import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nextclean/data/models/attendance.dart';

class AttendanceRepository {
  final FirebaseFirestore firestore;

  AttendanceRepository({required this.firestore});

  CollectionReference<Map<String, dynamic>> get _attendance => firestore.collection('attendance');

  Future<void> createAttendance({
    required String userId,
    required String type,
    required DateTime createdAt,
    String? branchId,
    double? latitude,
    double? longitude,
    String? photoUrl,
  }) async {
    final doc = _attendance.doc();
    final record = Attendance(
      id: doc.id,
      userId: userId,
      type: type,
      createdAt: createdAt,
      branchId: branchId,
      latitude: latitude,
      longitude: longitude,
      photoUrl: photoUrl,
    );
    await doc.set(record.toMap());
  }
}

