import 'product_model.dart';

class CartIteamEntity {
  final ProductEntity product;
  final int id;
  final int count;

  CartIteamEntity.fromJson(Map<String, dynamic> json)
      : product = ProductEntity.fromJson(json),
        id = json['cart_item_id'],
        count = json['count'];
}
