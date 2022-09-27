import 'product_model.dart';

class CartIteamEntity {
  final ProductEntity product;
  final int id;
  final int count;

  CartIteamEntity.fromJson(Map<String, dynamic> json)
      : product = ProductEntity.fromJson(json['product']),
        id = json['cart_item_id'],
        count = json['count'];

  static List<CartIteamEntity> parseJsonArray(List<dynamic> jsonArray) {
    final List<CartIteamEntity> cartItems = [];
    jsonArray.forEach((element) {
      cartItems.add(CartIteamEntity.fromJson(element));
    });
    return cartItems;
  }
}
