import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/exceptions.dart';
import '../../../data/repo/cart_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ICartRepository cartRepository;
  ProductBloc(this.cartRepository) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is CartAddButtonClick) {
        try {
          emit(ProductAddToCartButtonLoading());
          await Future.delayed(const Duration(seconds: 3));
          emit(ProductAddToCartButtonLoading());
          final result = cartRepository.addToCart(event.productId);
          emit(ProductAddToCartSuccess());
        } catch (e) {
          emit(ProductAddToCartError(AppException()));
        }
      }
    });
  }
}
