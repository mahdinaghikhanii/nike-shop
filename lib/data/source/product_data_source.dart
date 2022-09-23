import 'package:dio/dio.dart';

import '../common/http_response_validator.dart';
import '../entity/product_model.dart';

abstract class IProductDataSource {
  Future<List<ProductEntity>> getAll(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRemoteDataSource
    with HttpResponseValidator
    implements IProductDataSource {
  final Dio httpClint;
  ProductRemoteDataSource(this.httpClint);

  @override
  Future<List<ProductEntity>> getAll(int sort) async {
    final respone = await httpClint.get('product/list?sort=$sort');
    validateResponse(respone);
    final products = <ProductEntity>[];
    for (var element in (respone.data as List)) {
      products.add(ProductEntity.fromJson(element));
    }
    return products;
  }

  @override
  Future<List<ProductEntity>> search(String searchTerm) async {
    final respone = await httpClint.get("product/search?q=$searchTerm");
    validateResponse(respone);
    final products = <ProductEntity>[];

    for (var element in (respone.data as List)) {
      products.add(ProductEntity.fromJson(element));
    }
    return products;
  }
}
