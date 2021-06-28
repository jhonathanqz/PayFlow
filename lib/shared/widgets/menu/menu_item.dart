import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final IconData? icon;
  final GestureTapCallback nextPageFunction;

  const MenuItem({
    Key? key,
    required this.title,
    required this.nextPageFunction,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 8,
      ),
      dense: true,
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color: AppColors.primary,
            size: 27,
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            title,
            style: AppTextStyles.titleMenu,
          ),
        ],
      ),
      onTap: nextPageFunction,
    );
  }
}
