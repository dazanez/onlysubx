import 'package:flutter/material.dart';
import 'package:only_subx_ui/config/constants.dart';

const colorList = <Color>[
  Colors.yellow,
  Colors.blue,
  Colors.red,
  Colors.green,
  Colors.deepPurple,
  Colors.orange
];

class AppTheme {
  static const colors = colorList;
  final int selectedColor;
  final bool isDarkMode;

  /// You can choose one color from the [colors] list, and set dark o light mode
  AppTheme({this.selectedColor = 4, this.isDarkMode = true})
      : assert(selectedColor < colors.length && selectedColor >= 0,
            'AppTheme: El indice del color seleccionado debe estar entre 0 y ${colors.length - 1}');

  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      colorSchemeSeed: colorList[selectedColor],
      // Because it centers on iPhone
      appBarTheme: const AppBarTheme(centerTitle: false, titleTextStyle: TextStyle(fontSize: CustomTextStyle.mediumTitleFontSize)),
      textTheme: const TextTheme(
        titleSmall: TextStyle(fontSize: CustomTextStyle.smallTitleFontSize),
        titleMedium: TextStyle(fontSize: CustomTextStyle.mediumTitleFontSize),
        titleLarge: TextStyle(fontSize: CustomTextStyle.largeTitleFontSize),
      ));

  /// Copy the appTheme object with new properties, useful to change the darkMode for example
  AppTheme copyWith(int? selectedColor, bool? isDarkMode) => AppTheme(
      selectedColor: selectedColor ?? this.selectedColor,
      isDarkMode: isDarkMode ?? this.isDarkMode);
}
