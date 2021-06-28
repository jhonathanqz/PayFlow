import 'package:flutter/material.dart';

push(
  BuildContext context,
  String routeName, {
  bool replace = false,
  Object? arguments,
}) {
  if (replace) {
    Navigator.of(context).popUntil((route) => route.isFirst);

    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  } else {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }
}

popAndPush(BuildContext context, String routeName) {
  Navigator.popUntil(context, (route) => route.isFirst);

  Navigator.pushNamed(context, routeName);
}

popUntil(BuildContext context) {
  Navigator.popUntil(context, (route) => route.isFirst);
}
