import 'package:money_formatter/money_formatter.dart';

extension PriceFormatExtention on String {
  String priceFormat() {
    MoneyFormatter moneyFormatter = MoneyFormatter(
        amount: double.parse(this),
        settings: MoneyFormatterSettings(
          symbol: 'IDR',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 2,
        ));
    return moneyFormatter.output.symbolOnLeft;
  }
}
