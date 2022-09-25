import 'package:dio/dio.dart';
import '../entity/cart_item.dart';
import '../entity/cart_response.dart';

abstract class ICartDataSource {
  Future<CartResponse> addToCart(int productId);
  Future<CartResponse> changeCount(int cartItemId);
  Future<void> delete(int cartItemId);
  Future<int> count();
  Future<List<CartIteamEntity>> getAll();
}

class CartRemoteDataSource implements ICartDataSource {
  final Dio httpClient;
  CartRemoteDataSource(this.httpClient);

  @override
  Future<CartResponse> addToCart(int productId) async {
    final respone =
        await httpClient.post('cart/add', data: {"product_id": productId});

    print(respone.data);

    return CartResponse.fromJson(respone.data);
  }

  @override
  Future<CartResponse> changeCount(int cartItemId) {
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
