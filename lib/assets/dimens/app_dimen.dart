import 'package:musket_app/assets/dimens/default_dimens.dart';
import 'package:musket_app/assets/resources.dart';

abstract class AppDimen extends Resource {
  factory AppDimen.impl() {
    return const DefaultAppDimen();
  }

  double get commonMargin;
  double get iconSize;
  double get commonRadius;
  double get borderWidth;
  double get titleBarHeight;
}
