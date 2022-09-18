import 'package:flutter/material.dart';
import 'package:nike/pages/home.dart';
import 'package:nike/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const defualtTextStyle = TextStyle(fontFamily: "IranYekan");
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: TextTheme(
              bodyMedium: defualtTextStyle,
              bodySmall: defualtTextStyle.apply(
                  color: LightThemeColors.secondaryTextColor),
              titleLarge:
                  defualtTextStyle.copyWith(fontWeight: FontWeight.w700)),
          colorScheme: const ColorScheme.light(
            primary: LightThemeColors.primaryColor,
            secondary: LightThemeColors.secondaryColor,
            onSecondary: Colors.white,
          ),
        ),
        home: const Directionality(
            textDirection: TextDirection.rtl, child: HomePage()));
  }
}
