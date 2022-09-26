class AddToCartResponse {
  final int productId;
  final int cartIteamId;
  final int count;

  AddToCartResponse.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'],
        cartIteamId = json['id'],
        count = json['count'];
}
