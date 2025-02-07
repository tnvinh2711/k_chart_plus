import 'dart:math';

class NumberUtil {
  static String format(double n, {int? length}) {
    if (n >= 1000000000) {
      n /= 1000000000;
      return "${n.toStringAsFixed(2)}B";
    } else if (n >= 1000000) {
      n /= 1000000;
      return "${n.toStringAsFixed(2)}M";
    } else if (n >= 10000) {
      n /= 1000;
      return "${n.toStringAsFixed(2)}K";
    } else {
      return n.toStringAsFixed(length ?? 4);
    }
  }

  static int getDecimalLength(double b) {
    String s = b.customToStringAsFixed(20);
    int dotIndex = s.indexOf(".");
    if (dotIndex < 0) {
      return 0;
    } else {
      return s.length - dotIndex - 1;
    }
  }

  static int getMaxDecimalLength(double a, double b, double c, double d) {
    int result = max(getDecimalLength(a), getDecimalLength(b));
    result = max(result, getDecimalLength(c));
    result = max(result, getDecimalLength(d));
    return result;
  }

  static bool checkNotNullOrZero(double? a) {
    if (a == null || a == 0) {
      return false;
    } else if (a.abs().toStringAsFixed(4) == "0.0000") {
      return false;
    } else {
      return true;
    }
  }
}

extension SmallNumberExtension on num {
  /// convert mini number, like a 1.2345e-7 to 0.00000012345
  String customToStringAsFixed(int fractionDigits) {
    if (fractionDigits <= 20) {
      final value = toStringAsFixed(fractionDigits);
      if (num.tryParse(value) == 0 && this != 0) {
        return (1 / pow(10, fractionDigits))
            .customToStringAsFixed(fractionDigits);
      }
      return toStringAsFixed(fractionDigits);
    }

    String result = toStringAsFixed(20);
    int decimalIndex = result.indexOf('.');
    if (decimalIndex == -1) {
      return '$result.${'0' * fractionDigits}';
    }

    int currentFractionDigits = result.length - decimalIndex - 1;
    if (currentFractionDigits >= fractionDigits) {
      return result;
    }

    return result + '0' * (fractionDigits - currentFractionDigits);
  }
}

