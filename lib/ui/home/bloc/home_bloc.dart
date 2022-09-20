import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nike/common/exceptions.dart';
import 'package:nike/data/model/baner_model.dart';
import 'package:nike/data/model/product_model.dart';
import 'package:nike/data/repo/baner_repository.dart';
import 'package:nike/data/repo/product_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBanerRepository banerRepository;
  final IProductRepository productRepository;
  HomeBloc(this.banerRepository, this.productRepository)
      : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStarted || event is HomeRefresh) {
        try {
          emit(HomeLoading());
          final banners = await banerRepository.getall();
          final latesProducts =
              await productRepository.getAll(ProductSort.latest);
          final popularProducts =
              await productRepository.getAll(ProductSort.popular);

          emit(HomeSuccess(
              banners: banners,
              products: latesProducts,
              popularProducts: popularProducts));
        } catch (e) {
          emit(HomeError(exception: e is AppException ? e : AppException()));
        }
      }
    });
  }
}
