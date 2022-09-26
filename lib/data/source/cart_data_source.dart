import 'package:dio/dio.dart';

import '../entity/cart_item.dart';
import '../entity/add_to_cart_respone.dart';

abstract class ICartDataSource {
  Future<AddToCartResponse> addToCart(int productId);
  Future<AddToCartResponse> changeCount(int cartItemId);
  Future<void> delete(int cartItemId);
  Future<int> count();
  Future<List<CartIteamEntity>> getAll();
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
  Future<AddToCartResponse> changeCount(int cartItemId) {
    throw UnimplementedError();
  }

  @override
  Future<int> count() {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int cartItemId) {
    throw UnimplementedError();
  }

  @override
  Future<List<CartIteamEntity>> getAll() {
    throw UnimplementedError();
  }
}
