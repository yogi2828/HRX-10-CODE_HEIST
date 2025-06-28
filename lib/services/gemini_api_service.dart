// lib/services/gemini_api_service.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gamifier/constants/app_constants.dart';

class GeminiApiService extends ChangeNotifier {
  Future<String> generateText(String prompt) async {
    final String apiKey = AppConstants.geminiApiKey;
    final String apiUrl =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey';

    final chatHistory = [
      {"role": "user", "parts": [{"text": prompt}]}
    ];

    final payload = {
      "contents": chatHistory,
      "generationConfig": {
        "temperature": AppConstants.geminiTemperature,
        "maxOutputTokens": AppConstants.geminiMaxOutputTokens,
      }
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['candidates'] != null &&
            result['candidates'].isNotEmpty &&
            result['candidates'][0]['content'] != null &&
            result['candidates'][0]['content']['parts'] != null &&
            result['candidates'][0]['content']['parts'].isNotEmpty) {
          return result['candidates'][0]['content']['parts'][0]['text'] as String;
        } else {
          print('Gemini API: Unexpected response structure: ${response.body}');
          return 'Error: Could not generate content. Unexpected response from AI.';
        }
      } else {
        print('Gemini API Error: ${response.statusCode} - ${response.body}');
        return 'Error: Failed to connect to AI. Status Code: ${response.statusCode}';
      }
    } catch (e) {
      print('Gemini API Exception: $e');
      return 'Error: An exception occurred while communicating with AI.';
    }
  }

  Future<String> generateStructuredText(String prompt, Map<String, dynamic> schema) async {
    final String apiKey = AppConstants.geminiApiKey;
    final String apiUrl =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey';

    final chatHistory = [
      {"role": "user", "parts": [{"text": prompt}]}
    ];

    final payload = {
      "contents": chatHistory,
      "generationConfig": {
        "temperature": AppConstants.geminiTemperature,
        "maxOutputTokens": AppConstants.geminiMaxOutputTokens,
        "responseMimeType": "application/json",
        "responseSchema": schema
      }
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['candidates'] != null &&
            result['candidates'].isNotEmpty &&
            result['candidates'][0]['content'] != null &&
            result['candidates'][0]['content']['parts'] != null &&
            result['candidates'][0]['content']['parts'].isNotEmpty) {
          return result['candidates'][0]['content']['parts'][0]['text'] as String;
        } else {
          print('Gemini API: Unexpected structured response structure: ${response.body}');
          return 'Error: Could not generate structured content. Unexpected response from AI.';
        }
      } else {
        print('Gemini API Structured Error: ${response.statusCode} - ${response.body}');
        return 'Error: Failed to connect to AI for structured content. Status Code: ${response.statusCode}';
      }
    } catch (e) {
      print('Gemini API Structured Exception: $e');
      return 'Error: An exception occurred while communicating with AI for structured content.';
    }
  }

  Future<String> generateImageDescription(String prompt, String base64ImageData, String mimeType) async {
    final String apiKey = AppConstants.geminiApiKey;
    final String apiUrl =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey';

    final payload = {
      "contents": [
        {
          "role": "user",
          "parts": [
            {"text": prompt},
            {
              "inlineData": {
                "mimeType": mimeType,
                "data": base64ImageData,
              }
            }
          ]
        }
      ],
      "generationConfig": {
        "temperature": AppConstants.geminiTemperature,
        "maxOutputTokens": AppConstants.geminiMaxOutputTokens,
      }
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['candidates'] != null &&
            result['candidates'].isNotEmpty &&
            result['candidates'][0]['content'] != null &&
            result['candidates'][0]['content']['parts'] != null &&
            result['candidates'][0]['content']['parts'].isNotEmpty) {
          return result['candidates'][0]['content']['parts'][0]['text'] as String;
        } else {
          print('Gemini API Image Description: Unexpected response structure: ${response.body}');
          return 'Error: Could not generate image description. Unexpected response from AI.';
        }
      } else {
        print('Gemini API Image Description Error: ${response.statusCode} - ${response.body}');
        return 'Error: Failed to connect to AI for image description. Status Code: ${response.statusCode}';
      }
    } catch (e) {
      print('Gemini API Image Description Exception: $e');
      return 'Error: An exception occurred while communicating with AI for image description.';
    }
  }

  // New: AI Persona customization and adaptive learning prompts
  Future<String> getAIPersonaResponse(String prompt, String aiPersona) async {
    String personaPrefix;
    switch (aiPersona) {
      case 'Strict Professor':
        personaPrefix = 'As a strict professor, respond to the following: ';
        break;
      case 'Friendly Guide':
        personaPrefix = 'As a friendly guide, respond to the following: ';
        break;
      case 'Sarcastic Mentor':
        personaPrefix = 'As a sarcastic mentor, respond to the following: ';
        break;
      default:
        personaPrefix = '';
    }
    return generateText('$personaPrefix$prompt');
  }

  // New: Adaptive Learning Path suggestion
  Future<Map<String, dynamic>> suggestNextLesson(String userId, String courseId, String currentLevelId, double performanceScore) async {
    final String apiKey = AppConstants.geminiApiKey;
    final String apiUrl =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey';

    final prompt = """
Given the user's performance, suggest the next appropriate lesson or action.
User ID: $userId
Course ID: $courseId
Current Level ID: $currentLevelId
Performance Score for current lesson (0.0 to 1.0, lower means struggling, higher means mastery): $performanceScore

Suggest a 'nextAction' (e.g., 'nextLesson', 'remedialLesson', 'advancedTopic', 'reviewLevel') and a 'suggestionText' explaining why.
If 'nextAction' is 'nextLesson' or 'remedialLesson' or 'advancedTopic', also provide a 'suggestedLessonId' (a placeholder for now, as actual lesson IDs need to be fetched from Firebase).

Example JSON: {"nextAction": "nextLesson", "suggestionText": "You did great! Let's move on to the next topic.", "suggestedLessonId": "lesson123"}
Example JSON for struggling: {"nextAction": "remedialLesson", "suggestionText": "It seems you struggled a bit. Let's review some foundational concepts.", "suggestedLessonId": "lessonXYZ"}
""";

    final schema = {
      "type": "OBJECT",
      "properties": {
        "nextAction": {"type": "STRING"},
        "suggestionText": {"type": "STRING"},
        "suggestedLessonId": {"type": "STRING", "nullable": true} // Can be null
      },
      "propertyOrdering": ["nextAction", "suggestionText", "suggestedLessonId"]
    };

    final jsonString = await generateStructuredText(prompt, schema);
    return json.decode(jsonString) as Map<String, dynamic>;
  }

  // New: AI-Generated Multimedia Content (SVG Diagram/Flowchart)
  Future<String> generateSvgContent(String topic) async {
    final String apiKey = AppConstants.geminiApiKey;
    final String apiUrl =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey';

    final prompt = """
Generate a simple SVG diagram or flowchart for the topic: "$topic".
The SVG should be self-contained and directly embeddable in HTML.
Focus on clarity and simplicity. Do not include XML declaration or DOCTYPE.
""";

    final chatHistory = [
      {"role": "user", "parts": [{"text": prompt}]}
    ];

    final payload = {
      "contents": chatHistory,
      "generationConfig": {
        "temperature": 0.5, // Lower temperature for more consistent SVG
        "maxOutputTokens": 1000,
      }
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['candidates'] != null &&
            result['candidates'].isNotEmpty &&
            result['candidates'][0]['content'] != null &&
            result['candidates'][0]['content']['parts'] != null &&
            result['candidates'][0]['content']['parts'].isNotEmpty) {
          String svgContent = result['candidates'][0]['content']['parts'][0]['text'] as String;
          // Clean up potential markdown code blocks
          if (svgContent.startsWith('```svg')) {
            svgContent = svgContent.substring(6);
          }
          if (svgContent.endsWith('```')) {
            svgContent = svgContent.substring(0, svgContent.length - 3);
          }
          return svgContent.trim();
        } else {
          print('Gemini API: Unexpected SVG response structure: ${response.body}');
          return 'Error: Could not generate SVG content. Unexpected response from AI.';
        }
      } else {
        print('Gemini API SVG Error: ${response.statusCode} - ${response.body}');
        return 'Error: Failed to connect to AI for SVG. Status Code: ${response.statusCode}';
      }
    } catch (e) {
      print('Gemini API SVG Exception: $e');
      return 'Error: An exception occurred while generating SVG.';
    }
  }

  // New: AI-Driven Challenges/Quests generation (simplified for now)
  Future<List<String>> generateAITasks(String userLearningGoals) async {
    final prompt = """
Based on the following learning goals, propose 3 unique, engaging, and personalized daily challenges/quests.
Each challenge should be a short, actionable sentence.
Format the output as a JSON array of strings.

User Learning Goals: $userLearningGoals

Example JSON: ["Read an article on deep learning.", "Solve 5 calculus problems.", "Summarize the history of AI."]
""";

    final schema = {
      "type": "ARRAY",
      "items": {"type": "STRING"}
    };

    try {
      final jsonString = await generateStructuredText(prompt, schema);
      final List<dynamic> parsedList = json.decode(jsonString);
      return parsedList.map((e) => e.toString()).toList();
    } catch (e) {
      print('Error generating AI tasks: $e');
      return ['Complete a quick quiz.', 'Explore a new topic.']; // Fallback
    }
  }
}
