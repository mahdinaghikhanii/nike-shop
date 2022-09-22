part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final AppException exception;
  const HomeError({required this.exception});

  // props in komako mikone age error rokhdad shabih hamon eror ghabli bod dashighan
  // nemizare dobare safe load beshe va perfomance appliaction bala mire
  @override
  List<Object> get props => [exception];
}

class HomeSuccess extends HomeState {
  final List<BannerEntity> banners;
  final List<ProductEntity> latestproducts;
  final List<ProductEntity> popularProducts;

  const HomeSuccess(
      {required this.banners,
      required this.latestproducts,
      required this.popularProducts});
}
