import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth;

  AuthController({required this.auth});

  final isLoading = false.obs;
  final errorMessage = RxnString();

  Future<void> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    errorMessage.value = null;
    isLoading.value = true;
    try {
      await auth.signInWithEmailAndPassword(email: email.trim(), password: password);
    } on FirebaseAuthException catch (e) {
      errorMessage.value = e.message ?? e.code;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}

