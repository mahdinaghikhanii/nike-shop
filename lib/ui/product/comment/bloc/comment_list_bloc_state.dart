part of 'comment_list_bloc_bloc.dart';

abstract class CommentListBlocState extends Equatable {
  const CommentListBlocState();

  @override
  List<Object> get props => [];
}

class CommentListLoadign extends CommentListBlocState {}

class CommentListSucces extends CommentListBlocState {
  final List<CommentEntity> comments;
  const CommentListSucces(this.comments);

  @override
  List<Object> get props => [comments];
}

class CommentListError extends CommentListBlocState {
  final AppException exception;
  const CommentListError(this.exception);

  @override
  List<Object> get props => [exception];
}
