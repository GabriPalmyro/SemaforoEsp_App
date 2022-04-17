import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semaforo_app/App/model/multa.dart';

import 'components/placa/placa_card.dart';

class ListaMultasScreen extends StatefulWidget {
  final List<Multa> novasMultas;

  const ListaMultasScreen({Key key, this.novasMultas}) : super(key: key);

  @override
  State<ListaMultasScreen> createState() => _ListaMultasScreenState();
}

class _ListaMultasScreenState extends State<ListaMultasScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          title: Text("Multas Capturadas",
              style: GoogleFonts.openSans(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          backgroundColor: Color(0xFF219A9A)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 24.0,
                left: width * 0.1,
                right: width * 0.1,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                decoration: BoxDecoration(
                    color: Color(0xFFEFEFEF),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 8,
                          spreadRadius: 0,
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0, 2))
                    ]),
                child: Center(
                  child: Text(
                      'Quantidade de multas: ${widget.novasMultas.length}',
                      style: GoogleFonts.openSans(
                          letterSpacing: 1.1,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
              ),
            ),
            Column(
              children: List.generate(
                widget.novasMultas.length,
                (int index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 24.0),
                    child: CardPlaca(
                      placa: widget.novasMultas[index].placa,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
