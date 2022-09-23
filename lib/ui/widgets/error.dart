import 'package:flutter/material.dart';

import '../../common/exceptions.dart';

class AppErrorWidget extends StatelessWidget {
  final AppException appException;
  final VoidCallback ontap;
  const AppErrorWidget(
      {super.key, required this.appException, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(appException.message),
        ElevatedButton(onPressed: ontap, child: const Text("Reafresh "))
      ],
    ));
  }
}
