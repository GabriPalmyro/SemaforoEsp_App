import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:semaforo_app/App/controller/theme_configs.dart';
import 'package:semaforo_app/App/model/semaforo.dart';
import 'package:semaforo_app/App/view/home/components/card_new_option.dart';
import 'package:semaforo_app/App/view/home/components/card_toggle.dart';
import 'package:semaforo_app/App/view/home/components/modal_settings.dart';
import 'package:semaforo_app/App/view/home/components/pedestrian_card.dart';
import 'package:semaforo_app/App/view/home/components/placa/placa_card.dart';
import 'package:semaforo_app/App/view/home/components/semaforo_card.dart';
import 'dart:async';
import 'custom_snack_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String errorMessage =
      "Preencha o IP do ESP corretamente nas configurações";
  TextEditingController ipController =
      TextEditingController(text: '192.168.0.0');
  int semaforoSelect = 0;
  List<Widget> novosWidgets = [];

  Semaforo semaforo = Semaforo(luzes: [0, 0, 1]);

  List<int> convertToSemaforos(String response) {
    return [
      int.parse(response.split(",")[0]),
      int.parse(response.split(",")[1]),
      int.parse(response.split(",")[2])
    ];
  }

  void getDia() async {
    while (semaforoSelect == 1) {
      try {
        log('MODO DIA');
        var response = await http.get("http://${ipController.text}/dia");
        print(response.body);
        // await Future.delayed(Duration(seconds: 2));
        setState(() {
          // lDRValue = double.parse(response.body.split(",")[0]);
          semaforo.luzes = convertToSemaforos(response.body);
          // int.parse(response.body.split(",")[1]) == 1 ? true : false;
        });
        // await Future.delayed(Duration(seconds: 3));
        // setState(() {
        //   hasPedestrian = false;
        // });
      } catch (e) {
        setState(() {
          semaforoSelect = 0;
          semaforo.hasPedestrian = false;
          semaforo.luzes = [0, 0, 0];
        });
        print(e);
        mostrarSnackBar(message: e.toString(), context: context);
      }
    }
  }

  void getMadrugada() async {
    while (semaforoSelect == 2) {
      try {
        log('MODO MADRUGADA');
        var response = await http.get("http://${ipController.text}/madrugada");
        print(response.body);
        setState(() {
          semaforo.ldrValue = double.parse(response.body);
        });
      } catch (e) {
        setState(() {
          semaforoSelect = 0;
        });
        print(e);
        mostrarSnackBar(message: e.toString(), context: context);
      }
      await Future.delayed(Duration(seconds: 0));
    }
  }

  void getSensor() async {
    while (semaforoSelect == 3) {
      try {
        log('MODO SENSOR');
        var response = await http.get("http://${ipController.text}/sensor");
        print(response.body);
        setState(() {
          semaforo.ldrValue = double.parse(response.body);
        });
      } catch (e) {
        setState(() {
          semaforoSelect = 0;
        });
        print(e);
        mostrarSnackBar(message: e.toString(), context: context);
      }
      setState(() {
        semaforoSelect = 0;
      });
      await Future.delayed(Duration(seconds: 0));
    }
  }

  void resetTimers() {
    setState(() {
      semaforoSelect = 0;
      semaforo = Semaforo(luzes: [0, 0, 1]);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<DarkThemeProvider>(builder: (_, theme, __) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: height,
          width: width,
          child: Stack(
            children: [
              Positioned(
                  bottom: 0,
                  child: Container(
                      width: width,
                      height: height * 0.9,
                      color: Colors.white,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.only(top: height * 0.32),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SemaforoCard(
                                    semaforoLuzes: semaforo.luzes,
                                  ),
                                  PedestrianCard(
                                    hasPedestrian: semaforo.hasPedestrian,
                                    isRedSign: semaforo.luzes[0] == 1,
                                  )
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 24.0, bottom: 60.0),
                                child: CardPlaca(),
                              )
                            ],
                          ),
                        ),
                      ))),
              Positioned(
                top: 0,
                child: Container(
                  width: width,
                  height: 200,
                  decoration: BoxDecoration(
                      color: theme.darkTheme
                          ? Color(0xFFC5C5C5)
                          : Color(0xFF219A9A).withOpacity(0.4),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35))),
                  child: Stack(
                    children: [
                      Positioned(
                          right: 5,
                          top: 50,
                          child: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    enableDrag: false,
                                    builder: (_) => ModalSettings(
                                          ipController: ipController,
                                        ));
                              },
                              icon: Icon(Icons.settings,
                                  color: theme.darkTheme
                                      ? Color(0xFF565656)
                                      : Colors.white))),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 24.0, top: height * 0.07),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: width * 0.7,
                                child: Image.asset('assets/semaforo_png.png')),
                            Text('Métodos de Controle',
                                style: GoogleFonts.openSans(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: height * 0.19,
                child: Container(
                  width: width,
                  height: 150,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 12.0, left: 24.0, bottom: 12.0),
                          child: CardToggle(
                            label: 'Dia',
                            isSelected: semaforoSelect == 1 ? true : false,
                            onChanged: (value) {
                              if (semaforoSelect == 1) {
                                setState(() {
                                  semaforoSelect = 0;
                                  semaforo.hasPedestrian = false;
                                  semaforo.luzes = [0, 0, 0];
                                });
                              } else {
                                if (ipController.text.isEmpty ||
                                    ipController.text.length < 11 ||
                                    ipController.text.endsWith('.0.0')) {
                                  mostrarSnackBar(
                                      message: errorMessage, context: context);
                                } else {
                                  setState(() {
                                    semaforoSelect = 1;
                                    semaforo.hasPedestrian = false;
                                    semaforo.luzes = [0, 0, 0];
                                  });
                                  getDia();
                                }
                              }
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 12.0, left: 12.0, bottom: 12.0),
                          child: CardToggle(
                            label: 'Madrugada',
                            isSelected: semaforoSelect == 2 ? true : false,
                            onChanged: (value) {
                              if (semaforoSelect == 2) {
                                setState(() {
                                  semaforoSelect = 0;
                                  semaforo.hasPedestrian = false;
                                  semaforo.luzes = [0, 0, 0];
                                });
                              } else {
                                if (ipController.text.isEmpty ||
                                    ipController.text.length < 11 ||
                                    ipController.text.endsWith('.0.0')) {
                                  mostrarSnackBar(
                                      message: errorMessage, context: context);
                                } else {
                                  setState(() {
                                    semaforoSelect = 2;
                                    semaforo.hasPedestrian = false;
                                    semaforo.luzes = [0, 0, 0];
                                  });
                                  getMadrugada();
                                }
                              }
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 12.0, left: 12.0, bottom: 12.0),
                          child: CardToggle(
                            label: 'Sensor',
                            isSelected: semaforoSelect == 3 ? true : false,
                            onChanged: (value) {
                              if (semaforoSelect == 3) {
                                setState(() {
                                  semaforoSelect = 0;
                                  semaforo.hasPedestrian = false;
                                  semaforo.luzes = [0, 0, 0];
                                });
                              } else {
                                if (ipController.text.isEmpty ||
                                    ipController.text.length < 11) {
                                  mostrarSnackBar(
                                      message: errorMessage, context: context);
                                } else {
                                  setState(() {
                                    semaforoSelect = 3;
                                    semaforo.hasPedestrian = false;
                                    semaforo.luzes = [0, 0, 0];
                                  });
                                  getSensor();
                                }
                              }
                            },
                          )),
                      Row(
                          children: List.generate(
                        novosWidgets.length,
                        (_) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              top: 12.0,
                              left: 12.0,
                              bottom: 12.0,
                            ),
                            child: NewOption(
                              ipText: ipController.text,
                              onDelete: () {},
                            ),
                          );
                        },
                      )),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 12.0, left: 12.0, bottom: 12.0, right: 20.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              novosWidgets.add(NewOption(
                                ipText: ipController.text,
                                onDelete: () {},
                              ));
                            });
                          },
                          child: Container(
                            width: 120,
                            height: 120,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: theme.darkTheme
                                    ? Color(0xFF5A5A5A)
                                    : Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 8,
                                      spreadRadius: 2,
                                      color: Colors.black.withOpacity(0.2),
                                      offset: Offset(0, 3))
                                ],
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: theme.darkTheme
                                    ? Colors.white
                                    : Color(0xFF5a5a5a),
                                size: 38,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
