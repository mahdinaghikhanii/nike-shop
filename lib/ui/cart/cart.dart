import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/entity/cart_item.dart';
import 'cart_item.dart';
import '../../common/utils.dart';
import '../../data/repo/auth_repository.dart';
import '../../data/repo/cart_repository.dart';
import '../auth/auth.dart';
import 'bloc/cart_bloc.dart';
import '../widgets/image.dart';

class CartScrean extends StatefulWidget {
  const CartScrean({super.key});

  @override
  State<CartScrean> createState() => _CartScreanState();
}

class _CartScreanState extends State<CartScrean> {
  CartBloc? cartBloc;
  @override
  void initState() {
    super.initState();
    AuthRepository.authChangeNotifier.addListener(authChangeNotifierListener);
  }

  void authChangeNotifierListener() {
    cartBloc!.add(CartAuthInfoChange(AuthRepository.authChangeNotifier.value));
  }

  @override
  void dispose() {
    AuthRepository.authChangeNotifier
        .removeListener(authChangeNotifierListener);
    cartBloc!.close();
    super.dispose();
  }

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
          cartBloc = bloc;
          bloc.add(CartStarted(AuthRepository.authChangeNotifier.value));
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
                  final data = state.cartResponse.cartItems[index];
                  return CartItem(
                    data: data,
                    onDeleteButtonClikec: () {
                      cartBloc?.add(CartDeleteButtonClicked(data.id));
                    },
                  );
                }));
          } else if (state is CartAuthReauired) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("وارد حساب کاریری خود شوید"),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (context) => const AuthScrean()));
                      },
                      child: const Text("ورود"))
                ],
              ),
            );
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
