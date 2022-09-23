import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike/ui/home/home.dart';

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
              _navigator(
                  _cartKey,
                  cartIndex,
                  const Center(
                    child: Text('Cart'),
                  )),
              _navigator(
                  _profileKey,
                  profileIndex,
                  const Center(
                    child: Text('Profile'),
                  )),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home), label: "خانه"),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.cart), label: "سبد خرید"),
              BottomNavigationBarItem(
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
}
