import 'package:dio/dio.dart';
import 'package:nike/data/common/http_response_validator.dart';
import 'package:nike/data/model/baner_model.dart';

abstract class IBanerDataSeource {
  Future<List<BannerEntity>> getall();
}

class BanerRemoteDataSource
    with HttpResponseValidator
    implements IBanerDataSeource {
  final Dio htttpClient;
  BanerRemoteDataSource(this.htttpClient);
  @override
  Future<List<BannerEntity>> getall() async {
    final respone = await htttpClient.get('banner/slider');
    validateResponse(respone);

    var banner = <BannerEntity>[];

    (respone.data as List).forEach((jsonObject) {
      banner.add(BannerEntity.fromJson(jsonObject));
    });
    return banner;
  }
}
