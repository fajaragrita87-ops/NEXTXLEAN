import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ImageProcessor {
  static Future<File> compressToWebp({
    required File input,
    int maxWidth = 800,
    int maxHeight = 800,
    int quality = 80,
  }) async {
    final dir = await getTemporaryDirectory();
    final outPath = p.join(
      dir.path,
      'nextclean_${DateTime.now().millisecondsSinceEpoch}.webp',
    );
    final result = await FlutterImageCompress.compressAndGetFile(
      input.path,
      outPath,
      quality: quality,
      minWidth: maxWidth,
      minHeight: maxHeight,
      keepExif: false,
      format: CompressFormat.webp,
      autoCorrectionAngle: true,
    );
    if (result == null) return input;
    return File(result.path);
  }
}
