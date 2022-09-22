part of 'comment_list_bloc_bloc.dart';

abstract class CommentListBlocState extends Equatable {
  const CommentListBlocState();
  
  @override
  List<Object> get props => [];
}

class CommentListBlocInitial extends CommentListBlocState {}
