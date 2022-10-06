part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartStarted extends CartEvent {
  final AuthInfo? authInfo;
  final bool isRefreshing;

  const CartStarted(this.authInfo, {this.isRefreshing = false});
}

class CartDeleteButtonClicked extends CartEvent {
  final int crtItemId;

  const CartDeleteButtonClicked(this.crtItemId);

  @override
  List<Object> get props => [cartIndex];
}

class CartAuthInfoChange extends CartEvent {
  final AuthInfo? authInfo;
  const CartAuthInfoChange(this.authInfo);
}

class IncreaseCountButtonClick extends CartEvent {
  final int cartItemId;

  const IncreaseCountButtonClick(this.cartItemId);

  @override
  List<Object> get props => [cartItemId];
}

class DecreaseCountButtonClick extends CartEvent {
  final int cartItemId;
  const DecreaseCountButtonClick(this.cartItemId);

  @override
  List<Object> get props => [cartItemId];
}
