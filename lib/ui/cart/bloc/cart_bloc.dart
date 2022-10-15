import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/exceptions.dart';
import '../../../data/entity/auth_info.dart';
import '../../../data/entity/cart_response.dart';
import '../../../data/repo/cart_repository.dart';
import '../../root.dart';

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
          await loadCartItems(emit, event.isRefreshing);
        }
      } else if (event is CartDeleteButtonClicked) {
        try {
          if (state is CartSuccess) {
            final successState = (state as CartSuccess);
            final cartItem = successState.cartResponse.cartItems
                .firstWhere((element) => element.id == event.crtItemId);
            cartItem.deleteButtonLoadig = true;

            emit(CartSuccess(successState.cartResponse));
          }

          await cartRepository.delete(event.crtItemId);
          await cartRepository.count();
          if (state is CartSuccess) {
            final successState = (state as CartSuccess);
            successState.cartResponse.cartItems
                .removeWhere((element) => element.id == event.crtItemId);

            if (successState.cartResponse.cartItems.isEmpty) {
              emit(CartItemEmpty());
            } else {
              emit(calculatePriceInfo(successState.cartResponse));
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
            await loadCartItems(emit, false);
          }
        }
      } else if (event is IncreaseCountButtonClick ||
          event is DecreaseCountButtonClick) {
        try {
          int cartItemId = 0;
          if (event is IncreaseCountButtonClick) {
            cartItemId = event.cartItemId;
          } else if (event is DecreaseCountButtonClick) {
            cartItemId = event.cartItemId;
          }

          if (state is CartSuccess) {
            final successState = (state as CartSuccess);
            final index = successState.cartResponse.cartItems
                .indexWhere((element) => element.id == cartItemId);
            successState.cartResponse.cartItems[index].changeCountLoading =
                true;

            emit(CartSuccess(successState.cartResponse));
            await Future.delayed(const Duration(milliseconds: 2000));
            final newCount = event is IncreaseCountButtonClick
                ? ++successState.cartResponse.cartItems[index].count
                : --successState.cartResponse.cartItems[index].count;

            await cartRepository.changeCount(cartItemId, newCount);

            successState.cartResponse.cartItems
                .firstWhere((element) => element.id == cartItemId)
              ..count = newCount
              ..changeCountLoading = false;
            emit(calculatePriceInfo(successState.cartResponse));
          }
        } catch (e) {
          emit(CartError(AppException()));
        }
      }
    });
  }
  Future<void> loadCartItems(Emitter<CartState> emit, bool isRefreshing) async {
    try {
      if (!isRefreshing) {
        emit(CartLoading());
      }
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

  CartSuccess calculatePriceInfo(CartResponse cartResponse) {
    int totalPrice = 0;
    int payablePrice = 0;
    int shipingCost = 0;
    for (var element in cartResponse.cartItems) {
      totalPrice += element.product.previousPrice * element.count;
      payablePrice += element.product.price * element.count;
    }
    shipingCost = payablePrice >= 250000 ? 0 : 30000;

    cartResponse.totalPrice = totalPrice;
    cartResponse.payablePrice = payablePrice;
    cartResponse.shippingCost = shipingCost;

    return CartSuccess(cartResponse);
  }
}
