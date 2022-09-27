part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartStarted extends CartEvent {
  final AuthInfo? authInfo;

  const CartStarted(this.authInfo);
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
