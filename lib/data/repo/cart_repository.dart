import '../../common/http_client.dart';
import '../entity/add_to_cart_respone.dart';
import '../entity/cart_response.dart';
import '../source/cart_data_source.dart';

abstract class ICartRepository extends ICartDataSource {}

final cartRepository = CartRepository(CartRemoteDataSource(httpClint));

class CartRepository implements ICartRepository {
  ICartDataSource iCartDataSource;
  CartRepository(this.iCartDataSource);
  @override
  Future<AddToCartResponse> addToCart(int productId) {
    return iCartDataSource.addToCart(productId);
  }

  @override
  Future<AddToCartResponse> changeCount(int cartItemId) {
    return iCartDataSource.changeCount(cartItemId);
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
  Future<CartResponse> getAll() => iCartDataSource.getAll();
}
