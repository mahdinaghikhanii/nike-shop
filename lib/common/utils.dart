import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

const defaultScrollPhysics = BouncingScrollPhysics();

extension PriceLabel on int {
  String get withPriceLabel => this > 0 ? '$seprateByComma تومان' : "رایگان";

  String get seprateByComma {
    final numberFormat = NumberFormat.decimalPattern();
    return numberFormat.format(this);
  }
}
