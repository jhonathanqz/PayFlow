import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/label_button/label_button.dart';

class AppAlert {
  static Future<void> dialog({
    required BuildContext context,
    required String title,
    required String message,
    required String firstButtonTitle,
    required String secondButtonTitle,
    required VoidCallback function,
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: AppTextStyles.titleBoldHeading),
          content: Text(message, style: AppTextStyles.buttonHeading),
          actions: <Widget>[
            LabelButton(
              label: firstButtonTitle,
              backgroundColor: AppColors.secondary,
              style: AppTextStyles.buttonBackground,
              onPressed: () => Navigator.pop(context),
            ),
            LabelButton(
              label: secondButtonTitle,
              backgroundColor: AppColors.delete,
              style: AppTextStyles.buttonBackground,
              onPressed: function,
            ),
          ],
        );
      },
    );
  }
}
