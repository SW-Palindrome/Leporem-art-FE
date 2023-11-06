import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyFormatter extends TextInputFormatter {
  static const int _maxDigits = 10; // 최대 자릿수 (여기서는 10자리로 설정)

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(',', ''); // 콤마 제거
    final number = int.tryParse(text);

    if (number == null || text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final formatter = NumberFormat('#,###');
    final formattedText = formatter.format(number);

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String numberToCurrency(int number) {
    final formatter = NumberFormat('#,###');
    final formattedText = formatter.format(number);
    return formattedText;
  }
}
