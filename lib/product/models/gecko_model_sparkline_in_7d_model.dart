/// [GeckoModelSpaklineIn7DModel] Represents the price trend of a coin over the last 7 days.
/// This model contains a list of prices over the last 7 days that corresponds to the
/// [sparklineIn7D] property in [GeckoModel].
///
/// This is specifically used to track the price trend of the coin over the past week
/// in the form of a list of price data points.
class GeckoModelSpaklineIn7DModel {
  GeckoModelSpaklineIn7DModel({
    required this.price,
  });

  /// Creates a [GeckoModelSpaklineIn7DModel] instance from a JSON map.
  /// [json] The JSON map containing the price data.
  ///
  /// The JSON map is expected to contain a "price" key, which holds a list of double values
  /// representing the coin's prices over the last 7 days. This data is part of the
  /// `sparklineIn7D` in the [GeckoModel].
  factory GeckoModelSpaklineIn7DModel.fromJson(Map<String, dynamic> json) =>
      GeckoModelSpaklineIn7DModel(
        price: List<double>.from(json["price"].map((x) => x?.toDouble())),
      );

  final List<double>
      price; // List of prices over the last 7 days, part of the [sparklineIn7D] data

  /// Converts the [GeckoModelSpaklineIn7DModel] instance to a JSON map.
  /// Returns a map representing the price trend in JSON format.
  ///
  /// This method converts the list of prices into a JSON-serializable format that can
  /// be stored or transmitted. The "price" key is used to represent the trend.
  Map<String, dynamic> toJson() => {
        "price": List<dynamic>.from(price.map((x) => x)),
      };
}
