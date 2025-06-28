
// lib/utils/validation_utils.dart
import 'package:flutter/material.dart';

class ValidationUtils {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty.';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username cannot be empty.';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters long.';
    }
    return null;
  }

  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName cannot be empty.';
    }
    return null;
  }
  static String? validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName cannot be empty.';
    }
    return null;
  }
  // Adjusted to accept dynamic for correctAnswerData, and convert to String safely
  static bool validateAnswer(String userAnswer, String questionType, dynamic correctAnswerData) {
    final String correctAnswerString = correctAnswerData?.toString() ?? ''; // Safely convert to string, default to empty

    switch (questionType) {
      case 'MCQ':
      case 'FillInBlank':
        return userAnswer.trim().toLowerCase() == correctAnswerString.trim().toLowerCase();
      case 'ShortAnswer':
        List<String> keywords = correctAnswerString.toLowerCase().split(',').map((e) => e.trim()).toList();
        String userLower = userAnswer.toLowerCase();
        return keywords.any((keyword) => userLower.contains(keyword));
      case 'Scenario':
        // For scenario, we expect a short answer that matches keywords in expectedOutcome
        List<String> keywords = correctAnswerString.toLowerCase().split(',').map((e) => e.trim()).toList();
        String userLower = userAnswer.toLowerCase();
        return keywords.any((keyword) => userLower.contains(keyword));
      default:
        // For unsupported question types, consider it incorrect or log an error
        debugPrint('Unsupported question type for validation: $questionType');
        return false;
    }
  }
}