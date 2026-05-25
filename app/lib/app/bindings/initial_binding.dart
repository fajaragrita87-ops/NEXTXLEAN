import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:nextclean/controllers/auth_controller.dart';
import 'package:nextclean/controllers/session_controller.dart';
import 'package:nextclean/data/repositories/attendance_repository.dart';
import 'package:nextclean/data/repositories/branch_repository.dart';
import 'package:nextclean/data/repositories/order_repository.dart';
import 'package:nextclean/data/repositories/storage_repository.dart';
import 'package:nextclean/data/repositories/user_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    final firestore = FirebaseFirestore.instance;
    firestore.settings = const Settings(persistenceEnabled: true);

    Get.put<FirebaseAuth>(FirebaseAuth.instance, permanent: true);
    Get.put<FirebaseFirestore>(firestore, permanent: true);
    Get.put<FirebaseStorage>(FirebaseStorage.instance, permanent: true);

    Get.put<UserRepository>(
      UserRepository(firestore: firestore),
      permanent: true,
    );
    Get.put<OrderRepository>(
      OrderRepository(firestore: firestore),
      permanent: true,
    );
    Get.put<AttendanceRepository>(
      AttendanceRepository(firestore: firestore),
      permanent: true,
    );
    Get.put<BranchRepository>(
      BranchRepository(firestore: firestore),
      permanent: true,
    );
    Get.put<StorageRepository>(
      StorageRepository(storage: Get.find<FirebaseStorage>()),
      permanent: true,
    );

    Get.put<SessionController>(
      SessionController(
        auth: Get.find<FirebaseAuth>(),
        userRepository: Get.find<UserRepository>(),
      ),
      permanent: true,
    );
    Get.put<AuthController>(
      AuthController(auth: Get.find<FirebaseAuth>()),
      permanent: true,
    );
  }
}
