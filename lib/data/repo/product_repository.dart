import '../../common/http_client.dart';
import '../entity/product_model.dart';
import '../source/product_data_source.dart';

final productRepository = ProductRepository(ProductRemoteDataSource(httpClint));

abstract class IProductRepository {
  Future<List<ProductEntity>> getAll(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRepository implements IProductRepository {
  final IProductDataSource dataSource;
  ProductRepository(this.dataSource);

  @override
  Future<List<ProductEntity>> getAll(int sort) {
    return dataSource.getAll(sort);
  }

  @override
  Future<List<ProductEntity>> search(String searchTerm) {
    return dataSource.search(searchTerm);
  }
}
