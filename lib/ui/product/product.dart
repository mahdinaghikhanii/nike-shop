import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../common/utils.dart';
import '../../data/entity/product_model.dart';
import 'details.dart';
import '../widgets/image.dart';

class ProductIteam extends StatelessWidget {
  final ProductEntity product;
  final BorderRadius borderRadius;
  const ProductIteam(
      {super.key, required this.product, required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) =>
                    ProductDetailscreen(productEntity: product))));
          },
          child: SizedBox(
            width: 176,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  SizedBox(
                    width: 176,
                    height: 189,
                    child: ImageLoadingService(
                      imgUrl: product.image.toString(),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: const Icon(CupertinoIcons.heart, size: 20),
                    ),
                  )
                ]),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(product.title,
                        maxLines: 1, overflow: TextOverflow.clip)),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Text(product.previousPrice.withPriceLabel.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(decoration: TextDecoration.lineThrough)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                  child: Text(product.price.withPriceLabel.toString()),
                )
              ],
            ),
          ),
        ));
  }
}
