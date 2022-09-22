import 'package:flutter/widgets.dart';

const defaultScrollPhysics = BouncingScrollPhysics();

extension PriceLabel on int {
  String get withPriceLabel => '$this تومان';
}
