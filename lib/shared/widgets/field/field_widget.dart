import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class FieldWidget extends StatelessWidget {
  final String text;

  const FieldWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      shadowColor: AppColors.shadow,
      color: Colors.black12,
      borderOnForeground: false,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black12,
          boxShadow: const [
            BoxShadow(
              color: AppColors.background,
              blurRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            top: 16,
            right: 5,
            bottom: 16,
          ),
          child: Text(
            text,
            style: AppTextStyles.buttonGray,
          ),
        ),
      ),
    );
  }
}
