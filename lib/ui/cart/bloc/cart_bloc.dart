import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/common/exceptions.dart';
import 'package:nike/data/entity/cart_response.dart';
import 'package:nike/data/repo/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepository cartRepository;
  CartBloc(this.cartRepository) : super(CartLoading()) {
    on<CartEvent>((event, emit) async {
      if (event is CartStarted) {
        try {
          emit(CartLoading());
          final result = await cartRepository.getAll();
          emit(CartSuccess(result));
        } catch (e) {
          emit(CartError(AppException()));
        }
      }
    });
  }
}
