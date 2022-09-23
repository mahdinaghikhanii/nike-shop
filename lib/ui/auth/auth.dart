import 'package:flutter/material.dart';

class AuthScrean extends StatefulWidget {
  const AuthScrean({super.key});

  @override
  State<AuthScrean> createState() => _AuthScreanState();
}

class _AuthScreanState extends State<AuthScrean> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    const onBackground = Colors.white;
    return Theme(
      data: themeData.copyWith(
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size.fromHeight(56),
                  ),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
                  backgroundColor: MaterialStateProperty.all(onBackground),
                  foregroundColor: MaterialStateProperty.all(
                      themeData.colorScheme.secondary))),
          colorScheme: themeData.colorScheme.copyWith(onSurface: onBackground),
          inputDecorationTheme: InputDecorationTheme(
              labelStyle: const TextStyle(color: onBackground),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: Colors.white, width: 1)))),
      child: Scaffold(
        backgroundColor: themeData.colorScheme.secondary,
        body: Padding(
          padding: const EdgeInsets.only(left: 48, right: 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/nike_logo.png',
                color: Colors.white,
                width: 120,
              ),
              const SizedBox(height: 24),
              Text(isLogin ? 'خوش امدید' : "ثبت نام",
                  style: const TextStyle(color: onBackground, fontSize: 22)),
              const SizedBox(height: 16),
              Text(
                  isLogin
                      ? 'لطفا وارد حساب کاربردی خود شوید'
                      : 'ایمیل و رمز عبور خود را تعیین کنید',
                  style: const TextStyle(color: onBackground, fontSize: 16)),
              const SizedBox(height: 24),
              const TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(label: Text('ادرس ایمیل   '))),
              const SizedBox(height: 16),
              const _PasswordTextField(onBackground: onBackground),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () {}, child: Text(isLogin ? 'ورود' : 'ثبت نام')),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isLogin = !isLogin;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLogin ? "حساب کاربری ندارید ؟" : "حساب کاریری دارید",
                      style: TextStyle(color: onBackground.withOpacity(0.7)),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isLogin ? 'ثبت نام' : "ورود",
                      style: TextStyle(
                          color: themeData.colorScheme.primary,
                          decoration: TextDecoration.underline),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({required this.onBackground});

  final Color onBackground;

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool obsecureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
        keyboardType: TextInputType.visiblePassword,
        obscureText: obsecureText,
        decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obsecureText = !obsecureText;
                  });
                },
                icon: Icon(
                  obsecureText
                      ? Icons.visibility
                      : Icons.visibility_off_outlined,
                  color: widget.onBackground.withOpacity(0.8),
                )),
            label: const Text('ادرس ایمیل   ')));
  }
}