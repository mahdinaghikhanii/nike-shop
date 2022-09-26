import 'package:nike/data/entity/cart_item.dart';

class CartResponse {
  final List<CartIteamEntity> cartItems;
  final int payablePrice;
  final int totalPrice;
  final int shippingCost;

  CartResponse(
      this.cartItems, this.payablePrice, this.totalPrice, this.shippingCost);
}
