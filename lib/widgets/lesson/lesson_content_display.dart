import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class LessonContentDisplay extends StatelessWidget {
  final String content;

  const LessonContentDisplay({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: content,
      selectable: true,
      onTapLink: (text, href, title) async {
        if (href != null) {
          final Uri url = Uri.parse(href);
          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.externalApplication);
          } else {
            debugPrint('Could not launch $url');
          }
        }
      },
      styleSheet: MarkdownStyleSheet(
        // Ensure paragraph style is clearly defined to prevent bleed-through
        p: const TextStyle(
            color: AppColors.textColor,
            fontSize: 16,
            // Ensure no inherited decorations or weights if not intended
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal),
        h1: AppColors.neonTextStyle(
            fontSize: 28,
            color: AppColors.accentColor,
            blurRadius: 10,
            fontWeight: FontWeight.bold),
        h2: AppColors.neonTextStyle(
            fontSize: 24,
            color: AppColors.secondaryColor,
            blurRadius: 8,
            fontWeight: FontWeight.bold),
        h3: const TextStyle(
            color: AppColors.textColor, fontSize: 20, fontWeight: FontWeight.bold),
        h4: const TextStyle(
            color: AppColors.textColor, fontSize: 18, fontWeight: FontWeight.bold),
        strong: const TextStyle(color: AppColors.xpColor, fontWeight: FontWeight.bold),
        em: const TextStyle(fontStyle: FontStyle.italic, color: AppColors.textColorSecondary),
        blockquote: const TextStyle(
            color: AppColors.textColorSecondary, fontStyle: FontStyle.italic),
        code: const TextStyle(
            color: AppColors.accentColor,
            backgroundColor: AppColors.cardColor,
            fontFamily: 'monospace'),
        codeblockDecoration: BoxDecoration(
          color: AppColors.cardColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          border: Border.all(color: AppColors.borderColor),
        ),
        listBullet: const TextStyle(color: AppColors.textColor),
        checkbox: const TextStyle(color: AppColors.textColor),
        a: const TextStyle(color: AppColors.accentColor, decoration: TextDecoration.underline),
      ),
    );
  }
}
