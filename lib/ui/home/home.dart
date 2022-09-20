import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/data/repo/baner_repository.dart';
import 'package:nike/data/repo/product_repository.dart';
import 'package:nike/ui/home/bloc/home_bloc.dart';

class HomeScrean extends StatelessWidget {
  const HomeScrean({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) {
        final homebloc = HomeBloc(bannerRepository, productRepository);
        homebloc.add(HomeStarted());
        return homebloc;
      }),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeSuccess) {
                return ListView.builder(
                    itemCount: 5,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 100),
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return Image.asset(
                            "assets/img/nike_logo.png",
                            height: 32,
                          );
                        default:
                          return Container();
                      }
                    });
              } else if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeError) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.exception.message),
                    ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                        },
                        child: const Text("Reafresh "))
                  ],
                ));
              } else {
                throw Exception("state is not supported");
              }
            },
          ),
        ),
      ),
    );
  }
}
