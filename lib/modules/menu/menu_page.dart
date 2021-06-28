import 'package:flutter/material.dart';
import 'package:payflow/modules/menu/menu_controller.dart';
import 'package:payflow/shared/models/user_model.dart';

class MenuPage extends StatelessWidget {
  final UserModel user;
  const MenuPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MenuController menu = MenuController(
      context: context,
      user: user,
    );
    return menu.loadMenu;
  }
}
