import 'package:dio/dio.dart';

import '../entity/add_to_cart_respone.dart';
import '../entity/cart_response.dart';

abstract class ICartDataSource {
  Future<AddToCartResponse> addToCart(int productId);
  Future<AddToCartResponse> changeCount(int cartItemId, int count);
  Future<void> delete(int cartItemId);
  Future<int> count();
  Future<CartResponse> getAll();
}

class CartRemoteDataSource implements ICartDataSource {
  final Dio httpClient;
  CartRemoteDataSource(this.httpClient);

  @override
  Future<AddToCartResponse> addToCart(int productId) async {
    final respone =
        await httpClient.post('cart/add', data: {"product_id": productId});

    return AddToCartResponse.fromJson(respone.data);
  }

  @override
  Future<AddToCartResponse> changeCount(int cartItemId, int count) async {
    final respone = await httpClient.post('cart/changeCount', data: {
      "cart_item_id": cartItemId,
      "count": count,
    });
    return AddToCartResponse.fromJson(respone.data);
  }

  @override
  Future<int> count() {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int cartItemId) async {
    await httpClient.post('cart/remove', data: {"cart_item_id": cartItemId});
  }

  @override
  Future<CartResponse> getAll() async {
    final respone = await httpClient.get('cart/list');
    return CartResponse.fromJson(respone.data);
  }
}
