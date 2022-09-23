import '../../common/http_client.dart';
import '../entity/comment.dart';
import '../source/comment_data_source.dart';

final commentRepository = CommentRepository(CommentDataSource(httpClint));

abstract class ICommentRepository {
  Future<List<CommentEntity>> getAll({required int productId});
}

class CommentRepository implements ICommentRepository {
  final IcommentRemoteDataSource dataSource;
  CommentRepository(this.dataSource);

  @override
  Future<List<CommentEntity>> getAll({required int productId}) {
    return dataSource.getAll(productId: productId);
  }
}
