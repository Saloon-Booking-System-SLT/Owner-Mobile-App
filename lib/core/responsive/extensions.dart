import 'size_config.dart';

extension SizeExtensions on num {
  double get w => this * SizeConfig.blockWidth;
  double get h => this * SizeConfig.blockHeight;
  double get sp => this * SizeConfig.blockWidth; // scaling font
}