import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardPlaca extends StatelessWidget {
  final String placa;

  const CardPlaca({Key key, this.placa = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.8,
      height: 110,
      decoration: BoxDecoration(
          color: Color(0xFFEFEFEF),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
                blurRadius: 25,
                spreadRadius: 3,
                color: Colors.black.withOpacity(0.3),
                offset: Offset(0, 0))
          ]),
      child: Column(
        children: [
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFF0135A5),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('MERCOSUL',
                    style: GoogleFonts.openSans(
                        letterSpacing: 1.2,
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.white)),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text('BRASIL',
                      style: GoogleFonts.openSans(
                          letterSpacing: 1.8,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                Icon(
                  Icons.bar_chart_sharp,
                  size: 24.0,
                  color: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
