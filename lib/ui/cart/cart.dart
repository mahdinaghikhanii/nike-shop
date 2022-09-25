import 'package:flutter/material.dart';

import 'package:nike/data/repo/auth_repository.dart';
import 'package:nike/ui/auth/auth.dart';

class CartScrean extends StatelessWidget {
  const CartScrean({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('سبد خرید'),
      ),
      body: ValueListenableBuilder(
        valueListenable: AuthRepository.authChangeNotifier,
        builder: (BuildContext context, authState, Widget? child) {
          bool isAuthenticated =
              authState != null && authState.accessToken.isNotEmpty;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(isAuthenticated
                  ? 'خوش امدید'
                  : "لطفا وارد حساب کاریری خود شوید"),
              if (!isAuthenticated)
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                              builder: (context) => const AuthScrean()));
                    },
                    child: const Text('ورود'))
            ],
          );
        },
      ),
    );
  }
}
