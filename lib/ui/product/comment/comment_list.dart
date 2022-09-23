import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/comment_repository.dart';
import '../../widgets/error.dart';
import 'bloc/comment_list_bloc_bloc.dart';
import 'comment.dart';

class CommnetList extends StatelessWidget {
  final int productid;
  const CommnetList({super.key, required this.productid});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) {
      final CommentListBloc bloc =
          CommentListBloc(repository: commentRepository, productId: productid);
      bloc.add(CommentListStarted());
      return bloc;
    }, child: BlocBuilder<CommentListBloc, CommentListBlocState>(
        builder: ((context, state) {
      if (state is CommentListSucces) {
        return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return CommentIteam(comment: state.comments[index]);
        }, childCount: state.comments.length));
      } else if (state is CommentListLoadign) {
        return const SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is CommentListError) {
        return AppErrorWidget(
            appException: state.exception,
            ontap: () => BlocProvider.of<CommentListBloc>(context)
                .add(CommentListStarted()));
      } else {
        throw "we have problems here developer !";
      }
    })));
  }
}
