import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageRepository {
  final FirebaseStorage storage;

  StorageRepository({required this.storage});

  Future<String> uploadOrderPhoto({
    required String orderId,
    required String type,
    required File file,
  }) async {
    final ref = storage.ref('orders/$orderId/$type.webp');
    await ref.putFile(file, SettableMetadata(contentType: 'image/webp'));
    return ref.getDownloadURL();
  }

  Future<String> uploadAttendancePhoto({
    required String userId,
    required String type,
    required DateTime at,
    required File file,
  }) async {
    final ref = storage.ref(
      'attendance/$userId/${at.millisecondsSinceEpoch}_$type.webp',
    );
    await ref.putFile(file, SettableMetadata(contentType: 'image/webp'));
    return ref.getDownloadURL();
  }
}
