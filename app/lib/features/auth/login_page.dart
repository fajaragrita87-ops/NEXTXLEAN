import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextclean/app/routes/app_routes.dart';
import 'package:nextclean/controllers/auth_controller.dart';
import 'package:nextclean/controllers/session_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late final SessionController _session;
  late final AuthController _auth;
  late final Worker _worker;

  @override
  void initState() {
    super.initState();
    _session = Get.find<SessionController>();
    _auth = Get.find<AuthController>();
    _worker = ever(_session.firebaseUser, (user) {
      if (user != null) Get.offAllNamed(AppRoutes.dashboard);
    });
  }

  @override
  void dispose() {
    _worker.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    await _auth.loginWithEmailPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (v) {
                    final value = v?.trim() ?? '';
                    if (value.isEmpty) return 'Email wajib diisi';
                    if (!value.contains('@')) return 'Email tidak valid';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (v) {
                    final value = v ?? '';
                    if (value.isEmpty) return 'Password wajib diisi';
                    if (value.length < 6) return 'Minimal 6 karakter';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Obx(() {
                  final error = _auth.errorMessage.value;
                  if (error == null || error.isEmpty) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      error,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }),
                Obx(() {
                  final loading = _auth.isLoading.value;
                  return ElevatedButton(
                    onPressed: loading ? null : _submit,
                    child: Text(loading ? 'Loading...' : 'Masuk'),
                  );
                }),
                const SizedBox(height: 12),
                const Text(
                  'OTP / Google login menyusul (butuh konfigurasi Firebase).',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

