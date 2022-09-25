import 'package:flutter/material.dart';
import 'data/repo/auth_repository.dart';
import 'ui/auth/auth.dart';
import 'ui/root.dart';

import 'theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  authRepository.laodAuthInfo();
  print(authRepository.laodAuthInfo());
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
          snackBarTheme: SnackBarThemeData(
              contentTextStyle: defualtTextStyle.apply(color: Colors.white)),
          textTheme: TextTheme(
              titleMedium: defualtTextStyle.apply(
                  color: LightThemeColors.secondaryTextColor),
              bodyMedium: defualtTextStyle,
              labelLarge: defualtTextStyle,
              bodySmall: defualtTextStyle.apply(
                  color: LightThemeColors.secondaryTextColor),
              titleLarge: defualtTextStyle.copyWith(
                  fontWeight: FontWeight.w700, fontSize: 18)),
          colorScheme: const ColorScheme.light(
            primary: LightThemeColors.primaryColor,
            secondary: LightThemeColors.secondaryColor,
            onSecondary: Colors.white,
          ),
        ),
        home: const Directionality(
            textDirection: TextDirection.rtl, child: RootScrean()));
  }
}
