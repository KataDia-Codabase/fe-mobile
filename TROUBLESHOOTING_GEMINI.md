# Troubleshooting Gemini AI Integration

## Common Errors & Solutions

### 1. Network Error: "Failed host lookup" atau "No address associated with hostname"

**Error Message:**
```
Error: ClientException with SocketException: 
Failed host lookup: 'generativelanguage.googleapis.com (OS Error: No address associated with hostname, errno = 7)
```

**Causes:**
- ❌ Internet connection tidak tersedia
- ❌ Emulator/device tidak bisa connect ke internet
- ❌ Firewall atau proxy blocking API

**Solutions:**

#### For Emulator (Android):
```bash
# Method 1: Restart emulator
flutter emulator restart

# Method 2: Use host machine internet (usually works by default)
# Or configure in Android Studio → Extended controls → Network settings

# Method 3: Use physical device instead
flutter run -d <device-id>
```

#### For Physical Device:
```bash
# Make sure device is connected to WiFi or mobile data
# Check Settings → Internet connection

# If on corporate network, you may need VPN or proxy settings
```

#### For Network Issues:
```bash
# Test internet connectivity
ping google.com  # or use ifconfig to check

# Check if Android device can reach the API
adb shell curl https://www.google.com

# Verify API endpoint
curl -X POST "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"contents":[{"role":"user","parts":[{"text":"Hello"}]}]}'
```

---

### 2. API Key Error: "Invalid or expired API key"

**Error Message:**
```
Error: Invalid or expired API key. Please check your API key configuration.
```

**Solutions:**

1. **Get new API key:**
   - Go to https://makersuite.google.com/app/apikey
   - Click "Create API Key" or copy existing key
   - Ensure key is for "Generative Language API"

2. **Update in code:**
   ```dart
   // File: lib/core/services/gemini_service.dart
   static const String _apiKey = 'YOUR_NEW_API_KEY_HERE';
   ```

3. **Verify key is valid:**
   ```bash
   curl "https://generativelanguage.googleapis.com/v1/models?key=YOUR_API_KEY"
   ```

---

### 3. API Rate Limit: "Quota exceeded"

**Error Message:**
```
Error: API quota exceeded. Please check your usage limits.
```

**Solutions:**

1. **Check usage:**
   - Go to Google Cloud Console
   - Project Settings → APIs & Services → Quotas
   - Check "Generative Language API" quotas

2. **Increase quota:**
   - Click on the quota
   - Click "Edit Quotas"
   - Request higher limit (requires verification)

3. **Temporary solution:**
   ```dart
   // Add delay between requests
   await Future.delayed(Duration(seconds: 2));
   ```

---

### 4. Request Timeout: "Server took too long to respond"

**Error Message:**
```
Error: Request timeout. The server took too long to respond. Please try again.
```

**Solutions:**

1. **Increase timeout in code:**
   ```dart
   // File: lib/core/services/gemini_service.dart
   .timeout(const Duration(seconds: 60))  // Increase from 30
   ```

2. **Check server status:**
   - Visit https://status.cloud.google.com/
   - Check for API outages

3. **Improve network:**
   - Use 4G/5G instead of WiFi
   - Reduce background data usage
   - Test with simpler prompts

---

### 5. Bad Request: "Invalid request format"

**Error Message:**
```
Error: Bad request - Invalid request format
```

**Solutions:**

1. **Check message length:**
   ```dart
   // Ensure message is not empty and reasonable length
   if (message.length > 4000) {
     // Message too long
   }
   ```

2. **Verify API payload:**
   - Check `generationConfig` in `sendMessage()`
   - Ensure `temperature` is between 0-2
   - Ensure `maxOutputTokens` is reasonable (1-2000)

3. **Debug request:**
   ```dart
   print('Request: ${jsonEncode(requestBody)}');
   print('Response: ${response.body}');
   ```

---

## Testing & Debugging

### 1. Test with curl (command line):
```bash
curl -X POST "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "contents": [{
      "role": "user",
      "parts": [{"text": "Hello"}]
    }]
  }'
```

### 2. Enable logging in app:
```dart
// Add to gemini_service.dart
print('API Request: $requestBody');
print('Status Code: ${response.statusCode}');
print('Response: ${response.body}');
```

### 3. Check network in emulator:
```bash
# Open emulator console
telnet localhost 5554

# Check network connectivity
network status

# If offline, turn on
network status full
```

---

## Working Checklist

- [ ] API Key is valid and not expired
- [ ] Device/emulator has internet connection
- [ ] API endpoint is correct
- [ ] Request payload is valid JSON
- [ ] API key quota is not exceeded
- [ ] Firewall/antivirus not blocking requests
- [ ] Using correct model name (`gemini-pro`)
- [ ] Response timeout is reasonable (30+ seconds)

---

## Files to Check

| Issue | File |
|-------|------|
| API Key | `lib/core/services/gemini_service.dart` (line 4) |
| Network timeout | `lib/core/services/gemini_service.dart` (line 60) |
| Error handling | `lib/features/ai_chat/presentation/pages/ai_chat_page.dart` |
| Request format | `lib/core/services/gemini_service.dart` (line 39-62) |

---

## Getting Help

1. **Official Documentation:**
   - https://ai.google.dev/
   - https://ai.google.dev/tutorials/dart_quickstart

2. **Check API Status:**
   - https://status.cloud.google.com/

3. **View Logs:**
   - Android: `flutter logs`
   - Check Firebase Console for API logs

4. **Report Issues:**
   - GitHub: https://github.com/google/generative-ai-dart/issues
