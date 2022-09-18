import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("فروشگاه نایک"),
          centerTitle: false,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "  خوبم سلام",
              ),
            ),
            Center(
              child: Text(
                "  خوبم سلام",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ));
  }
}
