import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void mostrarSnackBar(
    {@required String message, Color color, @required BuildContext context}) {
  SnackBar snackBar = SnackBar(
    content: Text(message),
    backgroundColor: color ?? Colors.red,
  );

  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
