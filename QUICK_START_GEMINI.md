# Quick Start - Gemini AI Integration

## 5-Minute Setup

### Step 1: Get API Key (1 min)
```
Go to: https://makersuite.google.com/app/apikey
Click: Create API Key
Copy: Your API key
```

### Step 2: Add API Key (1 min)
Edit file: `lib/core/services/gemini_service.dart`

Find line 4:
```dart
static const String _apiKey = 'AIzaSyDxPG1Rq_2xM5T8j9K3L4N6O7P8Q9R0S';
```

Replace with your key:
```dart
static const String _apiKey = 'YOUR_API_KEY_HERE';
```

### Step 3: Get Dependencies (1 min)
```bash
cd f:\KataDia
flutter pub get
```

### Step 4: Run App (2 min)
```bash
flutter run
```

## Test It

1. Open app → AI Chat page
2. Type: "Hello, teach me about English"
3. See live Gemini AI response ✨

## What's New?

- ✅ Real Gemini AI responses (no more mock data)
- ✅ Full conversation support
- ✅ Error handling included
- ✅ Session management included

## File Locations

| Component | File |
|-----------|------|
| AI Service | `lib/core/services/gemini_service.dart` |
| Repository | `lib/features/ai_chat/data/repositories/chat_repository.dart` |
| UI Page | `lib/features/ai_chat/presentation/pages/ai_chat_page.dart` |

## Troubleshooting

| Issue | Solution |
|-------|----------|
| "Invalid API Key" | Replace key in `gemini_service.dart` line 4 |
| No response | Check internet connection |
| Rate limit error | Upgrade Gemini API quota at `makersuite.google.com` |
| Import errors | Run `flutter pub get` |

## Learn More

📖 Read: `GEMINI_INTEGRATION_GUIDE.md`
📖 Read: `GEMINI_AI_IMPLEMENTATION.md`

## Support

For Gemini API docs: https://ai.google.dev/
