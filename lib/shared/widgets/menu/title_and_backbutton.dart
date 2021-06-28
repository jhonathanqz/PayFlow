import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';

class TitleAndBackButton extends StatelessWidget {
  final Widget child;
  final Alignment alignment;

  const TitleAndBackButton({
    Key? key,
    required this.child,
    this.alignment = Alignment.centerLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
      ),
      child: Stack(
        children: <Widget>[
          buildIcon(context),
          buildChild(),
        ],
      ),
    );
  }

  Align buildIcon(BuildContext context) {
    return Align(
      alignment: alignment,
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: AppColors.primary,
          size: 28,
        ),
        onPressed: () => Navigator.pop(context),
        padding: const EdgeInsets.only(left: 8),
      ),
    );
  }

  Align buildChild() {
    return Align(
      alignment: Alignment.center,
      child: child,
    );
  }
}
