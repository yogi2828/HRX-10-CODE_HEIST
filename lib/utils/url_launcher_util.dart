// lib/utils/url_launcher_util.dart
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';

class UrlLauncherUtil {
  static Future<void> launchInBrowser(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }
}