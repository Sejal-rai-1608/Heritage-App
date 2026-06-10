import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  // 'en' for English, 'gu' for Gujarati, 'hi' for Hindi
  String _currentLanguage = 'en';

  String get currentLanguage => _currentLanguage;

  void changeLanguage(String languageCode) {
    if (['en', 'gu', 'hi'].contains(languageCode)) {
      _currentLanguage = languageCode;
      notifyListeners();
    }
  }

  // Helper method to get the translated text
  String getText(String key) {
    final Map<String, String>? translations = _dictionary[key];
    if (translations == null) {
      return key; // Fallback to key if not found
    }
    return translations[_currentLanguage] ?? translations['en'] ?? key;
  }

  // Master Dictionary for the App
  // Format: key: {'en': '...', 'gu': '...', 'hi': '...'}
  final Map<String, Map<String, String>> _dictionary = {
    // --- General ---
    'heritage_core': {
      'en': 'Heritage Core',
      'gu': 'હેરિટેજ કોર',
      'hi': 'हेरिटेज कोर',
    },
    'support': {
      'en': 'Support',
      'gu': 'સહાય',
      'hi': 'सहायता',
    },
    
    // --- Login Screen ---
    'mobile_number': {
      'en': 'Mobile Number',
      'gu': 'મોબાઈલ નંબર',
      'hi': 'मोबाइल नंबर',
    },
    'enter_mobile': {
      'en': 'Enter mobile number',
      'gu': 'મોબાઈલ નંબર દાખલ કરો',
      'hi': 'मोबाइल नंबर दर्ज करें',
    },
    'password': {
      'en': 'Password',
      'gu': 'પાસવર્ડ',
      'hi': 'पासवर्ड',
    },
    'enter_password': {
      'en': 'Enter password',
      'gu': 'પાસવર્ડ દાખલ કરો',
      'hi': 'पासवर्ड दर्ज करें',
    },
    'login': {
      'en': 'Login',
      'gu': 'લૉગિન',
      'hi': 'लॉग इन',
    },
    'forgot_password': {
      'en': 'Forgot Password?',
      'gu': 'પાસવર્ડ ભૂલી ગયા છો?',
      'hi': 'पासवर्ड भूल गए?',
    },
    'new_here': {
      'en': 'New here?',
      'gu': 'નવા છો?',
      'hi': 'नए हैं?',
    },
    'register_new': {
      'en': 'Register New Account',
      'gu': 'નવું એકાઉન્ટ રજીસ્ટર કરો',
      'hi': 'नया अकाउंट रजिस्टर करें',
    },
    'preferred_language': {
      'en': 'Preferred Language',
      'gu': 'પસંદગીની ભાષા',
      'hi': 'पसंदीदा भाषा',
    },
    'copyright': {
      'en': '© 2024 Heritage Core Community. All rights reserved.',
      'gu': '© 2024 હેરિટેજ કોર કોમ્યુનિટી. સર્વાધિકાર સુરક્ષિત.',
      'hi': '© 2024 हेरिटेज कोर कम्युनिटी। सर्वाधिकार सुरक्षित।',
    },
  };
}
