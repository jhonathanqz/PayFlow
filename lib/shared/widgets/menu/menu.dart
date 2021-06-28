import 'package:flutter/material.dart';
import 'package:payflow/shared/widgets/menu/menu_divider.dart';

class Menu extends StatelessWidget {
  final List<Widget> menuItems;

  const Menu({
    Key? key,
    required this.menuItems,
  }) : super(key: key);

  @override
  ListView build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: menuItems.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return buildMenuItem(index);
      },
      separatorBuilder: (context, index) => const MenuDivider(),
    );
  }

  Widget buildMenuItem(index) {
    return Column(
      children: <Widget>[
        menuItems[index],
      ],
    );
  }
}
