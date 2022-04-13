import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardToggle extends StatelessWidget {
  final bool isSelected;
  final Function(bool) onChanged;
  final String label;
  final hasLDR;

  const CardToggle({
    Key key,
    @required this.isSelected,
    @required this.onChanged,
    this.hasLDR = false,
    @required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
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
                  color: Color(0xFF646464))),
          AutoSizeText(label,
              style: GoogleFonts.openSans(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF646464))),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: CupertinoSwitch(value: isSelected, onChanged: onChanged),
          ),
        ],
      ),
    );
  }
}
