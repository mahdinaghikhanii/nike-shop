import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/ui/product/comment/bloc/comment_list_bloc_bloc.dart';

class CommnetList extends StatelessWidget {
  const CommnetList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) {
      final CommentListBlocBloc bloc = CommentListBlocBloc();
      return bloc;
    });
  }
}
