import 'package:flutter/material.dart';
import 'package:nike/data/model/product_model.dart';
import 'package:nike/ui/widgets/image.dart';

class ProductDetailscreen extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductDetailscreen({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.width * 0.8,
              flexibleSpace: ImageLoadingService(imgUrl: productEntity.image))
        ],
      ),
    );
  }
}
