import 'package:flutter/material.dart';

class ItemsPage extends StatelessWidget {
  final Widget body;
  const ItemsPage({
    Key? key,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: body,
    );
  }
}
