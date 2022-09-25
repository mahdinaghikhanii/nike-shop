import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/cart_repository.dart';
import 'bloc/product_bloc.dart';
import '../../common/utils.dart';
import '../../data/entity/product_model.dart';
import '../../theme.dart';
import 'comment/comment_list.dart';
import '../widgets/image.dart';

class ProductDetailscreen extends StatefulWidget {
  final ProductEntity productEntity;
  const ProductDetailscreen({super.key, required this.productEntity});

  @override
  State<ProductDetailscreen> createState() => _ProductDetailscreenState();
}

class _ProductDetailscreenState extends State<ProductDetailscreen> {
  StreamSubscription<ProductState>? stateSubscription;
  @override
  void dispose() {
    stateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider<ProductBloc>(
        create: (context) {
          final bloc = ProductBloc(cartRepository);
          stateSubscription = bloc.stream.listen((state) {
            if (state is ProductAddToCartSuccess) {
              debugPrint("done Add your cart");
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('با موفقیت به سبد خرید شما اضافه شد')));
            } else if (state is ProductAddToCartError) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.exception.message)));
            }
          });
          return bloc;
        },
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: SizedBox(
            width: MediaQuery.of(context).size.width - 40,
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) => FloatingActionButton.extended(
                  onPressed: () {
                    BlocProvider.of<ProductBloc>(context)
                        .add(CartAddButtonClick(widget.productEntity.id));
                  },
                  label: state is ProductAddToCartButtonLoading
                      ? CupertinoActivityIndicator(
                          color: Theme.of(context).colorScheme.onSecondary,
                        )
                      : const Text('افزودن به سبد خرید')),
            ),
          ),
          body: SafeArea(
            child: CustomScrollView(
              physics: defaultScrollPhysics,
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.width * 0.8,
                  flexibleSpace:
                      ImageLoadingService(imgUrl: widget.productEntity.image),
                  foregroundColor: LightThemeColors.primaryTextColor,
                  actions: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(CupertinoIcons.heart))
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
                              widget.productEntity.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  widget.productEntity.previousPrice
                                      .withPriceLabel,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .apply(
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),
                                Text(widget.productEntity.price.withPriceLabel)
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
                CommnetList(productid: widget.productEntity.id)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
