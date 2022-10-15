import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/utils.dart';
import '../../data/entity/cart_item.dart';
import '../widgets/image.dart';

class CartItem extends StatelessWidget {
  const CartItem(
      {super.key,
      required this.data,
      required this.onDeleteButtonClikec,
      required this.onInreateButtonClick,
      required this.onDecreaseButtonClick});

  final CartIteamEntity data;
  final GestureTapCallback onDeleteButtonClikec;
  final GestureTapCallback onInreateButtonClick;
  final GestureTapCallback onDecreaseButtonClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
          ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                    width: 100,
                    height: 100,
                    child: ImageLoadingService(
                      imgUrl: data.product.image,
                      borderRadius: BorderRadius.circular(4),
                    )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data.product.title,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('تعداد'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: onInreateButtonClick,
                            icon: const Icon(CupertinoIcons.plus_rectangle)),
                        data.changeCountLoading
                            ? const CupertinoActivityIndicator()
                            : Text(
                                data.count.toString(),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                        IconButton(
                            onPressed: onDecreaseButtonClick,
                            icon: const Icon(CupertinoIcons.minus_rectangle)),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data.product.previousPrice.withPriceLabel,
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough),
                    ),
                    Text(
                      data.product.previousPrice.withPriceLabel,
                    )
                  ],
                )
              ],
            ),
          ),
          const Divider(height: 1),
          data.deleteButtonLoadig
              ? const SizedBox(
                  height: 48,
                  child: Center(child: CupertinoActivityIndicator()))
              : TextButton(
                  onPressed: onDeleteButtonClikec,
                  child: const Text('حذف از سبد خرید'))
        ],
      ),
    );
  }
}
