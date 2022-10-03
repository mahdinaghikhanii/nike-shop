import 'package:flutter/material.dart';
import 'package:nike/common/utils.dart';

class PriceInfo extends StatelessWidget {
  final int payablePrice;
  final int shippingCost;
  final int totalPrice;
  const PriceInfo(
      {super.key,
      required this.payablePrice,
      required this.shippingCost,
      required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 24, 8, 0),
          child: Text(
            "جزعیات خرید",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(8, 8, 8, 32),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.05))
              ]),
          child: Column(
            children: [
              _TitleTextAndInfoPrice(
                  shippingCost: shippingCost,
                  title: "مبلخ کل خرید",
                  infoPrice: totalPrice),
              const Divider(height: 1),
              _TitleTextAndInfoPrice(
                shippingCost: shippingCost,
                infoPrice: shippingCost,
                title: 'هزینه ارسال',
              ),
              const Divider(height: 1),
              _TitleTextAndInfoPrice(
                  boldText: true,
                  shippingCost: shippingCost,
                  title: 'مبلغ قابل پرداخت',
                  infoPrice: payablePrice)
            ],
          ),
        ),
      ],
    );
  }
}

class _TitleTextAndInfoPrice extends StatelessWidget {
  final String title;
  final int infoPrice;
  final bool boldText;
  const _TitleTextAndInfoPrice(
      {required this.shippingCost,
      required this.title,
      this.boldText = false,
      required this.infoPrice});

  final int shippingCost;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(infoPrice.withPriceLabel,
              style: boldText
                  ? const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)
                  : const TextStyle()),
        ],
      ),
    );
  }
}
