import '../../common/http_client.dart';
import '../entity/cart_item.dart';
import '../entity/cart_response.dart';
import '../source/cart_data_source.dart';

abstract class ICartRepository extends ICartDataSource {}

final cartRepository = CartRepository(CartRemoteDataSource(httpClint));

class CartRepository implements ICartRepository {
  ICartDataSource iCartDataSource;
  CartRepository(this.iCartDataSource);
  @override
  Future<CartResponse> addToCart(int productId) {
    return iCartDataSource.addToCart(productId);
  }

  @override
  Future<CartResponse> changeCount(int cartItemId) {
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
  Future<List<CartIteamEntity>> getAll() {
    throw UnimplementedError();
  }
}
