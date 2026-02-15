import 'package:flutter/material.dart';
import 'package:xml2axml_flutter_example/my_app.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
      theme: themeData(.light),
      darkTheme: themeData(.dark),
    ),
  );
}

ThemeData themeData(Brightness brightness) {
  return ThemeData(
    brightness: brightness,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.deepPurple.shade600,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: .circular(7.5
        ))
      ),
    ),
  );
}
