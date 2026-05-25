import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nextclean/controllers/session_controller.dart';
import 'package:nextclean/data/models/branch.dart';
import 'package:nextclean/data/repositories/attendance_repository.dart';
import 'package:nextclean/data/repositories/branch_repository.dart';
import 'package:nextclean/data/repositories/storage_repository.dart';
import 'package:nextclean/utils/geo_utils.dart';
import 'package:nextclean/utils/image_processor.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  bool _loading = false;
  String? _lastInfo;

  Future<void> _submit({required String type}) async {
    final session = Get.find<SessionController>();
    final attendanceRepo = Get.find<AttendanceRepository>();
    final branchRepo = Get.find<BranchRepository>();
    final storageRepo = Get.find<StorageRepository>();

    final user = session.appUser.value;
    if (user == null) return;

    setState(() {
      _loading = true;
      _lastInfo = null;
    });

    try {
      final now = DateTime.now();

      Branch? branch;
      if (user.branchId != null && user.branchId!.isNotEmpty) {
        branch = await branchRepo.getBranchById(user.branchId!);
      }

      final pos = await GeoUtils.getCurrentPosition();
      final lat = pos?.latitude;
      final lon = pos?.longitude;

      double? distance;
      if (branch != null && lat != null && lon != null) {
        distance = GeoUtils.distanceMeters(
          lat1: lat,
          lon1: lon,
          lat2: branch.latitude,
          lon2: branch.longitude,
        );
      }
      if (distance != null && distance > 100) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Gak di cabang (di luar radius 100m).'),
            ),
          );
        }
        return;
      }

      String? photoUrl;
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: ImageSource.camera);
      if (picked != null) {
        final compressed = await ImageProcessor.compressToWebp(
          input: File(picked.path),
        );
        photoUrl = await storageRepo.uploadAttendancePhoto(
          userId: user.id,
          type: type,
          at: now,
          file: compressed,
        );
      }

      await attendanceRepo.createAttendance(
        userId: user.id,
        branchId: user.branchId,
        type: type,
        createdAt: now,
        latitude: lat,
        longitude: lon,
        photoUrl: photoUrl,
      );

      final allowed = distance == null ? null : distance <= 100;
      setState(() {
        _lastInfo =
            'saved type=$type lat=${lat?.toStringAsFixed(6)} lon=${lon?.toStringAsFixed(6)} '
            'distance=${distance?.toStringAsFixed(1)}m allowed=$allowed';
      });

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Absen $type tersimpan.')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal absen: $e')));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = Get.find<SessionController>();

    return Obx(() {
      final user = session.appUser.value;
      if (user == null) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      return Scaffold(
        appBar: AppBar(title: const Text('Absen')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('User: ${user.name ?? user.id}'),
              const SizedBox(height: 8),
              Text('Branch: ${user.branchId ?? '-'}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loading ? null : () => _submit(type: 'masuk'),
                child: Text(
                  _loading ? 'Loading...' : 'Absen Masuk (Geo + Foto)',
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _loading ? null : () => _submit(type: 'pulang'),
                child: Text(
                  _loading ? 'Loading...' : 'Absen Pulang (Geo + Foto)',
                ),
              ),
              const SizedBox(height: 16),
              if (_lastInfo != null) SelectableText(_lastInfo!),
              const SizedBox(height: 12),
              const Text(
                'Rule radius 100m: dihitung kalau data cabang punya latitude/longitude.',
              ),
            ],
          ),
        ),
      );
    });
  }
}
