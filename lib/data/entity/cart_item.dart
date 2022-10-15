import 'product_model.dart';

class CartIteamEntity {
  final ProductEntity product;
  final int id;
  int count;
  bool deleteButtonLoadig = false;
  bool changeCountLoading = false;

  CartIteamEntity.fromJson(Map<String, dynamic> json)
      : product = ProductEntity.fromJson(json['product']),
        id = json['cart_item_id'],
        count = json['count'];

  static List<CartIteamEntity> parseJsonArray(List<dynamic> jsonArray) {
    final List<CartIteamEntity> cartItems = [];
    for (var element in jsonArray) {
      cartItems.add(CartIteamEntity.fromJson(element));
    }
    return cartItems;
  }
}
