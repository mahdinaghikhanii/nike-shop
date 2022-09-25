import 'package:flutter/material.dart';

import '../../data/repo/auth_repository.dart';
import '../auth/auth.dart';

class CartScrean extends StatelessWidget {
  const CartScrean({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('سبد خرید'),
        ),
        body: ValueListenableBuilder(
          valueListenable: AuthRepository.authChangeNotifier,
          builder: (BuildContext context, authState, Widget? child) {
            bool isAuthenticated =
                authState != null && authState.accessToken.isNotEmpty;
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(isAuthenticated
                      ? 'خوش امدید'
                      : "لطفا وارد حساب کاریری خود شوید"),
                  isAuthenticated
                      ? ElevatedButton(
                          onPressed: () {
                            authRepository.signOut();
                          },
                          child: const Text('خروج'))
                      : ElevatedButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                    builder: (context) => const AuthScrean()));
                          },
                          child: const Text('ورود')),
                  ElevatedButton(
                      onPressed: () async {
                        await authRepository.refReshToken();
                      },
                      child: const Text('reafresh Token'))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
