import 'dart:convert';

class JsonUtils {
  static Map<String, dynamic>? parseJson(String? json) {
    if (json == null || json.isEmpty) return null;
    try {
      return jsonDecode(json) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  static String toJson(dynamic object) {
    try {
      return jsonEncode(object);
    } catch (e) {
      return '{}';
    }
  }

  static dynamic getNestedValue(Map<String, dynamic>? map, String path) {
    if (map == null) return null;
    
    final keys = path.split('.');
    dynamic value = map;
    
    for (final key in keys) {
      if (value is Map) {
        value = value[key];
      } else {
        return null;
      }
    }
    
    return value;
  }

  static Map<String, dynamic> merge(
    Map<String, dynamic> map1,
    Map<String, dynamic> map2,
  ) {
    return {...map1, ...map2};
  }
}
