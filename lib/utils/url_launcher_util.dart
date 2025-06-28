// lib/utils/url_launcher_util.dart
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtil {
  static Future<void> launchInBrowser(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
