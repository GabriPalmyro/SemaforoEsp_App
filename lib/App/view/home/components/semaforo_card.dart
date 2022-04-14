import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semaforo_app/App/controller/theme_configs.dart';

class SemaforoCard extends StatefulWidget {
  final List<int> semaforoLuzes;

  const SemaforoCard({
    Key key,
    this.semaforoLuzes,
  }) : super(key: key);

  @override
  _SemaforoCardState createState() => _SemaforoCardState();
}

class _SemaforoCardState extends State<SemaforoCard> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Consumer<DarkThemeProvider>(builder: (_, theme, __) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
        height: 280,
        width: width * 0.33,
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        decoration: BoxDecoration(
            color: theme.darkTheme ? Color(0xFF4B4B4B) : Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                color: Colors.black.withOpacity(0.25),
                offset: Offset(1, 4),
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: widget.semaforoLuzes[0] == 1
                  ? Colors.red
                  : Colors.red.withOpacity(0.1),
              maxRadius: 28.0,
            ),
            CircleAvatar(
              backgroundColor: widget.semaforoLuzes[1] == 1
                  ? Colors.yellow
                  : Colors.yellow.withOpacity(0.1),
              maxRadius: 28.0,
            ),
            CircleAvatar(
              backgroundColor: widget.semaforoLuzes[2] == 1
                  ? Colors.green
                  : Colors.green.withOpacity(0.1),
              maxRadius: 28.0,
            ),
          ],
        ),
      );
    });
  }
}
