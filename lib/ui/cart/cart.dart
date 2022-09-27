import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/data/repo/cart_repository.dart';
import 'package:nike/ui/cart/bloc/cart_bloc.dart';

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
        body: BlocProvider<CartBloc>(create: (context) {
          final bloc = CartBloc(cartRepository);
          bloc.add(CartStarted());
          return bloc;
        }, child: BlocBuilder<CartBloc, CartState>(builder: ((context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is CartError) {
            return Center(
              child: Text(state.exception.message),
            );
          } else if (state is CartSuccess) {
            return ListView.builder(
                itemCount: state.cartResponse.cartItems.length,
                itemBuilder: ((context, index) {
                  return Container(
                    margin: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(color: Colors.blue),
                  );
                }));
          } else {
            throw "current cart state is not valid";
          }
        }))),
        // body: ValueListenableBuilder(
        //   valueListenable: AuthRepository.authChangeNotifier,
        //   builder: (BuildContext context, authState, Widget? child) {
        //     bool isAuthenticated =
        //         authState != null && authState.accessToken.isNotEmpty;
        //     return SizedBox(
        //       width: MediaQuery.of(context).size.width,
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Text(isAuthenticated
        //               ? 'خوش امدید'
        //               : "لطفا وارد حساب کاریری خود شوید"),
        //           isAuthenticated
        //               ? ElevatedButton(
        //                   onPressed: () {
        //                     authRepository.signOut();
        //                   },
        //                   child: const Text('خروج'))
        //               : ElevatedButton(
        //                   onPressed: () {
        //                     Navigator.of(context, rootNavigator: true).push(
        //                         MaterialPageRoute(
        //                             builder: (context) => const AuthScrean()));
        //                   },
        //                   child: const Text('ورود')),
        //           ElevatedButton(
        //               onPressed: () async {
        //                 await authRepository.refReshToken();
        //               },
        //               child: const Text('reafresh Token'))
        //         ],
        //       ),
        //     );
        //   },
        // ),
      ),
    );
  }
}
