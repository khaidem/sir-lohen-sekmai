import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  /// ### [ThemeData] Extension On [BuildContext]
  ///
  /// The data from the closest [Theme] instance that encloses the given context.
  ThemeData get theme => Theme.of(this);

  /// ### TextTheme Extension On [BuildContext]
  ///
  /// Text with a color that contrasts with the card and canvas colors.
  TextTheme get textTheme => Theme.of(this).textTheme;
}
