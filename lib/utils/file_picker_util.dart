
// lib/utils/file_picker_util.dart
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class FilePickerUtil {
  static Future<String?> pickTextFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt', 'pdf', 'docx'],
      );

      if (result != null && result.files.single.bytes != null) {
        String? fileContent;
        if (result.files.single.extension == 'txt') {
          fileContent = String.fromCharCodes(result.files.single.bytes!);
        } else {
          debugPrint('Unsupported file type for direct content reading: ${result.files.single.extension}');
          return null;
        }
        return fileContent;
      } else {
        debugPrint('File picking cancelled or no file selected.');
        return null;
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
      return null;
    }
  }
}