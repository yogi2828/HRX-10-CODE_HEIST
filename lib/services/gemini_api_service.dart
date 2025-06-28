import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:gamifier/constants/app_constants.dart';
import 'package:gamifier/models/course.dart';
import 'package:gamifier/models/level.dart';
import 'package:gamifier/models/lesson.dart';
import 'package:gamifier/models/question.dart';
import 'package:gamifier/models/user_progress.dart';
import 'package:gamifier/models/user_profile.dart'; // Import UserProfile
import 'package:gamifier/models/chat_message.dart';

class GeminiApiService {
  static const String _baseUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';
  final String _apiKey = AppConstants.geminiApiKey;

  Future<Map<String, dynamic>> _callGeminiApi(Map<String, dynamic> payload) async {
    if (_apiKey.isEmpty || _apiKey == 'YOUR_GEMINI_API_HERE') {
      throw Exception('Gemini API Key is not configured. Please set it in app_constants.dart');
    }

    final url = Uri.parse('$_baseUrl?key=$_apiKey');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody.containsKey('error')) {
          throw Exception('Gemini API Error: ${responseBody['error']['message']}');
        }
        if (responseBody['candidates'] != null &&
            responseBody['candidates'].isNotEmpty &&
            responseBody['candidates'][0]['content'] != null &&
            responseBody['candidates'][0]['content']['parts'] != null &&
            responseBody['candidates'][0]['content']['parts'].isNotEmpty) {
          return responseBody;
        } else {
          throw Exception('Gemini API response did not contain expected content structure.');
        }
      } else {
        debugPrint('Gemini API Error - Status Code: ${response.statusCode}');
        debugPrint('Response Body: ${response.body}');
        throw Exception('Failed to call Gemini API: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Network or parsing error calling Gemini API: $e');
    }
  }

  String _extractJsonString(String text) {
    String cleanedText = text.trim();

    // Regex to find JSON within a '```json` block
    final jsonCodeBlockRegex = RegExp(r'```json\s*(\{[\s\S]*?\})\s*```', dotAll: true);
    final jsonCodeBlockMatch = jsonCodeBlockRegex.firstMatch(cleanedText);
    if (jsonCodeBlockMatch != null && jsonCodeBlockMatch.group(1) != null) {
      return jsonCodeBlockMatch.group(1)!;
    }

    // Fallback: Find the largest valid JSON object or array
    final List<Match> allMatches = RegExp(r'\{[\s\S]*\}|\[[\s\S]*\]', dotAll: true).allMatches(cleanedText).toList();
    
    // Sort matches by length descending to prioritize larger JSON structures
    allMatches.sort((a, b) => b.group(0)!.length.compareTo(a.group(0)!.length));

    String? bestValidJson;
    for (final match in allMatches) {
      String potentialJson = match.group(0)!;
      try {
        json.decode(potentialJson); // Attempt to decode
        bestValidJson = potentialJson;
        break; // Found the largest valid JSON, stop searching
      } on FormatException {
        // Continue to next match if invalid
      }
    }

    if (bestValidJson != null) {
      return bestValidJson;
    }
    
    // If no complete JSON found, attempt to repair basic issues (like truncation at the end)
    // This is a last resort and might not fix complex parsing issues.
    int openBraces = 0;
    int openBrackets = 0;
    bool inString = false;
    StringBuffer repairedJsonBuffer = StringBuffer();

    for (int i = 0; i < cleanedText.length; i++) {
      String char = cleanedText[i];
      if (char == '\\' && i + 1 < cleanedText.length) {
        // Handle escaped characters
        repairedJsonBuffer.write(char);
        repairedJsonBuffer.write(cleanedText[++i]);
      } else if (char == '"') {
        inString = !inString;
        repairedJsonBuffer.write(char);
      } else if (char == '{' && !inString) {
        openBraces++;
        repairedJsonBuffer.write(char);
      } else if (char == '}' && !inString) {
        openBraces--;
        repairedJsonBuffer.write(char);
      } else if (char == '[' && !inString) {
        openBrackets++;
        repairedJsonBuffer.write(char);
      } else if (char == ']' && !inString) {
        openBrackets--;
        repairedJsonBuffer.write(char);
      } else {
        repairedJsonBuffer.write(char);
      }
    }

    // Append closing braces/brackets if they are missing at the end due to truncation
    if (inString) {
      repairedJsonBuffer.write('"'); // Close unclosed string
    }
    while (openBraces > 0) {
      repairedJsonBuffer.write('}');
      openBraces--;
    }
    while (openBrackets > 0) {
      repairedJsonBuffer.write(']');
      openBrackets--;
    }

    String finalRepairedText = repairedJsonBuffer.toString();
    debugPrint('Attempting to parse repaired JSON: $finalRepairedText');
    return finalRepairedText;
  }

  Future<Map<String, dynamic>> generateCourseContent({
    required String topicName,
    required String ageGroup,
    required String domain,
    required String difficulty,
    String? educationLevel,
    String? specialty,
    String? sourceContent,
    String? youtubeUrl,
    int numberOfLevels = AppConstants.initialLevelsCount,
    int startingLevelOrder = 1,
    List<Level>? previousLevelsContext,
  }) async {
    String prompt = '''
    As an AI-powered gamification engine, your task is to transform a static course topic into an interactive, game-based learning module.
    Generate a complete course structure including:
    - courseTitle: A catchy title for the course.
    - language: write the text in specified language like the (hindi,) Choose one from: ${AppConstants.gameThemes.join(', ')}.
    - difficulty: The difficulty level of the course ("Beginner", "Intermediate", "Advanced", "Expert").
    - levels: An array of $numberOfLevels distinct levels, ordered from easy to hard, each tailored to the course's difficulty. Each level should have:
        - id: A unique string ID for the level (e.g., "level_${startingLevelOrder}").
        - title: The title of the level.
        - description: A brief, engaging description of the level.
        - difficulty: The specific difficulty of this level (e.g., "Easy", "Medium").
        - order: An integer representing the sequential order of the level (e.g., $startingLevelOrder, ${startingLevelOrder + 1}, ...). This field is mandatory.
        - imageAssetPath: An optional path to a local asset image for this level's icon/visual (e.g., "assets/level_icons/level${startingLevelOrder}.png", "assets/level_icons/level${startingLevelOrder + 1}.png"). Create unique, descriptive paths for each.
        - lessons: An array of 1-3 detailed lessons. Each lesson should have:
            - id: A unique string ID for the lesson (e.g., "lesson_${startingLevelOrder}_1").
            - title: The title of the lesson.
            - content: Comprehensive learning material for the lesson (min 200 words), suitable for a college student, formatted in Markdown. **Ensure this is a valid JSON string with all special characters correctly escaped.**
            - order: An integer representing the sequential order of the lesson. This field is mandatory.
            - questions: An array of 3-5 small, interesting, and engaging questions for the lesson, appropriate for the level's difficulty. Each question should have:
                - id: A unique string ID for the question (e.g., "q1_lesson_${startingLevelOrder}_1").
                - questionText: The question itself.
                - xpReward: An integer for XP reward (e.g., 10, 15, 20). This field is mandatory.
                - type: One of "MCQ", "FillInBlank", "ShortAnswer", "Scenario". Favor a mix of types for variety.
                - specific fields based on type (if applicable):
                    - For MCQ: options (List<String>), correctAnswer (String, one of options). Ensure options are distinct and plausible.
                    - For FillInBlank: correctAnswer (String).
                    - For ShortAnswer: expectedAnswerKeywords (String, comma-separated keywords for evaluation).
                    - For Scenario: scenarioText (String, concise and engaging), expectedOutcome (String). **Ensure scenarioText is a valid JSON string.**

    The course is for "$topicName" for college students in the "$domain" domain, with an overall "$difficulty" difficulty level.
    The user's education level is "$educationLevel" and their specialty is "$specialty". Tailor content and examples to these if relevant.
    ''';

    if (previousLevelsContext != null && previousLevelsContext.isNotEmpty) {
      prompt += '''
      \n\nFor context, here are the previously generated levels of this course. Ensure the new levels logically follow these, increasing in difficulty and building upon prior concepts:
      ${json.encode(previousLevelsContext.map((level) => level.toMap()).toList())}
      ''';
    }

    if (sourceContent != null && sourceContent.isNotEmpty) {
      prompt += '''
      \n\nUse the following provided text as the primary source material for generating the course content, lessons, and questions. Focus on the key concepts and details within this text:\n\n"$sourceContent"
      ''';
    } else if (youtubeUrl != null && youtubeUrl.isNotEmpty) {
      prompt += '''
      \n\nConsider the topic "$topicName" as if it were a YouTube video found at this URL: $youtubeUrl. Generate the course content, lessons, and questions based on what you would expect to be covered in such a video. If possible, imagine and use key points or a transcript from this video to structure the content.
      ''';
    }

    prompt += '''
    \n\nOutput ONLY the JSON object. Do NOT include any descriptive text, markdown code block fences (\`\`\`json), or any other characters outside the JSON structure.
    All string values within the JSON, especially multi-line content or text containing special characters (like backslashes, double quotes, or newlines), MUST be correctly escaped for JSON validity. For example, newlines should be "\\\\n", double quotes should be "\\\\\\"", and backslashes should be "\\\\\\\\".
    The output MUST be a JSON object conforming to the following schema.
    ''';

    final payload = {
      "contents": [
        {"role": "user", "parts": [{"text": prompt}]}
      ],
      "generationConfig": {
        "responseMimeType": "application/json",
        "responseSchema": {
          "type": "OBJECT",
          "properties": {
            "courseTitle": {"type": "STRING"},
            "gameGenre": {"type": "STRING"},
            "difficulty": {"type": "STRING"},
            "levels": {
              "type": "ARRAY",
              "items": {
                "type": "OBJECT",
                "properties": {
                  "id": {"type": "STRING"},
                  "title": {"type": "STRING"},
                  "description": {"type": "STRING"},
                  "difficulty": {"type": "STRING"},
                  "order": {"type": "INTEGER"}, // Marked as INTEGER
                  "imageAssetPath": {"type": "STRING"},
                  "lessons": {
                    "type": "ARRAY",
                    "items": {
                      "type": "OBJECT",
                      "properties": {
                        "id": {"type": "STRING"},
                        "title": {"type": "STRING"},
                        "content": {"type": "STRING"},
                        "order": {"type": "INTEGER"}, // Marked as INTEGER
                        "questions": {
                          "type": "ARRAY",
                          "items": {
                            "type": "OBJECT",
                            "properties": {
                              "id": {"type": "STRING"},
                              "questionText": {"type": "STRING"},
                              "xpReward": {"type": "INTEGER"}, // Marked as INTEGER
                              "type": {"type": "STRING"},
                              "options": {
                                "type": "ARRAY",
                                "items": {"type": "STRING"}
                              },
                              "correctAnswer": {"type": "STRING"},
                              "expectedAnswerKeywords": {"type": "STRING"},
                              "scenarioText": {"type": "STRING"},
                              "expectedOutcome": {"type": "STRING"},
                            },
                            "required": ["id", "questionText", "xpReward", "type"]
                          }
                        }
                      },
                      "required": ["id", "title", "content", "order", "questions"]
                    }
                  }
                },
                "required": ["id", "title", "description", "difficulty", "order", "lessons"]
              }
            }
          },
          "required": ["courseTitle", "gameGenre", "difficulty", "levels"]
        }
      },
      "safetySettings": [
        {"category": "HARM_CATEGORY_HARASSMENT", "threshold": "BLOCK_NONE"},
        {"category": "HARM_CATEGORY_HATE_SPEECH", "threshold": "BLOCK_NONE"},
        {"category": "HARM_CATEGORY_SEXUALLY_EXPLICIT", "threshold": "BLOCK_NONE"},
        {"category": "HARM_CATEGORY_DANGEROUS_CONTENT", "threshold": "BLOCK_NONE"}
      ]
    };

    try {
      final responseBody = await _callGeminiApi(payload);
      final String rawJsonString = responseBody['candidates'][0]['content']['parts'][0]['text'];
      String extractedJsonString = _extractJsonString(rawJsonString);

      try {
        final Map<String, dynamic> parsedJson = json.decode(extractedJsonString);
        return parsedJson;
      } on FormatException catch (e, stacktrace) {
        debugPrint('FormatException during JSON decoding. Raw response: \n$rawJsonString');
        debugPrint('Extracted string attempt: \n$extractedJsonString');
        debugPrint('Decoding error: $e');
        debugPrint('Stacktrace: $stacktrace');
        throw Exception('Failed to parse AI response: JSON is malformed. Details: $e. Raw: "$rawJsonString"');
      }
    } catch (e) {
      debugPrint('Error generating course content: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> generateSubsequentLevels({
    required String courseId,
    required String topicName,
    required String ageGroup,
    required String domain,
    required String difficulty,
    required int startingLevelOrder,
    required int numberOfLevels,
    String? educationLevel,
    String? specialty,
    String? sourceContent,
    String? youtubeUrl,
    List<Level>? previousLevelsContext,
  }) async {
    final Map<String, dynamic> generatedContent = await generateCourseContent(
      topicName: topicName,
      ageGroup: ageGroup,
      domain: domain,
      difficulty: difficulty,
      educationLevel: educationLevel,
      specialty: specialty,
      sourceContent: sourceContent,
      youtubeUrl: youtubeUrl,
      numberOfLevels: numberOfLevels,
      startingLevelOrder: startingLevelOrder,
      previousLevelsContext: previousLevelsContext,
    );

    final List<Level> levels = [];
    final Map<String, List<Lesson>> lessonsPerLevel = {};
    final Map<String, Map<String, List<Question>>> questionsPerLessonPerLevel = {};

    if (generatedContent['levels'] is List) {
      for (var levelData in (generatedContent['levels'] as List)) {
        if (levelData is Map<String, dynamic>) {
          final Level newLevel = Level.fromMap(levelData)..courseId = courseId;
          levels.add(newLevel);

          final List<Lesson> lessons = [];
          final Map<String, List<Question>> questionsForThisLevelLessons = {};

          if (levelData['lessons'] is List) {
            for (var lessonData in (levelData['lessons'] as List)) {
              if (lessonData is Map<String, dynamic>) {
                final Lesson newLesson = Lesson.fromMap(lessonData)..levelId = newLevel.id;
                lessons.add(newLesson);

                final List<Question> questions = [];
                if (lessonData['questions'] is List) { // Ensure newLesson.questions is a list before iterating
                  for (var questionData in (lessonData['questions'] as List)) {
                    if (questionData is Map<String, dynamic>) { // Ensure questionData is a Map
                      questions.add(Question.fromMap(questionData));
                    } else {
                      debugPrint('Warning: Skipping malformed question data: $questionData');
                    }
                  }
                }
                questionsForThisLevelLessons[newLesson.id] = questions;
              } else {
                debugPrint('Warning: Skipping malformed lesson data: $lessonData');
              }
            }
          }
          lessonsPerLevel[newLevel.id] = lessons;
          questionsPerLessonPerLevel[newLevel.id] = questionsForThisLevelLessons;
        } else {
          debugPrint('Warning: Skipping malformed level data: $levelData');
        }
      }
    }

    return {
      'levels': levels,
      'lessonsPerLevel': lessonsPerLevel,
      'questionsPerLessonPerLevel': questionsPerLessonPerLevel,
    };
  }

  Future<Map<String, dynamic>> generateSocraticFeedback({
    required String userAnswer,
    required String questionText,
    required String correctAnswer,
    required String lessonContent,
    required UserProfile userProfile, // Changed from UserProgress to UserProfile
  }) async {
    // Determine the user's current proficiency based on their XP from UserProfile
    String proficiency = 'novice';
    if (userProfile.xp > AppConstants.xpPerLevel * 3) {
      proficiency = 'intermediate';
    }
    if (userProfile.xp > AppConstants.xpPerLevel * 7) {
      proficiency = 'advanced';
    }

    // Construct a comprehensive prompt for the AI tutor
    String prompt = '''
    You are an AI-powered gamified tutor providing personalized,write the only 4-5 lines Socratic feedback to college students.
    Your goal is to guide students to understand concepts deeply, not just give answers.

    Here is the context:
    - User's Answer: "$userAnswer"
    - Correct Answer: "$correctAnswer"
    - Question Text: "$questionText"
    - Lesson Content (for contextual understanding): "$lessonContent"
    - User's Proficiency Level: "$proficiency"

    Based on this information, provide feedback in the following JSON format.

    Output ONLY the JSON object. Do NOT include any descriptive text or markdown code block fences (\`\`\`json).
    All string values within the JSON, especially multi-line content or text containing special characters (like backslashes, double quotes, or newlines), MUST be correctly escaped for JSON validity. For example, newlines should be "\\\\n", double quotes should be "\\\\\\"", and backslashes should be "\\\\\\\\".
    The output MUST be a JSON object conforming to the following schema.
    {
      "feedbackText": "Your feedback here...",
      "socraticFollowUp": "A question to make them think...",
      "adaptiveHints": "Subtle hints based on their answer...",
      "encouragement": "Encouraging words adapted to their performance..."
    }
    ''';

    final payload = {
      "contents": [
        {"role": "user", "parts": [{"text": prompt}]}
      ],
      "generationConfig": {
        "responseMimeType": "application/json",
        "responseSchema": {
          "type": "OBJECT",
          "properties": {
            "feedbackText": {"type": "STRING"},
            "socraticFollowUp": {"type": "STRING"},
            "adaptiveHints": {"type": "STRING"},
            "encouragement": {"type": "STRING"}
          },
          "required": ["feedbackText", "encouragement"]
        }
      },
      "safetySettings": [
        {"category": "HARM_CATEGORY_HARASSMENT", "threshold": "BLOCK_NONE"},
        {"category": "HARM_CATEGORY_HATE_SPEECH", "threshold": "BLOCK_NONE"},
        {"category": "HARM_CATEGORY_SEXUALLY_EXPLICIT", "threshold": "BLOCK_NONE"},
        {"category": "HARM_CATEGORY_DANGEROUS_CONTENT", "threshold": "BLOCK_NONE"}
      ]
    };

    try {
      final responseBody = await _callGeminiApi(payload);
      final String rawJsonString = responseBody['candidates'][0]['content']['parts'][0]['text'];
      String extractedJsonString = _extractJsonString(rawJsonString);

      try {
        return json.decode(extractedJsonString);
      } on FormatException catch (e, stacktrace) {
        debugPrint('FormatException during JSON decoding. Raw response: \n$rawJsonString');
        debugPrint('Extracted string attempt: \n$extractedJsonString');
        debugPrint('Decoding error: $e');
        debugPrint('Stacktrace: $stacktrace');
        throw Exception('Failed to parse AI response: JSON is malformed. Details: $e. Raw: "$rawJsonString"');
      }
    } catch (e) {
      debugPrint('Error generating Socratic feedback: $e');
      rethrow;
    }
  }

  Future<ChatMessage> chatWithTutor(List<ChatMessage> chatHistory) async {
    if (_apiKey.isEmpty || _apiKey == 'YOUR_GEMINI_API_HERE') {
      throw Exception('Gemini API Key is not configured. Please set it in app_constants.dart');
    }

    final List<Map<String, dynamic>> contents = chatHistory.map((msg) => {
      "role": msg.isUser ? "user" : "model",
      "parts": [{"text": msg.text}]
    }).toList();

    final payload = {
      "contents": contents,
      "generationConfig": {
        "temperature": AppConstants.geminiTemperature,
        "maxOutputTokens": AppConstants.geminiMaxOutputTokens,
      },
      "safetySettings": [
        {"category": "HARM_CATEGORY_HARASSMENT", "threshold": "BLOCK_NONE"},
        {"category": "HARM_CATEGORY_HATE_SPEECH", "threshold": "BLOCK_NONE"},
        {"category": "HARM_CATEGORY_SEXUALLY_EXPLICIT", "threshold": "BLOCK_NONE"},
        {"category": "HARM_CATEGORY_DANGEROUS_CONTENT", "threshold": "BLOCK_NONE"}
      ]
    };

    try {
      final responseBody = await _callGeminiApi(payload);
      final String aiResponseText = responseBody['candidates'][0]['content']['parts'][0]['text'];
      
      return ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // Simple ID
        senderId: 'ai_tutor',
        senderUsername: 'AI Tutor',
        senderAvatarUrl: 'assets/app_icon.png', // Assuming app_icon.png is the AI's avatar
        text: aiResponseText,
        timestamp: DateTime.now(),
        isUser: false,
      );
    } catch (e) {
      debugPrint('Error generating chat response: $e');
      throw Exception('Failed to get response from AI: $e');
    }
  }
}
