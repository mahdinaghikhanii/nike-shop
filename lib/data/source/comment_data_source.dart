import 'package:dio/dio.dart';
import '../common/http_response_validator.dart';
import '../entity/comment.dart';

abstract class IcommentRemoteDataSource {
  Future<List<CommentEntity>> getAll({required int productId});
}

class CommentDataSource
    with HttpResponseValidator
    implements IcommentRemoteDataSource {
  final Dio httpClint;
  CommentDataSource(this.httpClint);
  @override
  Future<List<CommentEntity>> getAll({required int productId}) async {
    final respone = await httpClint.get('comment/list?product_id=9');
    validateResponse(respone);
    final List<CommentEntity> comment = [];
    for (var jsonData in (respone.data as List)) {
      comment.add(CommentEntity.fromJson(jsonData));
    }
    return comment;
  }
}
