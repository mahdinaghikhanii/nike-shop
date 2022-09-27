import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final String message;
  final Widget callToAction;
  final Widget image;
  const EmptyView(
      {super.key,
      required this.message,
      required this.callToAction,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        image,
        Padding(
          padding:
              const EdgeInsets.only(left: 32, right: 32, top: 24, bottom: 16),
          child: Text(
            message,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        callToAction,
      ],
    );
  }
}
