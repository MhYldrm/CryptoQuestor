import 'dart:convert';
import 'gecko_model.dart';

/// [GeckoModelHelper] A utility class for handling JSON serialization and deserialization of [GeckoModel] objects.
/// It provides methods to convert a JSON string into a list of [GeckoModel] objects and vice versa.
class GeckoModelHelper {
  /// Converts a JSON string into a list of [GeckoModel] objects.
  /// [str] The JSON string representing a list of GeckoModel objects.
  ///
  /// This method takes the JSON string, decodes it, and maps each element of the decoded list to a [GeckoModel] object.
  /// [e] refers to each individual element in the decoded list that will be converted to a [GeckoModel] instance.
  static List<GeckoModel> fromJsonList(String str) =>
      List<GeckoModel>.from(json.decode(str).map((e) {
        // e represents an individual element from the decoded JSON list
        // Each element 'e' is expected to be a map that corresponds to the structure of the GeckoModel.
        return GeckoModel.fromJson(e);
      }));
}
