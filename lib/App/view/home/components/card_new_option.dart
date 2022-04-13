import 'dart:async';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

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
  int delayPeriodic = 6;

  Timer timer;
  void getHTTpRequest() async {
    while (isSelected) {
      try {
        log('MODO ${methodController.text}');
        var response = await http
            .get("http://${widget.ipText}/${methodController.text}")
            .timeout(Duration(seconds: delayPeriodic), onTimeout: () {
          throw Exception('Timeout error');
        });
        print(response.body);
      } catch (e) {
        setState(() {
          isSelected = false;
        });
        timer.cancel();
        print(e);
        mostrarSnackBar(message: e.toString(), context: context);
      }
      await Future.delayed(Duration(seconds: delayPeriodic));
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.85,
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: Colors.black.withOpacity(0.25),
              offset: Offset(2, 3),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.ipText.isNotEmpty) ...[
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      widget.ipText.isEmpty
                          ? 'Insira seu IP'
                          : widget.ipText + '/',
                      style: GoogleFonts.openSans(
                          color: widget.ipText.isNotEmpty
                              ? Colors.black
                              : Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w400,
                          fontSize: 15),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      child: TextField(
                        controller: methodController,
                        decoration: InputDecoration(
                            labelText: 'Método',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.blue.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.lightBlue),
                              borderRadius: BorderRadius.circular(5),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ] else ...[
            Expanded(
              child: AutoSizeText(
                'Insira o IP do ESP nas configurações',
                style: GoogleFonts.openSans(
                    color: widget.ipText.isNotEmpty
                        ? Colors.black
                        : Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CupertinoSwitch(
                value: isSelected,
                onChanged: (value) {
                  if (isSelected) {
                    setState(() {
                      isSelected = false;
                    });
                  } else {
                    if (widget.ipText.isEmpty || widget.ipText.length < 11) {
                      mostrarSnackBar(message: errorMessage, context: context);
                    } else {
                      setState(() {
                        isSelected = true;
                      });
                      getHTTpRequest();
                    }
                  }
                }),
          ),
        ],
      ),
    );
  }
}
