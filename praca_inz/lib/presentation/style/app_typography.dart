import 'package:flutter/material.dart';

const _fontFamily = 'Mulish';

class AppTypography {
  static const TextStyle style0 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 20,
    height: 1.54,
  );
  static const TextStyle style1 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 20,
    height: 1.6,
  );
  static const TextStyle style2 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 20,
    height: 1.6,
  );
  static const TextStyle style3 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w800,
    fontSize: 20,
    height: 1.6,
  );
  static const TextStyle style4 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 18,
    height: 1.3,
  );
  static const TextStyle style5 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 18,
    height: 1.3,
  );
  static const TextStyle style6 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 18,
    height: 1.3,
  );
  static const TextStyle style7 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.0,
  );
  static const TextStyle style8 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 1.0,
  );
  static const TextStyle style9 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.5,
  );
  static const TextStyle style10 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1.5,
  );
  static const TextStyle style11 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 1.5,
  );
  static const TextStyle style12 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.14,
  );
  static const TextStyle style13 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.7,
  );
  static const TextStyle style14 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 1.7,
  );
  static const TextStyle style15 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 1.7,
  );
  static const TextStyle style16 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1.3,
  );
  static const TextStyle style17 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 12,
    height: 1.3,
  );
  static const TextStyle style18 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 12,
    height: 1.3,
  );
  static const TextStyle style19 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 11,
    height: 1.45,
  );
  static const TextStyle style20 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w800,
    fontSize: 11,
    height: 1.45,
  );
}

extension SetMainTextColor on TextStyle {
  TextStyle setMainTextColor(Color color) => copyWith(color: color);
}
