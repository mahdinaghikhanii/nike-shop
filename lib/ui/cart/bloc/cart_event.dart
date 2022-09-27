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

class CartDeleteButton extends CartEvent {}

class CartAuthInfoChange extends CartEvent {
  final AuthInfo? authInfo;
  const CartAuthInfoChange(this.authInfo);
}
