import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../root.dart';
import '../../../common/exceptions.dart';
import '../../../data/entity/auth_info.dart';
import '../../../data/entity/cart_response.dart';
import '../../../data/repo/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepository cartRepository;
  CartBloc(this.cartRepository) : super(CartLoading()) {
    on<CartEvent>((event, emit) async {
      if (event is CartStarted) {
        final authInfo = event.authInfo;
        if (authInfo == null || authInfo.accessToken.isEmpty) {
          emit(CartAuthReauired());
        } else {
          await loadCartItems(emit);
        }
      } else if (event is CartDeleteButtonClicked) {
        try {
          if (state is CartSuccess) {
            final successState = (state as CartSuccess);
            final cartItem = successState.cartResponse.cartItems
                .firstWhere((element) => element.id == event.crtItemId);
            cartItem.deleteButtonLoadig = true;
          }
          await cartRepository.delete(event.crtItemId);
          if (state is CartSuccess) {
            final successState = (state as CartSuccess);
            successState.cartResponse.cartItems
                .removeWhere((element) => element.id == event.crtItemId);

            if (successState.cartResponse.cartItems.isEmpty) {
              emit(CartItemEmpty());
            } else {
              emit(CartSuccess(successState.cartResponse));
            }
          }
        } catch (e) {
          emit(CartError(AppException()));
        }
      } else if (event is CartAuthInfoChange) {
        if (event.authInfo == null || event.authInfo!.accessToken.isEmpty) {
          emit(CartAuthReauired());
        } else {
          if (state is CartAuthReauired) {
            await loadCartItems(emit);
          }
        }
      }
    });
  }
  Future<void> loadCartItems(Emitter<CartState> emit) async {
    try {
      emit(CartLoading());
      final result = await cartRepository.getAll();
      if (result.cartItems.isEmpty) {
        emit(CartItemEmpty());
      } else {
        emit(CartSuccess(result));
      }
    } catch (e) {
      emit(CartError(AppException()));
    }
  }
}
