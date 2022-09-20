import 'package:dio/dio.dart';
import 'package:nike/common/exceptions.dart';

import '../model/product_model.dart';

abstract class IProductDataSource {
  Future<List<ProductEntity>> getAll(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRemoteDataSource implements IProductDataSource {
  final Dio httpClint;
  ProductRemoteDataSource(this.httpClint);

  @override
  Future<List<ProductEntity>> getAll(int sort) async {
    final respone = await httpClint.get('product/list?sort=$sort');
    validateResponse(respone);
    final products = <ProductEntity>[];
    (respone.data as List).forEach((element) {
      products.add(ProductEntity.fromJson(element));
    });
    return products;
  }

  @override
  Future<List<ProductEntity>> search(String searchTerm) async {
    final respone = await httpClint.get("product/search?q=$searchTerm");
    validateResponse(respone);
    final products = <ProductEntity>[];

    (respone.data as List).forEach((element) {
      products.add(ProductEntity.fromJson(element));
    });
    return products;
  }

  validateResponse(Response response) {
    if (response.statusCode != 200) {
      throw AppException();
    } else {
      return response;
    }
  }
}
