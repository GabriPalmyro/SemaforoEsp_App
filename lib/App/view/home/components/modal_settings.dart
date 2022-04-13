import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semaforo_app/App/controller/theme_configs.dart';

class ModalSettings extends StatefulWidget {
  final TextEditingController ipController;

  ModalSettings({
    @required this.ipController,
  });

  @override
  _ModalSettingsState createState() => _ModalSettingsState();
}

class _ModalSettingsState extends State<ModalSettings> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.85,
      child: Container(
        height: height * 0.85,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Container(
                  width: width * 0.85,
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 24.0),
                        child: Icon(Icons.label, size: 35),
                      ),
                      Expanded(
                        child: TextField(
                          controller: widget.ipController,
                          decoration: InputDecoration(
                              labelText: 'IP ESP 8266',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.black.withOpacity(0.5)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Container(
                  width: width * 0.85,
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Trocar Tema',
                        style: GoogleFonts.openSans(
                            fontSize: 18.0, fontWeight: FontWeight.w400),
                      ),
                      CupertinoSwitch(
                          value: context.read<ThemeConfigs>().isDarkTheme,
                          onChanged: (value) async {
                            context.read<ThemeConfigs>().changePreferences();
                          })
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      width: width * 0.85,
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                          color: Color(0xFF219A9A),
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              color: Colors.black.withOpacity(0.25),
                              offset: Offset(2, 3),
                            )
                          ]),
                      child: Center(
                        child: Text("Confirmar Alterações",
                            style: GoogleFonts.openSans(
                              fontSize: 20,
                              color: Colors.white,
                            )),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
