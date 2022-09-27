import 'package:nike/data/entity/cart_item.dart';

class CartResponse {
  final List<CartIteamEntity> cartItems;
  final int payablePrice;
  final int totalPrice;
  final int shippingCost;

  CartResponse.fromJson(Map<String, dynamic> json)
      : cartItems = CartIteamEntity.parseJsonArray(
          json['cart_items'],
        ),
        payablePrice = json['payable_price'],
        totalPrice = json['total_price'],
        shippingCost = json['shipping_cost'];
}
