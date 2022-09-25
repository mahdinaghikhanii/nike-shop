import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/data/repo/auth_repository.dart';
import 'package:nike/ui/auth/bloc/auth_bloc.dart';

class AuthScrean extends StatefulWidget {
  const AuthScrean({super.key});

  @override
  State<AuthScrean> createState() => _AuthScreanState();
}

class _AuthScreanState extends State<AuthScrean> {
  final TextEditingController usernameController =
      TextEditingController(text: "mahdinkh77@gmail.com");
  final TextEditingController passwordController =
      TextEditingController(text: "123456");

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
        body: BlocProvider<AuthBloc>(
          create: ((context) {
            final bloc = AuthBloc(authRepository);
            bloc.add(AuthStarted());
            bloc.stream.forEach((state) {
              if (state is AuthSuccess) {
                Navigator.of(context).pop();
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.exception.toString())));
              }
            });
            return bloc;
          }),
          child:
              BlocBuilder<AuthBloc, AuthState>(buildWhen: (previous, current) {
            return current is AuthLoading ||
                current is AuthInitial ||
                current is AuthError;
          }, builder: (BuildContext context, state) {
            return Padding(
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
                  Text(state.isLoginMode ? 'خوش امدید' : "ثبت نام",
                      style:
                          const TextStyle(color: onBackground, fontSize: 22)),
                  const SizedBox(height: 16),
                  Text(
                      state.isLoginMode
                          ? 'لطفا وارد حساب کاربردی خود شوید'
                          : 'ایمیل و رمز عبور خود را تعیین کنید',
                      style:
                          const TextStyle(color: onBackground, fontSize: 16)),
                  const SizedBox(height: 24),
                  TextField(
                      controller: usernameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          const InputDecoration(label: Text('ادرس ایمیل   '))),
                  const SizedBox(height: 16),
                  _PasswordTextField(
                      onBackground: onBackground,
                      controller: passwordController),
                  const SizedBox(height: 16),
                  ElevatedButton(
                      onPressed: () {
                        authRepository.signUp(usernameController.text.trim(),
                            passwordController.text.trim());
                      },
                      child: state is AuthLoading
                          ? const CircularProgressIndicator()
                          : Text(state.isLoginMode ? 'ورود' : 'ثبت نام')),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<AuthBloc>(context)
                          .add(AuthModeChanfeIsClicked());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.isLoginMode
                              ? "حساب کاربری ندارید ؟"
                              : "حساب کاریری دارید",
                          style:
                              TextStyle(color: onBackground.withOpacity(0.7)),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          state.isLoginMode ? 'ثبت نام' : "ورود",
                          style: TextStyle(
                              color: themeData.colorScheme.primary,
                              decoration: TextDecoration.underline),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField(
      {required this.onBackground, required this.controller});

  final Color onBackground;
  final TextEditingController controller;

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool obsecureText = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.controller,
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
