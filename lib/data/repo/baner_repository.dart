import '../common/http_client.dart';
import '../model/baner_model.dart';

import '../source/baner_data_source.dart';

final bannerRepository = BanerRepository(BanerRemoteDataSource(httpClint));

abstract class IBanerRepository {
  Future<List<BannerEntity>> getall();
}

class BanerRepository implements IBanerRepository {
  final IBanerDataSeource iBanerDataSeource;
  BanerRepository(this.iBanerDataSeource);

  @override
  Future<List<BannerEntity>> getall() {
    return iBanerDataSeource.getall();
  }
}
