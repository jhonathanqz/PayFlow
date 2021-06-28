import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';

class MenuDivider extends StatelessWidget {
  const MenuDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 1,
      height: 1,
      indent: 16,
      endIndent: 16,
      color: AppColors.stroke,
    );
  }
}
