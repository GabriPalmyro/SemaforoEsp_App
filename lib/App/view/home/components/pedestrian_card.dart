import 'package:flutter/material.dart';

class PedestrianCard extends StatefulWidget {
  final bool hasPedestrian;
  final bool isRedSign;

  const PedestrianCard(
      {Key key, this.hasPedestrian = false, @required this.isRedSign})
      : super(key: key);

  @override
  _PedestrianCardState createState() => _PedestrianCardState();
}

class _PedestrianCardState extends State<PedestrianCard> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
      height: 280,
      width: width * 0.33,
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              spreadRadius: 0,
              color: Colors.black.withOpacity(0.2),
              offset: Offset(1, 4),
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.directions_walk,
            color: !widget.isRedSign ? Colors.grey[400] : Colors.green,
            size: 70,
          ),
          Icon(
            Icons.pan_tool_rounded,
            color: widget.isRedSign ? Color(0xFF340000) : Colors.red,
            size: 60,
          ),
        ],
      ),
    );
  }
}
