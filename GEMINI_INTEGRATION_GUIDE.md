# Gemini AI Integration Guide

This guide explains how to set up and use Google's Gemini AI in the KataDia application.

## Setup Instructions

### 1. Get Your Gemini API Key

1. Go to [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Click "Create API Key" button
3. Copy the generated API key

### 2. Update Configuration

1. Open `lib/core/services/gemini_service.dart`
2. Replace the placeholder API key with your actual API key:

```dart
static const String _apiKey = 'YOUR_ACTUAL_API_KEY_HERE';
```

### 3. Install Dependencies

The required package has been added to `pubspec.yaml`:
```yaml
google_generative_ai: ^0.4.0
flutter_dotenv: ^5.1.0
```

Run this command to get dependencies:
```bash
flutter pub get
```

## File Structure

```
lib/
├── core/
│   └── services/
│       ├── gemini_service.dart       # Handles Gemini API communication
│       └── index.dart                 # Exports all services
├── features/
│   └── ai_chat/
│       ├── data/
│       │   ├── datasources/          # Placeholder for datasources
│       │   └── repositories/
│       │       └── chat_repository.dart  # Repository for chat operations
│       ├── domain/
│       │   └── entities/
│       │       └── chat_message_entity.dart
│       └── presentation/
│           ├── pages/
│           │   └── ai_chat_page.dart     # Updated with Gemini integration
│           └── widgets/
│               ├── chat_bubble.dart
│               ├── chat_input.dart
│               ├── chat_header.dart
│               ├── suggested_topics.dart
│               └── index.dart
```

## How It Works

### 1. **GeminiService** (`gemini_service.dart`)
- Initializes the GenerativeModel with your API key
- Manages chat sessions
- Handles message sending and response retrieval
- Provides error handling

### 2. **ChatRepository** (`chat_repository.dart`)
- Acts as an intermediary between the UI and the Gemini service
- Provides methods like `getAIResponse()` and `getAIResponseWithContext()`
- Handles session management

### 3. **AIChatPage** (`ai_chat_page.dart`)
- Displays the chat interface
- Manages conversation history
- Sends user messages via ChatRepository
- Displays AI responses from Gemini

## Usage Example

```dart
// In your widget
final geminiService = GeminiService();
final chatRepository = ChatRepository(geminiService: geminiService);

// Send a message
final response = await chatRepository.getAIResponse('Hello, how are you?');

// Use the response
print(response); // Displays the Gemini AI response
```

## Features

✅ Real-time conversation with Gemini AI
✅ Chat history management
✅ Error handling for API failures
✅ Session management (reset chat)
✅ Suggested topics for learning
✅ Loading states during AI response generation

## API Rate Limits

Google Gemini AI has usage limits. Check [Google's documentation](https://ai.google.dev/) for:
- Rate limits per project
- Quota information
- Best practices

## Troubleshooting

### Error: "Could not find a generator for route"
- This has been fixed in `main.dart` by adding `onGenerateRoute: AppRouter.generateRoute`

### API Key Invalid
- Verify your API key from [Google AI Studio](https://makersuite.google.com/app/apikey)
- Make sure you're using the correct key in `gemini_service.dart`

### Network Errors
- Ensure your device/emulator has internet connectivity
- Check if the API key has proper quota

## Future Enhancements

- [ ] Add voice input/output
- [ ] Implement conversation context management
- [ ] Add language selection
- [ ] Store chat history locally
- [ ] Add conversation export feature
- [ ] Implement custom system prompts

## Resources

- [Google Generative AI Docs](https://ai.google.dev/tutorials/dart_quickstart)
- [Gemini API Reference](https://ai.google.dev/api/rest)
- [Flutter Google Generative AI Package](https://pub.dev/packages/google_generative_ai)
