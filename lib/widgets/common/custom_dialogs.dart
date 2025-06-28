import 'package:flutter/material.dart';
import 'package:gamifier/constants/app_colors.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/widgets/common/custom_button.dart';

class CustomDialogs {
  static Future<void> showInfoDialog(BuildContext context, String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to close
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.cardColor.withOpacity(0.95),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius * 2),
            side: const BorderSide(color: AppColors.accentColor, width: 2),
          ),
          title: Text(
            title,
            style: AppColors.neonTextStyle(fontSize: 24, color: AppColors.accentColor),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  message,
                  style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: CustomButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                text: 'OK',
                icon: Icons.check_circle_outline,
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<void> showErrorDialog(BuildContext context, String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.cardColor.withOpacity(0.95),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius * 2),
            side: const BorderSide(color: AppColors.errorColor, width: 2),
          ),
          title: Text(
            title,
            style: AppColors.neonTextStyle(fontSize: 24, color: AppColors.errorColor),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  message,
                  style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: CustomButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                text: 'Dismiss',
                icon: Icons.cancel_outlined,
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<bool?> showConfirmationDialog(BuildContext context, String title, String message) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.cardColor.withOpacity(0.95),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius * 2),
            side: const BorderSide(color: AppColors.warningColor, width: 2),
          ),
          title: Text(
            title,
            style: AppColors.neonTextStyle(fontSize: 24, color: AppColors.warningColor),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  message,
                  style: const TextStyle(color: AppColors.textColorSecondary, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop(false);
                  },
                  text: 'Cancel',
                  icon: Icons.close,
                ),
                CustomButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop(true);
                  },
                  text: 'Confirm',
                  icon: Icons.check,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
