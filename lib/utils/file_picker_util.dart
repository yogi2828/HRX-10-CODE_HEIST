// lib/utils/file_picker_util.dart
import 'package:file_picker/file_picker.dart';

class FilePickerUtil {
  static Future<PlatformFile?> pickTextFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );
    return result?.files.first;
  }

  static Future<PlatformFile?> pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    return result?.files.first;
  }

  static Future<PlatformFile?> pickImageFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    return result?.files.first;
  }
}
