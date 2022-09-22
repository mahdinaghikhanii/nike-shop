import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/exceptions.dart';
import '../../../data/model/baner_model.dart';
import '../../../data/model/product_model.dart';
import '../../../data/repo/baner_repository.dart';
import '../../../data/repo/product_repository.dart';

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
              popularProducts: popularProducts,
              latestproducts: latesProducts));
        } catch (e) {
          emit(HomeError(exception: e is AppException ? e : AppException()));
        }
      }
    });
  }
}
