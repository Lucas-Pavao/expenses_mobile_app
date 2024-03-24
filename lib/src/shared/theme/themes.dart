import 'package:flutter/material.dart';
part 'color_schemes.g.dart';

ThemeData get lighttheme => ThemeData(
      useMaterial3: true,
      colorScheme: _lightColorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: _lightColorScheme.background,
        titleTextStyle: TextStyle(
            color: _lightColorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 20),
        actionsIconTheme: IconThemeData(color: _lightColorScheme.primary),
        // elevation: 1,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              _lightColorScheme.primaryContainer),
          textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(color: _lightColorScheme.onPrimary),
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(color: _lightColorScheme.primaryContainer),
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(color: _lightColorScheme.primaryContainer),
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: _lightColorScheme.primary),
        suffixIconColor: _lightColorScheme.primary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(
            color: _lightColorScheme.primaryContainer,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: _lightColorScheme.primaryContainer,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: _lightColorScheme.primaryContainer,
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor:
              MaterialStateProperty.all<Color>(_lightColorScheme.primary),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(
              color: _lightColorScheme.primary,
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            _lightColorScheme.onSecondary,
          ),
          iconSize: MaterialStateProperty.resolveWith<double?>(
            (states) {
              if (states.contains(MaterialState.selected)) {
                return 11;
              }
              return 0;
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.selected)) {
              return _lightColorScheme.onSecondaryContainer;
            }
            return _lightColorScheme.primary;
          }),
          textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
            (states) {
              if (states.contains(MaterialState.selected)) {
                return const TextStyle(fontSize: 9);
              }
              return const TextStyle(fontSize: 11);
            },
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _lightColorScheme.primaryContainer,
        foregroundColor: _lightColorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );

ThemeData get darktheme => ThemeData(
      useMaterial3: true,
      colorScheme: _darkColorScheme,
      scaffoldBackgroundColor: _darkColorScheme.background,
      appBarTheme: AppBarTheme(
        // backgroundColor: _darkColorScheme.background,
        color: _darkColorScheme.background,
        titleTextStyle: TextStyle(
            color: _darkColorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 20),
        actionsIconTheme: IconThemeData(color: _darkColorScheme.primary),
        elevation: 1,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              _darkColorScheme.primaryContainer),
          textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(color: _darkColorScheme.onSurfaceVariant),
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(
              color: _darkColorScheme.primaryContainer,
            ),
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(color: _darkColorScheme.primaryContainer),
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: _darkColorScheme.primary),
        suffixIconColor: _darkColorScheme.primaryContainer,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: _darkColorScheme.primaryContainer,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: _darkColorScheme.primaryContainer,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: _darkColorScheme.primaryContainer,
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor:
              MaterialStateProperty.all<Color>(_darkColorScheme.primary),
        ),
      ),
      iconTheme: IconThemeData(
        color: _darkColorScheme.primary,
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(
              color: _darkColorScheme.primary,
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            _darkColorScheme.onPrimary,
          ),
          iconSize: MaterialStateProperty.resolveWith<double?>(
            (states) {
              if (states.contains(MaterialState.selected)) {
                return 11;
              }
              return 0;
            },
          ),
          textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
            (states) {
              if (states.contains(MaterialState.selected)) {
                return const TextStyle(fontSize: 9);
              }
              return const TextStyle(fontSize: 11);
            },
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _darkColorScheme.primaryContainer,
        foregroundColor: _darkColorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
            _darkColorScheme.primary,
          ),
        ),
      ),
    );
