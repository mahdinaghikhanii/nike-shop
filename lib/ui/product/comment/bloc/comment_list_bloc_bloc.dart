import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/exceptions.dart';
import '../../../../data/entity/comment.dart';
import '../../../../data/repo/comment_repository.dart';

part 'comment_list_bloc_event.dart';
part 'comment_list_bloc_state.dart';

class CommentListBloc extends Bloc<CommentListBlocEvent, CommentListBlocState> {
  final ICommentRepository repository;
  final int productId;
  CommentListBloc({required this.repository, required this.productId})
      : super(CommentListLoadign()) {
    on<CommentListBlocEvent>((event, emit) async {
      if (event is CommentListStarted) {
        try {
          emit(CommentListLoadign());
          final comment = await repository.getAll(productId: productId);
          emit(CommentListSucces(comment));
        } catch (e) {
          emit(CommentListError(AppException()));
        }
      }
    });
  }
}
