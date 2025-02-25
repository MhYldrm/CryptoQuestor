/// A utility class that provides predefined size constants for various widgets.
/// This class helps maintain consistency in UI element sizing throughout the application.
///
final class ProjectSizes {
  const ProjectSizes._();

  /// Extra extra small size (8.0).
  static const xxSmall = Size.xxSmall;

  /// Extra small size (16.0).
  static const xSmall = Size.xSmall;

  /// Small size (24.0).
  static const small = Size.small;

  /// Medium size (32.0).
  static const medium = Size.medium;

  /// Large size (48.0).
  static const large = Size.large;

  /// Extra extra small large size (50.0).
  static const xxsLarge = Size.xxsLarge;

  /// Extra small large size (55.0).
  static const xsLarge = Size.xsLarge;

  /// Extra large size (65.0).
  static const xLarge = Size.xLarge;

  /// Double extra large size (80.0).
  static const xxLarge = Size.xxLarge;

  /// Triple extra large size (120.0).
  static const xxxLarge = Size.xxxLarge;

  /// Quadruple extra large size (130.0).
  static const xxxxLarge = Size.xxxxLarge;

  /// Specific size definitions for various use cases.
  static const size250 = Size.size250;
  static const size60 = Size.size60;
  static const size10 = Size.size10;
  static const size5 = Size.size5;
  static const size11 = Size.size11;
  static const size20 = Size.size20;
  static const size30 = Size.size30;
  static const size35 = Size.size35;
  static const size40 = Size.size40;
  static const size45 = Size.size45;
  static const size70 = Size.size70;
  static const size80 = Size.size80;
  static const size120 = Size.size120;
  static const size125 = Size.size125;
  static const size160 = Size.size160;
  static const size165 = Size.size165;
  static const size170 = Size.size170;
  static const size200 = Size.size200;
  static const size215 = Size.size215;
  static const size300 = Size.size300;
  static const size400 = Size.size400;
  static const size500 = Size.size500;
}

/// Enum defining various predefined size values for UI components like `SizedBox` and `Container`.
/// This ensures consistency across different UI elements by using predefined sizes instead of arbitrary values.
enum Size {
  /// Extra extra small (8.0).
  xxSmall(8),

  /// Extra small (16.0).
  xSmall(16),

  /// Small (24.0).
  small(24),

  /// Medium (32.0).
  medium(32),

  /// Large (48.0).
  large(48),

  /// Extra extra small large (50.0).
  xxsLarge(50),

  /// Extra small large (55.0).
  xsLarge(55),

  /// Extra large (65.0).
  xLarge(65),

  /// Double extra large (80.0).
  xxLarge(80),

  /// Triple extra large (120.0).
  xxxLarge(120),

  /// Quadruple extra large (130.0).
  xxxxLarge(130),

  /// Custom size 250.
  size250(250),

  /// Custom size 5.
  size5(5),

  /// Custom size 10.
  size10(10),

  /// Custom size 11.
  size11(11),

  /// Custom size 20.
  size20(20),

  /// Custom size 30.
  size30(30),

  /// Custom size 35.
  size35(35),

  /// Custom size 40.
  size40(40),

  /// Custom size 45.
  size45(45),

  /// Custom size 60.
  size60(60),

  /// Custom size 70.
  size70(70),

  /// Custom size 80.
  size80(80),

  /// Custom size 120.
  size120(120),

  /// Custom size 125.
  size125(125),

  /// Custom size 160.
  size160(160),

  /// Custom size 165.
  size165(165),

  /// Custom size 170.
  size170(170),

  /// Custom size 200.
  size200(200),

  /// Custom size 215.
  size215(215),

  /// Custom size 300.
  size300(300),

  /// Custom size 400.
  size400(400),

  /// Custom size 500.
  size500(500);

  /// Constructor to define a size with a specific value.
  const Size(this.value);

  /// The numeric value associated with the size.
  final double value;
}
