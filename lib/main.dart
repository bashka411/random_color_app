import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(Main());

class Main extends StatefulWidget {
  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  Color backgroundColor = Colors.white;
  Color fontColor = Colors.black;
  final double fontSizeScale = 0.06;
  final String appTitle = 'Random Color App';

  ///A method that generates a random value (0-255) for each R, G and B values
  ///which in total gives 16777216 colors possible
  Color getRandomColor() {
    final Color randomColor = Color.fromRGBO(
      Random().nextInt(256),
      Random().nextInt(256),
      Random().nextInt(256),
      1, //where 1 is opacity, which means no transparency
    );

    return randomColor;
  }

  ///This method provides a redability to the text on the screen depending on
  ///how bright or dark a background is. It converts RGB value to HSV(Hue, Saturation, Value/Brightness)
  ///and then compares brightness to medium value - 50%
  Color getContrastColor(Color inputColor) {
    final Color contrastColor = HSVColor.fromColor(inputColor).value > 0.5
        ? Colors.black
        : Colors.white;

    return contrastColor;
  }

  TextStyle getTextStyle({required double fontSize, bool isBold = false}) {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
      fontSize: fontSize,
      color: fontColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: const Color.fromRGBO(0, 0, 0, 0.25),
              shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
              title: Text(
                'Random Color App',
                style: getTextStyle(
                  fontSize: MediaQuery.of(context).size.width * fontSizeScale,
                ),
              ),
            ),
            body: Stack(
              children: [
                InkWell(
                  child: Center(
                    child: Text(
                      'Hey there!',
                      style: getTextStyle(
                        fontSize:
                            MediaQuery.of(context).size.width * fontSizeScale,
                        isBold: true,
                      ),
                    ),
                  ),
                  onTap: () => setState(() {
                    backgroundColor = getRandomColor();
                    fontColor = getContrastColor(backgroundColor);
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
