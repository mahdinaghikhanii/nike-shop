import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'comment_list_bloc_event.dart';
part 'comment_list_bloc_state.dart';

class CommentListBlocBloc
    extends Bloc<CommentListBlocEvent, CommentListBlocState> {
  CommentListBlocBloc() : super(CommentListBlocInitial()) {
    on<CommentListBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
