class CartResponse {
  final int productId;
  final int cartIteamId;
  final int count;

  CartResponse.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'],
        cartIteamId = json['id'],
        count = json['count'];
}
