import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'price_info.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../auth/auth.dart';
import '../widgets/empty_state.dart';

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
  final RefreshController _refreshController = RefreshController();
  CartBloc? cartBloc;
  StreamSubscription? stateStreamSubscription;
  bool stateIsSuccess = false;

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
    stateStreamSubscription?.cancel();
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Visibility(
          visible: stateIsSuccess,
          child: Container(
            margin: const EdgeInsets.only(left: 48, right: 48),
            width: MediaQuery.of(context).size.width,
            child: FloatingActionButton.extended(
                onPressed: () {}, label: const Text("پرداخت")),
          ),
        ),
        body: BlocProvider<CartBloc>(create: (context) {
          final bloc = CartBloc(cartRepository);
          cartBloc = bloc;

          stateStreamSubscription = bloc.stream.listen((state) {
            setState(() {
              stateIsSuccess = state is CartSuccess;
            });

            if (_refreshController.isRefresh) {
              if (state is CartSuccess) {
                _refreshController.refreshCompleted();
              }
            } else if (state is CartError) {
              _refreshController.refreshFailed();
            }
          });
          bloc.add(CartStarted(AuthRepository.authChangeNotifier.value));
          return bloc;
        }, child: BlocBuilder<CartBloc, CartState>(builder: ((context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is CartError) {
            return Center(
              child: EmptyView(
                  message: state.exception.message,
                  callToAction: ElevatedButton(
                      onPressed: () {}, child: const Text('بازیابی')),
                  image: SvgPicture.asset(
                    "assets/img/no_data.svg",
                    width: 200,
                    height: 200,
                  )),
            );
          } else if (state is CartSuccess) {
            return SmartRefresher(
              controller: _refreshController,
              header: const ClassicHeader(
                completeText: "با موفقیت انجام شد",
                refreshingText: "در حال به روز رسانی",
                idleText: "برای به روز رسانی پایین بکشید",
                releaseText: "رها کنید",
                failedText: "خطای نا مشخص",
                spacing: 2,
              ),
              onRefresh: () {
                cartBloc?.add(CartStarted(
                    AuthRepository.authChangeNotifier.value,
                    isRefreshing: true));
              },
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemBuilder: ((context, index) {
                  if (index < state.cartResponse.cartItems.length) {
                    final data = state.cartResponse.cartItems[index];
                    return CartItem(
                      data: data,
                      onDeleteButtonClikec: () {
                        cartBloc?.add(CartDeleteButtonClicked(
                          data.id,
                        ));
                      },
                      onDecreaseButtonClick: () {
                        if (data.count > 1) {
                          cartBloc?.add(DecreaseCountButtonClick(data.id));
                        }
                      },
                      onInreateButtonClick: () {
                        cartBloc?.add(IncreaseCountButtonClick(data.id));
                      },
                    );
                  } else {
                    return PriceInfo(
                      payablePrice: state.cartResponse.payablePrice,
                      shippingCost: state.cartResponse.shippingCost,
                      totalPrice: state.cartResponse.totalPrice,
                    );
                  }
                }),
                itemCount: state.cartResponse.cartItems.length + 1,
              ),
            );
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
      ),
    );
  }
}
