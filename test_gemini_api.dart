import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

/// Test script to verify Gemini API accessibility
/// Run this script to test if the API is working from your environment
void main() async {
  print('🔍 Testing Gemini API Accessibility...\n');
  
  const apiKey = 'AIzaSyCt-eYE6K9N0ye18UjVQgj1q8IHvqPP8P0';
  const apiEndpoint = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';
  
  // Test 1: Check if API endpoint is reachable
  print('1. Testing API endpoint reachability...');
  try {
    final response = await http.get(
      Uri.parse('https://generativelanguage.googleapis.com'),
    ).timeout(const Duration(seconds: 10));
    
    print('   Status: ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 404) {
      print('   ✅ API endpoint is reachable');
    } else {
      print('   ❌ API endpoint returned unexpected status: ${response.statusCode}');
    }
  } catch (e) {
    print('   ❌ Failed to reach API endpoint: $e');
    return;
  }
  
  // Test 2: Test actual API call
  print('\n2. Testing actual API call...');
  try {
    final requestBody = {
      'contents': [
        {
          'role': 'user',
          'parts': [
            {'text': 'Hello, can you respond with just "API working"?'}
          ]
        }
      ],
      'generationConfig': {
        'temperature': 0.7,
        'maxOutputTokens': 50,
      }
    };
    
    final response = await http
        .post(
          Uri.parse('$apiEndpoint?key=$apiKey'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(requestBody),
        )
        .timeout(const Duration(seconds: 30));
    
    print('   Status Code: ${response.statusCode}');
    
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      
      if (jsonResponse['candidates'] != null && 
          jsonResponse['candidates'].isNotEmpty) {
        final content = jsonResponse['candidates'][0]['content'];
        if (content['parts'] != null && content['parts'].isNotEmpty) {
          final aiResponse = content['parts'][0]['text'] ?? 'No response';
          print('   ✅ API call successful');
          print('   📝 Response: "$aiResponse"');
        }
      }
    } else if (response.statusCode == 400) {
      final errorBody = jsonDecode(response.body);
      final errorMessage = errorBody['error']?['message'] ?? 'Bad request';
      print('   ❌ API call failed (400): $errorMessage');
      
      if (errorMessage.contains('API key')) {
        print('   💡 Check: API key might be invalid or expired');
      }
    } else if (response.statusCode == 401) {
      print('   ❌ API call failed (401): Unauthorized');
      print('   💡 Check: API key is invalid or missing');
    } else if (response.statusCode == 429) {
      print('   ❌ API call failed (429): Rate limit exceeded');
      print('   💡 Check: Too many requests, try again later');
    } else {
      print('   ❌ API call failed (${response.statusCode})');
      print('   📄 Response: ${response.body}');
    }
  } on http.ClientException catch (e) {
    print('   ❌ Network error: $e');
    if (e.message.contains('Failed host lookup')) {
      print('   💡 This indicates no internet connection');
    }
  } on TimeoutException catch (_) {
    print('   ❌ Request timeout: Server took too long to respond');
  } catch (e) {
    print('   ❌ Unexpected error: $e');
  }
  
  print('\n🏁 Test completed');
}