import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:semaforo_app/App/controller/theme_configs.dart';

import '../custom_snack_bar.dart';

class NewOption extends StatefulWidget {
  final String ipText;
  final Function onDelete;

  NewOption({this.ipText, this.onDelete});

  @override
  State<NewOption> createState() => _NewOptionState();
}

class _NewOptionState extends State<NewOption> {
  final String errorMessage = "Preencha o IP corretamente";
  bool isSelected = false;
  TextEditingController methodController = TextEditingController();

  void getHTTpRequest() async {
    while (isSelected) {
      try {
        log('MODO ${methodController.text}');
        var response =
            await http.get("http://${widget.ipText}/${methodController.text}");
        print(response.body);
      } catch (e) {
        setState(() {
          isSelected = false;
        });
        print(e);
        mostrarSnackBar(message: e.toString(), context: context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkThemeProvider>(builder: (_, theme, __) {
      return Container(
        width: 120,
        height: 120,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: theme.darkTheme ? Color(0xFF5A5A5A) : Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 8,
                  spreadRadius: 2,
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(0, 3))
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Método',
                style: GoogleFonts.openSans(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: theme.darkTheme
                        ? Color(0xFFffffff)
                        : Color(0xFF646464))),
            Container(
              height: 20,
              child: TextField(
                controller: methodController,
                style: GoogleFonts.openSans(
                    fontSize: 14.0, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child:
                  // CustomSwitch(value: isSelected, onChanged: onChanged)
                  CupertinoSwitch(
                value: isSelected,
                onChanged: (value) {
                  if (isSelected) {
                    setState(() {
                      isSelected = false;
                    });
                  } else {
                    if (widget.ipText.isEmpty ||
                        widget.ipText.length < 11 ||
                        widget.ipText.endsWith('.0.0')) {
                      mostrarSnackBar(message: errorMessage, context: context);
                    } else {
                      setState(() {
                        isSelected = true;
                      });
                      getHTTpRequest();
                    }
                  }
                },
                trackColor:
                    theme.darkTheme ? Color(0xFFB5B5B5) : Color(0xFFE1E1E1),
              ),
            ),
          ],
        ),
      );
    });
  }
}
