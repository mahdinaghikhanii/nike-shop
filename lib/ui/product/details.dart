import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../common/utils.dart';
import '../../data/entity/product_model.dart';
import '../../theme.dart';
import 'comment/comment_list.dart';
import '../widgets/image.dart';

class ProductDetailscreen extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductDetailscreen({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: FloatingActionButton.extended(
              onPressed: () {}, label: const Text('افزودن به سبد خرید')),
        ),
        body: SafeArea(
          child: CustomScrollView(
            physics: defaultScrollPhysics,
            slivers: [
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.width * 0.8,
                flexibleSpace: ImageLoadingService(imgUrl: productEntity.image),
                foregroundColor: LightThemeColors.primaryTextColor,
                actions: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(CupertinoIcons.heart))
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            productEntity.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                productEntity.previousPrice.withPriceLabel,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .apply(
                                        decoration: TextDecoration.lineThrough),
                              ),
                              Text(productEntity.price.withPriceLabel)
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                          'این کتونی شدیدا برای دویدن و راه رفتن مناسب هست و تقریبا. هیچ فشار مخربی رو نمیذارد به پا و زانوان شما انتقال داده شود',
                          style: TextStyle(height: 1.4)),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "نظرات کاربران",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          TextButton(
                              onPressed: () {}, child: const Text("ثبت نظر"))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              CommnetList(productid: productEntity.id)
            ],
          ),
        ),
      ),
    );
  }
}
