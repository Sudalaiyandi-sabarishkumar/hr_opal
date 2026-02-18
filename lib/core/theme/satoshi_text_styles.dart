import 'package:flutter/material.dart';

class SatoshiTextStyles {
  static const String _font = 'Satoshi';

  static TextStyle light(double size, {Color? color}) => TextStyle(
    fontFamily: _font,
    fontSize: size,
    fontWeight: FontWeight.w300,
    color: color,
  );

  static TextStyle regular(double size, {Color? color}) => TextStyle(
    fontFamily: _font,
    fontSize: size,
    fontWeight: FontWeight.w400,
    color: color,
  );

  static TextStyle medium(double size, {Color? color}) => TextStyle(
    fontFamily: _font,
    fontSize: size,
    fontWeight: FontWeight.w500,
    color: color,
  );

  // No semibold available — using Bold(700) instead
  static TextStyle semiBold(double size, {Color? color}) => TextStyle(
    fontFamily: _font,
    fontSize: size,
    fontWeight: FontWeight.w700,
    color: color,
  );

  static TextStyle bold(double size, {Color? color}) => TextStyle(
    fontFamily: _font,
    fontSize: size,
    fontWeight: FontWeight.w700,
    color: color,
  );

  static TextStyle black(double size, {Color? color}) => TextStyle(
    fontFamily: _font,
    fontSize: size,
    fontWeight: FontWeight.w900,
    color: color,
  );
}
