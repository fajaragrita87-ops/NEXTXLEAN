import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nextclean/data/models/app_user.dart';
import 'package:nextclean/data/models/user_role.dart';
import 'package:nextclean/data/repositories/user_repository.dart';

class SessionController extends GetxController {
  final FirebaseAuth auth;
  final UserRepository userRepository;

  SessionController({required this.auth, required this.userRepository});

  final firebaseUser = Rxn<User>();
  final appUser = Rxn<AppUser>();
  StreamSubscription<AppUser?>? _userSub;

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(auth.authStateChanges());
    ever<User?>(firebaseUser, _onAuthChanged);
  }

  Future<void> _onAuthChanged(User? user) async {
    await _userSub?.cancel();
    appUser.value = null;
    if (user == null) return;
    _userSub = userRepository.watchUserById(user.uid).listen((u) {
      appUser.value = u;
    });
  }

  UserRole? get role => appUser.value?.role;

  bool get isLoggedIn => firebaseUser.value != null;

  bool get isUserActive => appUser.value?.isActive ?? true;

  @override
  void onClose() {
    _userSub?.cancel();
    super.onClose();
  }
}

