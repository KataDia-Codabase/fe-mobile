import 'dart:io';
import 'package:http/http.dart' as http;

class NetworkTest {
  /// Test basic internet connectivity
  static Future<bool> testInternetConnection() async {
    try {
      final response = await http.get(
        Uri.parse('https://www.google.com'),
      ).timeout(const Duration(seconds: 10));
      
      return response.statusCode == 200;
    } catch (e) {
      print('Internet connection test failed: $e');
      return false;
    }
  }

  /// Test Gemini API accessibility
  static Future<bool> testGeminiAPI() async {
    try {
      final response = await http.get(
        Uri.parse('https://generativelanguage.googleapis.com'),
      ).timeout(const Duration(seconds: 10));
      
      return response.statusCode == 200 || response.statusCode == 404; // 404 is expected for root
    } catch (e) {
      print('Gemini API test failed: $e');
      return false;
    }
  }

  /// Run comprehensive network diagnostics
  static Future<Map<String, bool>> runDiagnostics() async {
    final results = <String, bool>{};
    
    print('Running network diagnostics...');
    
    // Test 1: Basic internet
    results['internet'] = await testInternetConnection();
    print('Internet connection: ${results['internet'] == true ? 'OK' : 'FAILED'}');
    
    // Test 2: Gemini API accessibility
    results['gemini_api'] = await testGeminiAPI();
    print('Gemini API access: ${results['gemini_api'] == true ? 'OK' : 'FAILED'}');
    
    return results;
  }
}