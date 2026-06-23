import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  // 'en' for English, 'gu' for Gujarati, 'hi' for Hindi
  String _currentLanguage = 'en';
  bool _isLoggedIn = false;
  String _selectedCommunity = '';

  // Profiling & Verification details
  bool _isProfileCompleted = false;
  bool _isProfileApproved = false;
  Map<String, String> _profileDetails = {};

  // Post announcement list
  final List<Map<String, dynamic>> _posts = [
    {
      'id': 'mock-1',
      'type': 'Job',
      'content':
          'Urgent requirement for Senior Flutter Developer at TechSolutions. Ahmedabad. 3+ years experience required.',
      'whatsappNumber': '9876543210',
      'userName': 'Suresh Patel',
      'date': '12-Jun-2026',
      'isApproved': true,
      'imagePath': null,
    },
    {
      'id': 'mock-2',
      'type': 'Property',
      'content':
          'Beautiful 3 BHK flat for sale in Satellite area, Ahmedabad. Ready to move. Prime location.',
      'whatsappNumber': '9511000666',
      'userName': 'Amit Patel',
      'date': '13-Jun-2026',
      'isApproved': true,
      'imagePath': null,
    },
    {
      'id': 'mock-3',
      'type': 'Commercial',
      'content':
          'Office space available for rent on SG Highway. 1500 sq ft, fully furnished with cafeteria.',
      'whatsappNumber': '9111222333',
      'userName': 'Karan Patel',
      'date': '14-Jun-2026',
      'isApproved': true,
      'imagePath': null,
    },
    {
      'id': 'mock-4',
      'type': 'Death',
      'content':
          'Sad Demise: Shri Mansukhbhai Pragjibhai Patel passed away on 14-Jun-2026. Besna (prayer meet) on 16-Jun at 9:00 AM.',
      'whatsappNumber': '',
      'userName': 'Ramesh Patel',
      'date': '14-Jun-2026',
      'isApproved': true,
      'imagePath': null,
    },
  ];

  // Registered members directory list (can be loaded from real API/DB)
  List<Map<String, dynamic>> _directoryMembers = [
    {
      'name': 'Amit Patel',
      'city': 'Ahmedabad',
      'profession': 'Textile Business',
      'isMale': true,
      'phone': '9876543210',
    },
    {
      'name': 'Anjali Shah',
      'city': 'Surat',
      'profession': 'Gynecologist',
      'isMale': false,
      'phone': '9123456789',
    },
    {
      'name': 'Bharat Gandhi',
      'city': 'Rajkot',
      'profession': 'Civil Engineer',
      'isMale': true,
      'phone': '9234567890',
    },
    {
      'name': 'Bhavna Desai',
      'city': 'Vadodara',
      'profession': 'School Principal',
      'isMale': false,
      'phone': '9345678901',
    },
    {
      'name': 'Chirag Mehta',
      'city': 'Ahmedabad',
      'profession': 'Software Consultant',
      'isMale': true,
      'phone': '9456789012',
    },
  ];

  // Invite contacts list (can be loaded from device contacts or real API)
  List<Map<String, dynamic>> _contacts = [
    {'name': 'Bafna Infra Palghar', 'isFavourite': true},
    {'name': 'Aai', 'isFavourite': false},
    {'name': 'Ad Naik', 'isFavourite': false},
    {'name': 'Adarsh', 'isFavourite': false},
    {'name': 'Adhar Card Center rahul Mali', 'isFavourite': false},
    {'name': 'Adil Sir', 'isFavourite': false},
    {'name': 'Aditi', 'isFavourite': false},
    {'name': 'Aditya Clg', 'isFavourite': false},
    {'name': 'Aditya Ds', 'isFavourite': false},
    {'name': 'Adu', 'isFavourite': false},
    {'name': 'Akash Shah', 'isFavourite': false},
    {'name': 'Alpesh', 'isFavourite': false},
  ];

  String? _profileImageUrl;

  List<Map<String, dynamic>> _businesses = [
    {
      'name': 'Akshaykumar Rajkumar Kadam',
      'city': 'Kolhapur',
      'area': 'Kharghar',
      'category': 'Accountant',
      'image':
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
      'description':
          'Professional Accounting & Tax Consultant. GST filings, Audits & Income Tax returns.',
      'phone': '9876543210',
      'isPublic': true,
    },
    {
      'name': 'Pravin Mahadeo Modak',
      'city': 'Modakwadi',
      'area': 'Ghansoli',
      'category': 'Accountant',
      'image':
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150',
      'description':
          'Tax Analyst and Auditor with 10+ years experience. Financial consultations.',
      'phone': '9123456789',
      'isPublic': true,
    },
    {
      'name': 'Aparna Vidhyadhar Khamkar',
      'city': 'Vilavade',
      'area': 'J.M. Road',
      'category': 'Accountant',
      'image':
          'https://images.unsplash.com/photo-1628157582853-a796fa650a6a?w=150',
      'description':
          'Bookkeeping, Payroll management, and Financial Statement analysis services.',
      'phone': '9234567890',
      'isPublic': true,
    },
    {
      'name': 'Akshay Prakash Jadhav',
      'city': 'Satara',
      'area': 'Satara',
      'category': 'Accountant',
      'image':
          'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=150',
      'description':
          'Chartered Accountant assistant. Auditing & Taxation planning.',
      'phone': '9345678901',
      'isPublic': true,
    },
    {
      'name': 'Madhuri Santosh Mane',
      'city': 'Girewadi',
      'area': 'Panvel City',
      'category': 'Accountant',
      'image':
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
      'description':
          'Financial advisor, wealth management, and corporate audit specialist.',
      'phone': '9456789012',
      'isPublic': true,
    },
    {
      'name': 'Swati Anil Satpute',
      'city': 'Shive',
      'area': 'Vesava',
      'category': 'Accountant',
      'image':
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
      'description':
          'Independent Accountant. Small business bookkeeping and tax support.',
      'phone': '9567890123',
      'isPublic': true,
    },
    {
      'name': 'Ajitbhai Vinayak Beloshe',
      'city': 'Ruighar',
      'area': 'Kopar Khairne',
      'category': 'Accountant',
      'image':
          'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=150',
      'description':
          'Tax planning, corporate tax compliance, and business formation consulting.',
      'phone': '9678901234',
      'isPublic': true,
    },
  ];

  String get currentLanguage => _currentLanguage;
  bool get isLoggedIn => _isLoggedIn;
  String get selectedCommunity => _selectedCommunity;

  bool get isProfileCompleted => _isProfileCompleted;
  bool get isProfileApproved => _isProfileApproved;
  Map<String, String> get profileDetails => _profileDetails;
  List<Map<String, dynamic>> get posts => _posts;
  List<Map<String, dynamic>> get directoryMembers => _directoryMembers;
  List<Map<String, dynamic>> get contacts => _contacts;
  String? get profileImageUrl => _profileImageUrl;
  List<Map<String, dynamic>> get businesses => _businesses;

  void setDirectoryMembers(List<Map<String, dynamic>> members) {
    _directoryMembers = members;
    notifyListeners();
  }

  void setContacts(List<Map<String, dynamic>> contactsList) {
    _contacts = contactsList;
    notifyListeners();
  }

  void setProfileImageUrl(String? url) {
    _profileImageUrl = url;
    notifyListeners();
  }

  void setBusinesses(List<Map<String, dynamic>> businessList) {
    _businesses = businessList;
    notifyListeners();
  }

  void addBusiness(Map<String, dynamic> business) {
    _businesses.add(business);
    notifyListeners();
  }

  String get registeredName {
    final first = _profileDetails['firstName'] ?? '';
    final surname = _profileDetails['familySurname'] ?? '';
    if (first.isEmpty && surname.isEmpty) return '';
    return '$first $surname'.trim();
  }

  void changeLanguage(String languageCode) {
    if (['en', 'gu', 'hi', 'mr'].contains(languageCode)) {
      _currentLanguage = languageCode;
      notifyListeners();
    }
  }

  void setLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  void setSelectedCommunity(String community) {
    _selectedCommunity = community;
    notifyListeners();
  }

  void submitProfileDetails(Map<String, String> details) {
    _profileDetails = details;
    _isProfileCompleted = true;
    _isProfileApproved = false; // reset approval on new submission
    notifyListeners();
  }

  void simulateAdminApproval() {
    _isProfileApproved = true;
    _isLoggedIn = true; // when approved, they are fully logged in
    notifyListeners();
  }

  void resetProfile() {
    _profileDetails = {};
    _isProfileCompleted = false;
    _isProfileApproved = false;
    _isLoggedIn = false;
    notifyListeners();
  }

  void updateProfileDetail(String key, String value) {
    _profileDetails[key] = value;
    notifyListeners();
  }

  void addPost(
    String type,
    String content,
    String whatsappNumber, {
    String? imagePath,
  }) {
    _posts.add({
      'id': 'post-${DateTime.now().millisecondsSinceEpoch}',
      'type': type,
      'content': content,
      'whatsappNumber': whatsappNumber,
      'userName': registeredName.isNotEmpty ? registeredName : 'Sanjay Patel',
      'date': '14-Jun-2026',
      'isApproved': false,
      'imagePath': imagePath,
    });
    notifyListeners();
  }

  void approveAllPendingPosts() {
    for (var post in _posts) {
      post['isApproved'] = true;
    }
    notifyListeners();
  }

  void deletePost(String id) {
    _posts.removeWhere((p) => p['id'] == id);
    notifyListeners();
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
    'support': {'en': 'Support', 'gu': 'સહાય', 'hi': 'सहायता'},
    'help_center': {
      'en': 'HELP CENTER',
      'gu': 'મદદ કેન્દ્ર',
      'hi': 'सहायता केंद्र',
    },
    'how_can_we_help': {
      'en': 'How can we help you today?',
      'gu': 'આજે અમે તમને કેવી રીતે મદદ કરી શકીએ?',
      'hi': 'आज हम आपकी क्या सहायता कर सकते हैं?',
    },
    'help_subtitle': {
      'en':
          'We are here to ensure the Gujarati Heritage Core community stays connected and supported.',
      'gu':
          'ગુજરાતી હેરિટેજ કોર સમુદાય જોડાયેલ અને સહાયભૂત રહે તે સુનિશ્ચિત કરવા માટે અમે અહીં છીએ.',
      'hi':
          'हम यहाँ यह सुनिश्चित करने के लिए हैं कि गुजराती हेरिटेज कोर समुदाय जुड़ा रहे और उसे सहायता मिलती रहे।',
    },
    'call': {'en': 'Call', 'gu': 'કૉલ કરો', 'hi': 'कॉल करें'},
    'send_message_admin': {
      'en': 'Send Message To Admin',
      'gu': 'એડમિનને સંદેશ મોકલો',
      'hi': 'एडमिन को संदेश भेजें',
    },
    'faq': {
      'en': 'Frequently Asked Questions',
      'gu': 'વારંવાર પૂછાતા પ્રશ્નો',
      'hi': 'अक्सर पूछे जाने वाले प्रश्न',
    },
    'faq_subtitle': {
      'en': 'Browse common topics and community guides.',
      'gu': 'સામાન્ય વિષયો અને સમુદાય માર્ગદર્શિકાઓ શોધો.',
      'hi': 'सामान्य विषयों और समुदाय गाइडों को ब्राउज़ करें।',
    },
    'browse': {'en': 'Browse', 'gu': 'શોધો', 'hi': 'ब्राउज़ करें'},
    'trusted_members': {
      'en': 'Trusted by 10,000+ members',
      'gu': '૧૦,૦૦૦+ સભ્યો દ્વારા વિશ્વસનીય',
      'hi': '१०,०००+ सदस्यों द्वारा विश्वसनीय',
    },
    'support_footer': {
      'en': 'Heritage Core Community Support v1.4.2',
      'gu': 'હેરિટેજ કોર સમુદાય સપોર્ટ v1.4.2',
      'hi': 'हेरिटेज कोर कम्युनिटी सपोर्ट v1.4.2',
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
    'password': {'en': 'Password', 'gu': 'પાસવર્ડ', 'hi': 'पासवर्ड'},
    'enter_password': {
      'en': 'Enter password',
      'gu': 'પાસવર્ડ દાખલ કરો',
      'hi': 'पासवर्ड दर्ज करें',
    },
    'login': {'en': 'Login', 'gu': 'લૉગિન', 'hi': 'लॉग इन'},
    'forgot_password': {
      'en': 'Forgot Password?',
      'gu': 'પાસવર્ડ ભૂલી ગયા છો?',
      'hi': 'पासवर्ड भूल गए?',
    },
    'new_here': {'en': 'New here?', 'gu': 'નવા છો?', 'hi': 'नए हैं?'},
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

    // --- OTP Screen ---
    'back': {'en': 'Back', 'gu': 'પાછા જાઓ', 'hi': 'वापस जाएँ'},
    'enter_otp_title': {
      'en': 'Enter the code that was sent to you in SMS',
      'gu': 'SMS દ્વારા મોકલેલો કોડ દાખલ કરો',
      'hi': 'SMS में भेजा गया कोड दर्ज करें',
    },
    'verify_otp': {
      'en': 'Verify OTP',
      'gu': 'OTP ચકાસો',
      'hi': 'OTP सत्यापित करें',
    },
    'request_otp_again': {
      'en': 'Request OTP again',
      'gu': 'ફરીથી OTP મેળવો',
      'hi': 'दोबारा OTP भेजें',
    },
    'send_again': {
      'en': 'Send Again',
      'gu': 'ફરીથી મોકલો',
      'hi': 'दोबारा भेजें',
    },

    // --- Registration Screen ---
    'create_account': {
      'en': 'Create Account',
      'gu': 'એકાઉન્ટ બનાવો',
      'hi': 'अकाउंट बनाएँ',
    },
    'email': {'en': 'Email', 'gu': 'ઈમેલ', 'hi': 'ईमेल'},
    'enter_email': {
      'en': 'Enter email address',
      'gu': 'ઈમેલ આઈડી દાખલ કરો',
      'hi': 'ईमेल आईडी दर्ज करें',
    },
    'phone_number': {'en': 'Phone Number', 'gu': 'ફોન નંબર', 'hi': 'फ़ोन नंबर'},
    'enter_phone': {
      'en': 'Enter phone number',
      'gu': 'ફોન નંબર દાખલ કરો',
      'hi': 'फ़ोन नंबर दर्ज करें',
    },
    'create_password': {
      'en': 'Create Password',
      'gu': 'પાસવર્ડ બનાવો',
      'hi': 'पासवर्ड बनाएँ',
    },
    'enter_new_password': {
      'en': 'Enter new password',
      'gu': 'નવો પાસવર્ડ દાખલ કરો',
      'hi': 'नया पासवर्ड दर्ज करें',
    },
    'confirm_password': {
      'en': 'Confirm Password',
      'gu': 'પાસવર્ડ ખાતરી કરો',
      'hi': 'पासवर्ड की पुष्टि करें',
    },
    'enter_confirm_password': {
      'en': 'Re-enter password',
      'gu': 'પાસવર્ડ ફરીથી દાખલ કરો',
      'hi': 'पासवर्ड दोबारा दर्ज करें',
    },
    'register': {'en': 'Register', 'gu': 'રજીસ્ટર કરો', 'hi': 'रजिस्टर करें'},
    'already_have_account': {
      'en': 'Already have an account?',
      'gu': 'પહેલેથી એકાઉન્ટ છે?',
      'hi': 'पहले से अकाउंट है?',
    },
    'login_here': {
      'en': 'Login here',
      'gu': 'અહીં લૉગિન કરો',
      'hi': 'यहाँ लॉग इन करें',
    },

    // --- Forgot Password Screen ---
    'forgot_password_title': {
      'en': 'Forgot Password',
      'gu': 'પાસવર્ડ ભૂલી ગયા',
      'hi': 'पासवर्ड भूल गए',
    },
    'forgot_password_subtitle': {
      'en': 'Enter your email or phone number to receive an OTP',
      'gu': 'OTP મેળવવા માટે તમારો ઈમેલ અથવા ફોન નંબર દાખલ કરો',
      'hi': 'OTP प्राप्त करने के लिए अपना ईमेल या फ़ोन नंबर दर्ज करें',
    },
    'email_or_phone': {
      'en': 'Email / Phone Number',
      'gu': 'ઈમેલ / ફોન નંબર',
      'hi': 'ईमेल / फ़ोन नंबर',
    },
    'enter_email_or_phone': {
      'en': 'Enter email or phone number',
      'gu': 'ઈમેલ અથવા ફોન નંબર દાખલ કરો',
      'hi': 'ईमेल या फ़ोन नंबर दर्ज करें',
    },
    'get_otp': {'en': 'Get OTP', 'gu': 'OTP મેળવો', 'hi': 'OTP प्राप्त करें'},

    // --- Reset Password Screen ---
    'reset_password_title': {
      'en': 'Reset Password',
      'gu': 'પાસવર્ડ રીસેટ કરો',
      'hi': 'पासवर्ड रीसेट करें',
    },
    'reset_password_subtitle': {
      'en': 'Create a new password for your account',
      'gu': 'તમારા એકાઉન્ટ માટે નવો પાસવર્ડ બનાવો',
      'hi': 'अपने अकाउंट के लिए नया पासवर्ड बनाएँ',
    },
    'new_password': {
      'en': 'New Password',
      'gu': 'નવો પાસવર્ડ',
      'hi': 'नया पासवर्ड',
    },
    'enter_new_pw': {
      'en': 'Enter new password',
      'gu': 'નવો પાસવર્ડ દાખલ કરો',
      'hi': 'नया पासवर्ड दर्ज करें',
    },
    'confirm_new_password': {
      'en': 'Confirm New Password',
      'gu': 'નવા પાસવર્ડની ખાતરી કરો',
      'hi': 'नए पासवर्ड की पुष्टि करें',
    },
    'enter_confirm_new_pw': {
      'en': 'Re-enter new password',
      'gu': 'નવો પાસવર્ડ ફરીથી દાખલ કરો',
      'hi': 'नया पासवर्ड दोबारा दर्ज करें',
    },
    'get_started': {'en': 'Get Started', 'gu': 'શરૂ કરો', 'hi': 'शुरू करें'},

    // --- Home Screen ---
    'home': {'en': 'Home', 'gu': 'હોમ', 'hi': 'होम'},
    'job': {'en': 'Job', 'gu': 'નોકરી', 'hi': 'नौकरी'},
    'property': {'en': 'Property', 'gu': 'મિલકત', 'hi': 'संपत्ति'},
    'commercial': {'en': 'Commercial', 'gu': 'વ્યાપારી', 'hi': 'व्यावसायिक'},
    'explore_categories': {
      'en': 'Explore Categories',
      'gu': 'શ્રેણીઓ શોધો',
      'hi': 'श्रेणियाँ देखें',
    },
    'jobs': {'en': 'Jobs', 'gu': 'નોકરીઓ', 'hi': 'नौकरियाँ'},
    'matrimony': {'en': 'Matrimony', 'gu': 'લગ્ન', 'hi': 'विवाह'},
    'obituary': {'en': 'Obituary', 'gu': 'શ્રદ્ધાંજલિ', 'hi': 'श्रद्धांजलि'},
    'events': {'en': 'Events', 'gu': 'ઇવેન્ટ્સ', 'hi': 'कार्यक्रम'},
    'business': {'en': 'Business', 'gu': 'વ્યાપાર', 'hi': 'व्यापार'},
    'donation': {
      'en': 'Donation',
      'gu': 'દાન',
      'hi': 'दान',
    },
    'samuhik_vivah': {
      'en': 'Samuhik Vivaah',
      'gu': 'સમૂહ લગ્ન',
      'hi': 'सामूहिक विवाह',
    },
    'community_support': {
      'en': 'Community Support',
      'gu': 'સમુદાય સહાય',
      'hi': 'सामुदायिक सहायता',
    },
    'donation_requests': {
      'en': 'DONATION REQUESTS',
      'gu': 'દાન વિનંતીઓ',
      'hi': 'दान अनुरोध',
    },
    'active_donations': {
      'en': 'ACTIVE DONATIONS',
      'gu': 'સક્રિય દાન',
      'hi': 'सक्रिय दान',
    },
    'completed_donations': {
      'en': 'COMPLETED DONATIONS',
      'gu': 'પૂર્ણ થયેલ દાન',
      'hi': 'पूर्ण दान',
    },
    'donate_now': {
      'en': 'Donate Now',
      'gu': 'હમણાં જ દાન કરો',
      'hi': 'अभी दान करें',
    },
    'contribute_more': {
      'en': 'Contribute More',
      'gu': 'વધુ યોગદાન આપો',
      'hi': 'अधिक योगदान दें',
    },
    'view_impact_report': {
      'en': 'View Impact Report',
      'gu': 'અસર અહેવાલ જુઓ',
      'hi': 'प्रभाव रिपोर्ट देखें',
    },
    'donation_details': {
      'en': 'Donation Details',
      'gu': 'દાન વિગતો',
      'hi': 'दान विवरण',
    },
    'select_donation_amount': {
      'en': 'Select Donation Amount',
      'gu': 'દાનની રકમ પસંદ કરો',
      'hi': 'दान राशि चुनें',
    },
    'custom_amount': {
      'en': 'Custom Amount',
      'gu': 'અન્ય રકમ',
      'hi': 'अन्य राशि',
    },
    'donate_anonymously': {
      'en': 'Donate Anonymously',
      'gu': 'અનામી દાન કરો',
      'hi': 'गुमनाम रूप से दान करें',
    },
    'donate_anonymously_desc': {
      'en': 'Hide your name from the public list',
      'gu': 'જાહેર યાદીમાંથી તમારું નામ છુપાવો',
      'hi': 'सार्वजनिक सूची से अपना नाम छुपाएं',
    },
    'payment_method': {
      'en': 'Payment Method',
      'gu': 'ચુકવણી પદ્ધતિ',
      'hi': 'भुगतान विधि',
    },
    'confirm_donation': {
      'en': 'Confirm Donation',
      'gu': 'દાનની પુષ્ટિ કરો',
      'hi': 'दान की पुष्टि करें',
    },
    'upi_gpay': {
      'en': 'UPI - Google Pay',
      'gu': 'UPI - Google Pay',
      'hi': 'UPI - Google Pay',
    },
    'upi_gpay_desc': {
      'en': 'Instant and Secure',
      'gu': 'ઝડપી અને સુરક્ષિત',
      'hi': 'त्वरित और सुरक्षित',
    },
    'card': {
      'en': 'Credit / Debit Card',
      'gu': 'ક્રેડિટ / ડેબિટ કાર્ડ',
      'hi': 'क्रेडिट / डेबिट कार्ड',
    },
    'card_desc': {
      'en': 'Visa, Mastercard, RuPay',
      'gu': 'Visa, Mastercard, RuPay',
      'hi': 'Visa, Mastercard, RuPay',
    },
    'net_banking': {
      'en': 'Net Banking',
      'gu': 'નેટ બેંકિંગ',
      'hi': 'नेट बैंकिंग',
    },
    'net_banking_desc': {
      'en': 'All major Indian banks',
      'gu': 'બધી મુખ્ય ભારતીય બેંકો',
      'hi': 'सभी प्रमुख भारतीय बैंक',
    },
    'samuhik_vivah_title': {
      'en': 'Samuhik Vivaah',
      'gu': 'સમૂહ લગ્ન',
      'hi': 'सामूहिक विवाह',
    },
    'samuhik_vivah_subtitle': {
      'en': 'Celebrating tradition through community-led mass marriage ceremonies, ensuring every couple begins their journey with dignity and communal support.',
      'gu': 'સમુદાયના નેતૃત્વમાં સમૂહ લગ્ન સમારોહ દ્વારા પરંપરાની ઉજવણી, દરેક યુગલ ગૌરવ અને સામુદાયિક સમર્થન સાથે તેમની સફર શરૂ કરે તેની ખાતરી કરે છે.',
      'hi': 'सामुदायिक नेतृत्व वाले सामूहिक विवाह समारोहों के माध्यम से परंपरा का उत्सव, यह सुनिश्चित करना कि प्रत्येक युगल गरिमा और सामुदायिक समर्थन के साथ अपनी यात्रा शुरू करे।',
    },
    'annual_community_mass_marriage': {
      'en': 'Annual Community Mass Marriage 2024',
      'gu': 'વાર્ષિક સામુદાયિક સમૂહ લગ્ન ૨૦૨૪',
      'hi': 'वार्षिक सामुदायिक सामूहिक विवाह २०२४',
    },
    'funding_progress': {
      'en': 'Funding Progress',
      'gu': 'ફંડિંગ પ્રગતિ',
      'hi': 'फंडिंग प्रगति',
    },
    'raised_percent': {
      'en': '33% Raised',
      'gu': '૩૩% એકત્રિત',
      'hi': '३३% एकत्रित',
    },
    'register_as_couple': {
      'en': 'REGISTER AS COUPLE',
      'gu': 'દંપતી તરીકે નોંધણી કરો',
      'hi': 'युगल के रूप में पंजीकरण करें',
    },
    'upcoming_ceremonies': {
      'en': 'Upcoming Ceremonies',
      'gu': 'આગામી સમારોહ',
      'hi': 'आगामी समारोह',
    },
    'see_all': {
      'en': 'See All',
      'gu': 'બધા જુઓ',
      'hi': 'सभी देखें',
    },
    'regional_vivah_surat': {
      'en': 'Regional Vivaah - Surat',
      'gu': 'પ્રાદેશિક સમૂહ લગ્ન - સુરત',
      'hi': 'क्षेत्रीय सामूहिक विवाह - सूरत',
    },
    'sponsor_a_couple': {
      'en': 'Sponsor a Couple',
      'gu': 'એક દંપતીને સ્પોન્સર કરો',
      'hi': 'एक युगल को प्रायोजित करें',
    },
    'past_successes': {
      'en': 'Past Successes',
      'gu': 'ભૂતકાળની સફળતાઓ',
      'hi': 'पिछली सफलताएं',
    },
    'couples_united_count': {
      'en': '50+ Couples',
      'gu': '૫૦+ યુગલો',
      'hi': '૫૦+ युगल',
    },
    'united_in_year': {
      'en': 'United in 2023 ceremony',
      'gu': '૨૦૨૩ ના સમારોહમાં જોડાયા',
      'hi': '२०२३ समारोह में एकजुट',
    },
    'view_gallery': {
      'en': 'View Gallery',
      'gu': 'ગેલેરી જુઓ',
      'hi': 'गैलरी देखें',
    },
    'community_feed': {
      'en': 'Community Feed',
      'gu': 'સમુદાય ફીડ',
      'hi': 'समुदाय फ़ीड',
    },
    'view_all': {'en': 'View All', 'gu': 'બધા જુઓ', 'hi': 'सभी देखें'},
    'welcome_heritage': {
      'en': 'Welcome to Heritage App',
      'gu': 'હેરિટેજ એપમાં આપનું સ્વાગત છે',
      'hi': 'हेरिटेज ऐप में आपका स्वागत है',
    },
    'complete_registration': {
      'en': 'Complete Registration',
      'gu': 'રજીસ્ટ્રેશન પૂર્ણ કરો',
      'hi': 'रजिस्ट्रेशन पूरा करें',
    },
    'profile': {'en': 'Profile', 'gu': 'પ્રોફાઈલ', 'hi': 'प्रोफ़ाइल'},
    'community_profile': {
      'en': 'Community Profile',
      'gu': 'સમુદાય પ્રોફાઇલ',
      'hi': 'समुदाय प्रोफ़ाइल',
      'mr': 'समुदाय प्रोफाइल',
    },
    'edit': {'en': 'Edit', 'gu': 'ફેરફાર', 'hi': 'संपादन'},

    // --- Side Drawer ---
    'please_login': {
      'en': 'Please Login',
      'gu': 'કૃપા કરી લૉગિન કરો',
      'hi': 'कृपया लॉग इन करें',
    },
    'gujarati_community': {
      'en': 'Gujarati Community',
      'gu': 'ગુજરાતી સમુદાય',
      'hi': 'गुजराती समुदाय',
    },
    'send_messages': {
      'en': 'Send Messages',
      'gu': 'સંદેશ મોકલો',
      'hi': 'संदेश भेजें',
    },
    'directory': {'en': 'Directory', 'gu': 'ડિરેક્ટરી', 'hi': 'डायरेक्टरी'},
    'business_directory': {
      'en': 'Business Directory',
      'gu': 'વ્યાપાર ડિરેક્ટરી',
      'hi': 'व्यापार डायरेक्टरी',
    },
    'invite_members': {
      'en': 'Invite Members',
      'gu': 'સભ્યોને આમંત્રણ આપો',
      'hi': 'सदस्यों को आमंत्रित करें',
    },
    'share_app': {'en': 'Share App', 'gu': 'એપ શેર કરો', 'hi': 'ऐप शेयर करें'},
    'settings': {
      'en': 'Settings',
      'gu': 'સેટિંગ્સ',
      'hi': 'सेटिंग्स',
      'mr': 'सेटिंग्ज',
    },
    'help_feedback': {
      'en': 'Help & Feedback',
      'gu': 'મદદ અને પ્રતિસાદ',
      'hi': 'सहायता और प्रतिक्रिया',
      'mr': 'मदत आणि अभिप्राय',
    },
    'select_language': {
      'en': 'Select Language',
      'gu': 'ભાષા પસંદ કરો',
      'hi': 'ભાષા પસંદ કરો',
      'mr': 'भाषा निवडा',
    },
    'select_community': {
      'en': 'Select Community',
      'gu': 'સમુદાય પસંદ કરો',
      'hi': 'समुदाय चुनें',
      'mr': 'समुदाय निवडा',
    },
    'logout': {'en': 'Logout', 'gu': 'લોગઆઉટ', 'hi': 'लॉगआउट', 'mr': 'लॉगआउट'},
    'storage_usage': {
      'en': 'Storage Usage',
      'gu': 'સંગ્રહ વપરાશ',
      'hi': 'स्टोरेज उपयोग',
      'mr': 'स्टोरेज वापर',
    },
    'terms_of_service': {
      'en': 'Terms of Service',
      'gu': 'સેવાની શરતો',
      'hi': 'सेवा की शर्तें',
      'mr': 'सेवा अटी',
    },
    'community_directory': {
      'en': 'Community Directory',
      'gu': 'સમુદાય ડિરેક્ટરી',
      'hi': 'समुदाय निर्देशिका',
      'mr': 'समुदाय निर्देशिका',
    },
    'view_registration_status': {
      'en': 'View Registration Status',
      'gu': 'રજીસ્ટ્રેશન સ્થિતિ જુઓ',
      'hi': 'पंजीकरण स्थिति देखें',
    },
    'registration_pending': {
      'en': 'Registration Pending',
      'gu': 'નોંધણી બાકી છે',
      'hi': 'पंजीकरण लंबित है',
    },
    'registration_pending_desc': {
      'en':
          'Your registration is pending administrator approval. You can check your registration status here.',
      'gu':
          'તમારી નોંધણી એડમિનિસ્ટ્રેટરની મંજૂરી માટે બાકી છે. તમે અહીં તમારી સ્થિતિ ચકાસી શકો છો.',
      'hi':
          'आपका पंजीकरण प्रशासक की स्वीकृति के लिए लंबित है। आप यहाँ अपनी स्थिति की जाँच कर सकते हैं।',
    },
    'view_status': {
      'en': 'View Status',
      'gu': 'સ્થિતિ જુઓ',
      'hi': 'स्थिति देखें',
    },
  };
}
