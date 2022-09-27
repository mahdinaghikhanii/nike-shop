import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nike/ui/auth/auth.dart';
import 'package:nike/ui/widgets/empty_state.dart';

import 'cart_item.dart';

import '../../data/repo/auth_repository.dart';
import '../../data/repo/cart_repository.dart';

import 'bloc/cart_bloc.dart';

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
            return EmptyView(
                message: state.exception.message,
                callToAction: ElevatedButton(
                    onPressed: () {}, child: const Text('بازیابی')),
                image: SvgPicture.asset("assets/img/not_data.svg"));
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
          } else if (state is CartItemEmpty) {
            return EmptyView(
                message: "تا کنون هیج ایتمی به سبد خرید خود اضافه نکرده اید !",
                callToAction: Container(),
                image: SvgPicture.asset(
                  'assets/img/empty_cart.svg',
                  width: 200,
                  height: 200,
                ));
          } else if (state is CartAuthReauired) {
            return EmptyView(
              callToAction: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                            builder: (context) => const AuthScrean()));
                  },
                  child: const Text('ورود به حساب کاربری')),
              image:
                  SvgPicture.asset("assets/img/auth_required.svg", height: 200),
              message: "برای مشاهده سبد خرید ابتدا وارد حساب کاریری شوید",
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
