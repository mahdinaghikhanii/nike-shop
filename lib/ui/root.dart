import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/repo/cart_repository.dart';
import 'widgets/badge.dart';
import '../data/repo/auth_repository.dart';
import 'cart/cart.dart';
import 'home/home.dart';

const int homeIndex = 0;
const int cartIndex = 1;
const int profileIndex = 2;

class RootScrean extends StatefulWidget {
  const RootScrean({super.key});

  @override
  State<RootScrean> createState() => _RootScreanState();
}

class _RootScreanState extends State<RootScrean> {
  int selectedScreenIndex = homeIndex;
  final List<int> _history = [];

  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _cartKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    homeIndex: _homeKey,
    cartIndex: _cartKey,
    profileIndex: _profileKey,
  };

  Future<bool> _onWillPop() async {
    final NavigatorState currentSelectedTabNavigatorState =
        map[selectedScreenIndex]!.currentState!;
    if (currentSelectedTabNavigatorState.canPop()) {
      currentSelectedTabNavigatorState.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedScreenIndex = _history.last;
        _history.removeLast();
      });
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          body: IndexedStack(
            index: selectedScreenIndex,
            children: [
              _navigator(_homeKey, homeIndex, const HomeScrean()),
              _navigator(_cartKey, cartIndex, const CartScrean()),
              _navigator(
                  _profileKey,
                  profileIndex,
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              authRepository.signOut();
                              CartRepository.cartItemCountNotifier.value = 0;
                            },
                            child: const Text('خروج'))
                      ],
                    ),
                  ))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home), label: "خانه"),
              BottomNavigationBarItem(
                  icon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(CupertinoIcons.cart),
                      Positioned(
                          right: -10,
                          child: ValueListenableBuilder<int>(
                              valueListenable:
                                  CartRepository.cartItemCountNotifier,
                              builder: ((context, value, child) {
                                return Badge(value: value);
                              })))
                    ],
                  ),
                  label: "سبد خرید"),
              const BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person), label: "پروفایل"),
            ],
            currentIndex: selectedScreenIndex,
            onTap: (selectIndex) {
              setState(() {
                selectedScreenIndex = selectIndex;
              });
            },
          )),
    );
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => Offstage(
                    offstage: selectedScreenIndex != index, child: child)));
  }

  @override
  void initState() {
    cartRepository.count();

    super.initState();
  }
}
