import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/language_provider.dart';
import 'registration_form_screen.dart';
import 'profile_screen.dart';
import 'new_message_screen.dart';
import 'business_directory_screen.dart';
import 'matches_screen.dart';
import 'member_directory_screen.dart';
import 'settings_screen.dart';
import 'samuhik_vivaah_screen.dart';
import 'donation_causes_screen.dart';
import 'support_screen.dart';
import 'notifications_screen.dart';
import 'family_tree_screen.dart';
import 'jobs_screen.dart';
import 'property_screen.dart';
import '../widgets/custom_bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  final String? userName;

  static List<Map<String, dynamic>> userJobsList = [];

  static void addJobVacancy(Map<String, dynamic> newJob) {
    userJobsList.insert(0, newJob);
  }

  const HomeScreen({super.key, this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageController _pageController = PageController(initialPage: 0);
  final int _selectedIndex = 0;
  bool _isCategoriesExpanded = true;
  String _selectedNewsFilter = 'All';

  final List<Map<String, dynamic>> _newsItems = [
    {
      'id': 'news_1',
      'type': 'Jobs',
      'badge': 'JOB VACANCY',
      'badgeColor': const Color(0xFF1E40AF),
      'badgeBg': const Color(0xFFDBEAFE),
      'author': 'Patel & Co. CA Firm',
      'authorAvatar': 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=150&auto=format&fit=crop&q=80',
      'timeEn': '2 hrs ago',
      'timeGu': '૨ કલાક પહેલાં',
      'location': 'Ahmedabad, Gujarat',
      'titleEn': 'Hiring Senior Accountant (GST & Tally Prime)',
      'titleGu': 'સિનિયર એકાઉન્ટન્ટની જરૂર છે (જીએસટી અને ટેલી)',
      'descEn': 'Looking for an experienced accountant with 3+ years in auditing and GST returns. Package: ₹35,000/month.',
      'descGu': 'ઓડિટિંગ અને જીએસટી રિટર્ન્સમાં ૩+ વર્ષનો અનુભવ ધરાવતા અનુભવી એકાઉન્ટન્ટની જરૂર છે. પગાર ₹૩૫,૦૦૦/મહિનો.',
      'image': 'https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?w=800&auto=format&fit=crop&q=80',
      'actionEn': 'Apply / Contact',
      'actionGu': 'અરજી કરો / સંપર્ક',
      'likes': 28,
      'comments': 6,
      'isLiked': false,
      'contact': '+91 98250 11223 (CA Rajesh Patel)',
    },
    {
      'id': 'news_2',
      'type': 'Promotions',
      'badge': 'BUSINESS PROMOTION',
      'badgeColor': const Color(0xFFB45309),
      'badgeBg': const Color(0xFFFEF3C7),
      'author': 'Royal Heritage Jewellers',
      'authorAvatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&auto=format&fit=crop&q=80',
      'timeEn': '4 hrs ago',
      'timeGu': '૪ કલાક પહેલાં',
      'location': 'CG Road, Ahmedabad',
      'titleEn': 'Exclusive Festive Gold & Diamond Offer - 25% Off Making Charges',
      'titleGu': 'સોના-ચાંદીના આભૂષણો પર ૨૫% મજૂરી ડિસ્કાઉન્ટ ઑફર',
      'descEn': 'Special community discount for SWAJAN app members on authentic bridal Kundan & Polki jewellery sets.',
      'descGu': 'સ્વજન એપના સભ્યો માટે બ્રાઇડલ કુંદન અને પોલકી જ્વેલરી પર ખાસ સામુદાયિક ડિસ્કાઉન્ટ.',
      'image': 'https://images.unsplash.com/photo-1610030469983-98e550d6193c?w=800&auto=format&fit=crop&q=80',
      'actionEn': 'Claim Discount Code',
      'actionGu': 'ડિસ્કાઉન્ટ કોડ મેળવો',
      'likes': 64,
      'comments': 14,
      'isLiked': false,
      'contact': 'Code: SWAJANGOLD25 | Phone: +91 99099 88776',
    },
    {
      'id': 'news_3',
      'type': 'Marketplace',
      'badge': 'BUY & SELL • ₹24,000',
      'badgeColor': const Color(0xFF047857),
      'badgeBg': const Color(0xFFD1FAE5),
      'author': 'Dr. Mihir Shah',
      'authorAvatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&auto=format&fit=crop&q=80',
      'timeEn': 'Yesterday',
      'timeGu': 'ગઇકાલે',
      'location': 'Alkapuri, Vadodara',
      'titleEn': 'Pure Burma Teakwood 6-Seater Dining Set for Sale',
      'titleGu': 'સાગના લાકડાનું ૬-સીટર ડાઇનિંગ સેટ વેચવાનું છે',
      'descEn': 'Gently used handcrafted teakwood dining table with velvet cushioned chairs. Excellent condition.',
      'descGu': 'ઉત્તમ સ્થિતિમાં વાપરેલું ઓરિજિનલ સાગના લાકડાનું ડાઇનિંગ ટેબલ. કિંમત વાટાઘાટ યોગ્ય.',
      'image': 'https://images.unsplash.com/photo-1615066390971-03e4e1c36ddf?w=800&auto=format&fit=crop&q=80',
      'actionEn': 'Contact Seller',
      'actionGu': 'વેચનારનો સંપર્ક કરો',
      'likes': 19,
      'comments': 8,
      'isLiked': false,
      'contact': '+91 98795 44321 (Dr. Mihir Shah)',
    },
    {
      'id': 'news_4',
      'type': 'Birthdays',
      'badge': 'BIRTHDAY WISHES 🎂',
      'badgeColor': const Color(0xFFBE185D),
      'badgeBg': const Color(0xFFFCE7F3),
      'author': 'Shah Family',
      'authorAvatar': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&auto=format&fit=crop&q=80',
      'timeEn': 'Today',
      'timeGu': 'આજે',
      'location': 'Rajkot, Gujarat',
      'titleEn': 'Wishing Respected Smt. Hansaben Shah a Happy 75th Birthday!',
      'titleGu': 'પૂજ્ય શ્રીમતી હંસાબેન શાહને ૭૫મા જન્મદિવસે હાર્દિક શુભેચ્છાઓ!',
      'descEn': 'Join us in sending health, joy, and longevity blessings to our beloved senior community matriarch on her milestone 75th birthday.',
      'descGu': 'આપણા વરિષ્ઠ સભ્યના ૭૫મા જન્મદિવસ નિમિત્તે ઉત્તમ સ્વાસ્થ્ય અને દીર્ઘાયુ માટે શુભેચ્છાઓ પાઠવો.',
      'image': 'https://images.unsplash.com/photo-1513151233558-d860c5398176?w=800&auto=format&fit=crop&q=80',
      'actionEn': 'Send Birthday Wishes',
      'actionGu': 'જન્મદિવસની શુભેચ્છા આપો',
      'likes': 142,
      'comments': 38,
      'isLiked': false,
      'contact': 'Send your blessings & messages directly!',
    },
    {
      'id': 'news_5',
      'type': 'New Members',
      'badge': 'NEW MEMBER WELCOME 👋',
      'badgeColor': const Color(0xFF6D28D9),
      'badgeBg': const Color(0xFFEDE9FE),
      'author': 'Swajan Community Board',
      'authorAvatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&auto=format&fit=crop&q=80',
      'timeEn': '1 day ago',
      'timeGu': '૧ દિવસ પહેલાં',
      'location': 'Surat Chapter',
      'titleEn': 'Warm Welcome to Er. Anand Mehta & Family!',
      'titleGu': 'ઇજનેર આણંદ મહેતા અને પરિવારનું સ્વજનમાં સ્વાગત છે!',
      'descEn': 'Anand bhai is Senior VP at Larsen & Toubro Surat. We are thrilled to welcome his family to our vibrant Swajan community!',
      'descGu': 'આણંદભાઈ એલ એન્ડ ટી સુરતમાં સીનિયર વાઇસ પ્રેસિડેન્ટ છે. સ્વજન પરિવારમાં તેમનું હાર્દિક સ્વાગત છે!',
      'image': 'https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=800&auto=format&fit=crop&q=80',
      'actionEn': 'Say Hello',
      'actionGu': 'સ્વાગત સંદેશ મોકલો',
      'likes': 96,
      'comments': 21,
      'isLiked': false,
      'contact': 'Welcome Anand bhai to Surat SWAJAN chapter',
    },
    {
      'id': 'news_6',
      'type': 'Obituary',
      'badge': 'OBITUARY & CONDOLENCE 🕊️',
      'badgeColor': const Color(0xFF374151),
      'badgeBg': const Color(0xFFF3F4F6),
      'author': 'Patel Family',
      'authorAvatar': 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&auto=format&fit=crop&q=80',
      'timeEn': 'Yesterday',
      'timeGu': 'ગઇકાલે',
      'location': 'Anand, Gujarat',
      'titleEn': 'Sad Demise of Respected Late Shri Pravinbhai Chhotabhai Patel (1942 - 2024)',
      'titleGu': 'આદરણીય સ્વ. પ્રવીણભાઈ છોટાભાઈ પટેલનું દુઃખદ અવસાન (૧૯૪૨ - ૨૦૨૪)',
      'descEn': 'Prarthana Sabha & Besna will be held on Friday from 4:00 PM to 6:00 PM at Community Hall, Anand. Om Shanti.',
      'descGu': 'પ્રાર્થના સભા અને બેસણું શુક્રવારે સાંજે ૪:૦૦ થી ૬:૦૦ કલાકે કમ્યુનિટી હોલ, આણંદ ખાતે રાખેલ છે. ઓમ શાંતિ.',
      'image': 'https://images.unsplash.com/photo-1518241353330-0f7941c2d9b5?w=800&auto=format&fit=crop&q=80',
      'actionEn': 'Pay Tribute / Condolence',
      'actionGu': 'શ્રદ્ધાંજલિ અર્પિત કરો',
      'likes': 185,
      'comments': 54,
      'isLiked': false,
      'contact': 'Besna Place: Swajan Community Hall, Anand',
    },
    {
      'id': 'news_7',
      'type': 'General News',
      'badge': 'COMMUNITY NEWS 📰',
      'badgeColor': const Color(0xFF0D9488),
      'badgeBg': const Color(0xFFCCFBF1),
      'author': 'Swajan Health Wing',
      'authorAvatar': 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=150&auto=format&fit=crop&q=80',
      'timeEn': '5 hrs ago',
      'timeGu': '૫ કલાક પહેલાં',
      'location': 'Community Hall, Vadodara',
      'titleEn': 'Mega Free Health Checkup & Blood Donation Camp Next Sunday',
      'titleGu': 'આવતા રવિવારે મેગા ફ્રી હેલ્થ ચેકઅપ અને રક્તદાન કેમ્પ',
      'descEn': 'Expert cardiologists, diabetologists, and eye specialists from Apollo Hospital will provide free consultations to all members.',
      'descGu': 'એપોલો હોસ્પિટલના નિષ્ણાત તબીબો દ્વારા તમામ સભ્યો માટે વિનામૂલ્યે તબીબી તપાસ અને સલાહ આપવામા આવશે.',
      'image': 'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=800&auto=format&fit=crop&q=80',
      'actionEn': 'Register Free Spot',
      'actionGu': 'નિઃશુલ્ક રજીસ્ટ્રેશન કરો',
      'likes': 110,
      'comments': 23,
      'isLiked': false,
      'contact': 'Registration desk open at Vadodara chapter',
    },
  ];


  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final Color primaryDark = const Color(0xFF191C21);
  final Color bgLight = const Color(0xFFF7F8FC);
  final Color cardBg = Colors.white;
  final Color accentGold = const Color(0xFFF3D276);
  final Color softBluePill = const Color(0xFFEFF3FA);
  final Color iconContainerBg = const Color(0xFF1E232D);


  void _showInviteMembersModal() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Row(
          children: const [
            Icon(Icons.person_add_rounded, color: Color(0xFFE5A93C), size: 26),
            SizedBox(width: 10),
            Text(
              'Invite Members',
              style: TextStyle(fontFamily: 'Serif', fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Share your exclusive community referral link to invite family & friends to SWAJAN:',
              style: TextStyle(fontSize: 13.5, color: Color(0xFF4A4E57), height: 1.4),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF7DB),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE5A93C)),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Text(
                      'https://swajanapp.com/invite?ref=COMMUNITY2024',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF8B6B00)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Invite link copied to clipboard! Share it with your community.'),
                  backgroundColor: Color(0xFF191C21),
                ),
              );
            },
            icon: const Icon(Icons.copy_rounded, size: 16, color: Color(0xFF191C21)),
            label: const Text('Copy Link', style: TextStyle(color: Color(0xFF191C21), fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE5A93C),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  void _showShareAppModal() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Row(
          children: const [
            Icon(Icons.share_rounded, color: Color(0xFFE5A93C), size: 26),
            SizedBox(width: 10),
            Text(
              'Share SWAJAN App',
              style: TextStyle(fontFamily: 'Serif', fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Help expand our Gujarati community network! Share the SWAJAN download link with your contacts:',
              style: TextStyle(fontSize: 13.5, color: Color(0xFF4A4E57), height: 1.4),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF7DB),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE5A93C)),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Text(
                      'https://swajanapp.com/download',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF8B6B00)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('App share link copied! Share via WhatsApp or SMS.'),
                  backgroundColor: Color(0xFF191C21),
                ),
              );
            },
            icon: const Icon(Icons.share_rounded, size: 16, color: Color(0xFF191C21)),
            label: const Text('Share Now', style: TextStyle(color: Color(0xFF191C21), fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE5A93C),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  void _handleVerifiedAction(VoidCallback onVerifiedSuccess) {
    final lang = Provider.of<LanguageProvider>(context, listen: false);
    if (!lang.isProfileApproved) {
      _showCompleteRegistrationDialog();
    } else {
      onVerifiedSuccess();
    }
  }

  Widget _buildUnverifiedUserBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5A93C), width: 1.8),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE5A93C).withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFFE5A93C),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.assignment_ind_rounded,
                  color: Color(0xFF191C21),
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Complete Your Registration',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF191C21),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Your profile is currently unverified. Please submit your full registration details to access directory, matrimony, and community benefits.',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF4A4E57),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const RegistrationFormScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE5A93C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Complete Registration Now',
                    style: TextStyle(
                      color: Color(0xFF191C21),
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward_rounded, color: Color(0xFF191C21), size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCompleteRegistrationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: const [
              Icon(Icons.assignment_ind_outlined, color: Color(0xFFE5A93C), size: 26),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Registration Required',
                  style: TextStyle(
                    fontFamily: 'Serif',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E232D),
                  ),
                ),
              ),
            ],
          ),
          content: const Text(
            'Your account is currently unverified. Please complete your registration profile to access full community features, directory, and matrimony.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF5A6270),
              height: 1.4,
            ),
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Later',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const RegistrationFormScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE5A93C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                elevation: 0,
              ),
              child: const Text(
                'Complete Registration',
                style: TextStyle(
                  color: Color(0xFF191C21),
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      drawer: _buildProfileDrawer(),
      backgroundColor: bgLight,
      body: _buildHomeBody(),

      // --- Floating Action Button ---
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _handleVerifiedAction(() {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const NewMessageScreen(),
              ),
            );
          });
        },
        backgroundColor: Colors.black,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),

      // --- Bottom Navigation Bar ---
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  
  String _getGujaratiName(String name) {
    if (name.isEmpty) return name;
    if (name.contains('Soham') || name.contains('soham')) return name.contains('More') ? 'સોહમ આદિત્ય મોરે' : 'સોહમ';
    if (name.contains('Aaditya') || name.contains('Aditya')) return name.contains('More') ? 'આદિત્ય શાંતનુ મોરે' : 'આદિત્ય';
    if (name.contains('Vaishali')) return 'વૈશાલી આદિત્ય મોરે';
    if (name.contains('Riya')) return 'રીયા આદિત્ય મોરે';
    if (name.contains('Shantaram')) return 'શાંતારામ ગોવિંદ મોરે';
    if (name.contains('Shantanu')) return 'શાંતનુ મોરે';
    if (name.contains('Sanjay')) return 'સંજય પટેલ';
    if (name.contains('Ramesh')) return 'રમેશ પરીખ';
    if (name.contains('More')) return name.replaceAll('More', 'મોરે');
    if (name.contains('Patel')) return name.replaceAll('Patel', 'પટેલ');
    return name;
  }

  Widget _buildHomeBody() {
    final lang = Provider.of<LanguageProvider>(context);

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Top Header ---
            _buildTopHeader(),
            const SizedBox(height: 24),

            // --- Greeting ---
            Text(
              lang.currentLanguage == 'gu'
                  ? 'નમસ્તે, ${_getGujaratiName(lang.registeredFirstName.isNotEmpty ? lang.registeredFirstName : (widget.userName != null && widget.userName!.isNotEmpty ? widget.userName! : 'Soham'))}!'
                  : 'Namaste, ${lang.registeredFirstName.isNotEmpty ? lang.registeredFirstName : (widget.userName != null && widget.userName!.isNotEmpty ? widget.userName! : 'Soham')}!',
              style: const TextStyle(
                fontFamily: 'Serif',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1D24),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              lang.currentLanguage == 'gu'
                  ? 'તમારા સમુદાય કેન્દ્રમાં આપનું સ્વાગત છે.'
                  : 'Welcome back to your community hub.',
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF757D8A),
                fontWeight: FontWeight.w400,
              ),
            ),
            if (!lang.isProfileApproved) ...[
              const SizedBox(height: 16),
              _buildUnverifiedUserBanner(),
            ],
            const SizedBox(height: 24),

            // --- Action Cards (My Profile, Family Tree, Community Directory) ---
            _buildMainActionCard(
              icon: Icons.person,
              title: lang.currentLanguage == 'gu' ? 'મારી પ્રોફાઇલ' : 'MY PROFILE',
              subtitle: lang.currentLanguage == 'gu' ? 'તમારો વ્યક્તિગત વારસો મેનેજ કરો' : 'Manage your personal legacy',
              onTap: () {
                _handleVerifiedAction(() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ProfileScreen(userName: widget.userName),
                    ),
                  );
                });
              },
            ),
            const SizedBox(height: 12),
            _buildMainActionCard(
              icon: Icons.account_tree,
              title: lang.currentLanguage == 'gu' ? 'કૌટુંબિક વૃક્ષ' : 'FAMILY TREE',
              subtitle: lang.currentLanguage == 'gu' ? 'તમારા પૂર્વજોના મૂળ શોધો' : 'Explore your ancestral roots',
              onTap: () {
                _handleVerifiedAction(() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => FamilyTreeScreen(userName: widget.userName),
                    ),
                  );
                });
              },
            ),
            const SizedBox(height: 12),
            _buildMainActionCard(
              icon: Icons.groups,
              title: lang.currentLanguage == 'gu' ? 'સમુદાય ડિરેક્ટરી' : 'COMMUNITY DIRECTORY',
              subtitle: lang.currentLanguage == 'gu' ? 'સ્થાનિક સભ્યો સાથે જોડાઓ' : 'Connect with local members',
              onTap: () {
                _handleVerifiedAction(() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => MemberDirectoryScreen(userName: widget.userName),
                    ),
                  );
                });
              },
            ),
            const SizedBox(height: 24),

            // --- Explore Categories Dropdown Tile ---
            _buildCategoriesTile(),
            const SizedBox(height: 24),

            // --- Featured Event Card (Grand Mass Marriage 2024) ---
            _buildFeaturedEventCard(),
            const SizedBox(height: 24),

            // --- Community News & Live Updates Feed ---
            _buildCommunityNewsFeedSection(),
            const SizedBox(height: 28),

            // --- Quick Directory ---
            _buildQuickDirectorySection(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // 1. Top Header Component
  Widget _buildTopHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Top Left: 3-Line Hamburger Menu Button
        IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(
            Icons.menu_rounded,
            color: Color(0xFF1E232D),
            size: 28,
          ),
          tooltip: 'Open Menu',
        ),

        // Center: SWAJAN App Title & Logo
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                'assets/images/swajan_logo.png',
                height: 28,
                width: 28,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const SizedBox(),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'SWAJAN',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Serif',
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E232D),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),

        // Top Right: Notification Bell + Profile Picture Avatar
        Row(
          children: [
            IconButton(
              onPressed: () {
                _handleVerifiedAction(() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const NotificationsScreen(),
                    ),
                  );
                });
              },
              icon: const Icon(
                Icons.notifications_none_outlined,
                color: Color(0xFF2D3139),
                size: 24,
              ),
              tooltip: 'Notifications',
            ),
            const SizedBox(width: 4),
            Consumer<LanguageProvider>(
              builder: (context, lang, child) {
                final hasImage = lang.profileImageUrl != null && lang.profileImageUrl!.isNotEmpty;
                return InkWell(
                  onTap: () {
                    _handleVerifiedAction(() {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ProfileScreen(userName: widget.userName),
                        ),
                      );
                    });
                  },
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: hasImage ? Colors.transparent : const Color(0xFFFFF7DB),
                      border: Border.all(color: const Color(0xFFE5A93C), width: 1.5),
                      image: hasImage
                          ? DecorationImage(
                              image: lang.profileImageUrl!.startsWith('http')
                                  ? NetworkImage(lang.profileImageUrl!) as ImageProvider
                                  : (File(lang.profileImageUrl!).existsSync()
                                      ? FileImage(File(lang.profileImageUrl!))
                                      : const AssetImage('assets/images/sanjay_profile.png') as ImageProvider),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: hasImage
                        ? null
                        : const Center(
                            child: Icon(
                              Icons.person_rounded,
                              color: Color(0xFF191C21),
                              size: 22,
                            ),
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  // 2. Main Top Action Card Widget
  Widget _buildMainActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: iconContainerBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF2C3038),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF8C94A0),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 3. Explore Categories Dropdown Tile
  Widget _buildCategoriesTile() {
    final lang = Provider.of<LanguageProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header Row (Clickable Dropdown Toggle)
          InkWell(
            onTap: () {
              setState(() {
                _isCategoriesExpanded = !_isCategoriesExpanded;
              });
            },
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                children: [
                  const Icon(
                    Icons.category_rounded,
                    color: Color(0xFF191C21),
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      lang.currentLanguage == 'gu' ? 'શ્રેણીઓ શોધો' : 'Explore Categories',
                      style: const TextStyle(
                        fontFamily: 'Serif',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF191C21),
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isCategoriesExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color(0xFF191C21),
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Dropdown Grid Content (Animated Expansion)
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 0),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _buildCategoryGridItem(
                          icon: Icons.work_outline_rounded,
                          label: lang.currentLanguage == 'gu' ? 'નોકરીઓ' : 'Jobs',
                          onTap: () {
                            _handleVerifiedAction(() {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => JobsScreen(userName: widget.userName),
                                ),
                              );
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildCategoryGridItem(
                          icon: Icons.apartment_rounded,
                          label: lang.currentLanguage == 'gu' ? 'મિલકત' : 'Property',
                          onTap: () {
                            _handleVerifiedAction(() {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => PropertyScreen(userName: widget.userName),
                                ),
                              );
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildCategoryGridItem(
                          icon: Icons.favorite_border_rounded,
                          label: lang.currentLanguage == 'gu' ? 'લગ્ન' : 'Matrimony',
                          onTap: () {
                            _handleVerifiedAction(() {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => MatchesScreen(userName: widget.userName),
                                ),
                              );
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildCategoryGridItem(
                          icon: Icons.volunteer_activism_outlined,
                          label: lang.currentLanguage == 'gu' ? 'દાન' : 'Donations',
                          onTap: () {
                            _handleVerifiedAction(() {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => DonationCausesScreen(userName: widget.userName),
                                ),
                              );
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildCategoryGridItem(
                          icon: Icons.celebration_outlined,
                          label: lang.currentLanguage == 'gu' ? 'ઇવેન્ટ્સ' : 'Events',
                          onTap: () {
                            _handleVerifiedAction(() {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => SamuhikVivaahScreen(userName: widget.userName),
                                ),
                              );
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildCategoryGridItem(
                          icon: Icons.business_center_outlined,
                          label: lang.currentLanguage == 'gu' ? 'વ્યાપાર' : 'Business',
                          onTap: () {
                            _handleVerifiedAction(() {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const BusinessDirectoryScreen(),
                                ),
                              );
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            crossFadeState: _isCategoriesExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryGridItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F3F7), width: 1.2),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFF9E6),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF836B20),
                    size: 24,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E232D),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 4. Featured Event Card
  Widget _buildFeaturedEventCard() {
    final lang = Provider.of<LanguageProvider>(context);
    return Container(
      height: 380,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1519741497674-611481863552?w=800&auto=format&fit=crop&q=80',
          ),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.2),
                  Colors.black.withValues(alpha: 0.85),
                ],
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Tag
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: accentGold,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    lang.currentLanguage == 'gu' ? 'મુખ્ય ઇવેન્ટ' : 'FEATURED EVENT',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF4A3800),
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Title
                Text(
                  lang.currentLanguage == 'gu' ? 'વાર્ષિક સમૂહ લગ્ન ૨૦૨૪' : 'Grand Mass Marriage 2024',
                  style: TextStyle(
                    fontFamily: 'Serif',
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 8),

                // Description
                Text(
                  lang.currentLanguage == 'gu' ? 'સૌથી પ્રતિષ્ઠિત સામુદાયિક લગ્ન સમારોહમાં જોડાઓ. એકતા અને સંસ્કૃતિની ઉજવણી.' : 'Join the most prestigious community wedding ceremony of the decade. Celebrating unity and culture.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.85),
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 14),

                // Date Row
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.white70, size: 14),
                    const SizedBox(width: 8),
                    Text(
                      lang.currentLanguage == 'gu' ? '૧૫ ડિસેમ્બર, ૨૦૨૪' : '15 December, 2024',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // See More Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      _handleVerifiedAction(() {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => SamuhikVivaahScreen(userName: widget.userName),
                          ),
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentGold,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      lang.currentLanguage == 'gu' ? 'વધુ જુઓ' : 'See More',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E232D),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Community News & Live Updates Feed ---
  Widget _buildCommunityNewsFeedSection() {
    final lang = Provider.of<LanguageProvider>(context);
    final isGu = lang.currentLanguage == 'gu';

    final filters = [
      {'id': 'All', 'en': 'All', 'gu': 'બધા'},
      {'id': 'Jobs', 'en': 'Jobs', 'gu': 'નોકરીઓ'},
      {'id': 'Promotions', 'en': 'Offers', 'gu': 'જાહેરાતો'},
      {'id': 'Marketplace', 'en': 'Buy & Sell', 'gu': 'લે-વેચ'},
      {'id': 'Birthdays', 'en': 'Birthdays', 'gu': 'જન્મદિવસ'},
      {'id': 'New Members', 'en': 'New Joiners', 'gu': 'નવા સભ્યો'},
      {'id': 'Obituary', 'en': 'Obituary', 'gu': 'શ્રદ્ધાંજલિ'},
      {'id': 'General News', 'en': 'General', 'gu': 'સમાચાર'},
    ];

    final combinedFeed = [...HomeScreen.userJobsList, ..._newsItems];
    final filteredList = combinedFeed.where((item) {
      if (_selectedNewsFilter == 'All') return true;
      return item['type'] == _selectedNewsFilter;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF7DB),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFE5A93C)),
                    ),
                    child: const Icon(Icons.newspaper_rounded, color: Color(0xFF8B6B00), size: 18),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      isGu ? 'દૈનિક સમુદાય સમાચાર & અપડેટ્સ' : 'Community Live Feed & News',
                      style: const TextStyle(
                        fontFamily: 'Serif',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E232D),
                        letterSpacing: -0.3,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF191C21),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFF22C55E),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    isGu ? 'લાઇવ' : 'LIVE',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Filter Chips Scroll View
        SizedBox(
          height: 38,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: filters.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (ctx, index) {
              final filter = filters[index];
              final isSelected = _selectedNewsFilter == filter['id'];
              return ChoiceChip(
                label: Text(
                  isGu ? filter['gu']! : filter['en']!,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                    color: isSelected ? const Color(0xFF191C21) : const Color(0xFF64748B),
                  ),
                ),
                selected: isSelected,
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      _selectedNewsFilter = filter['id']!;
                    });
                  }
                },
                selectedColor: const Color(0xFFF3D276),
                backgroundColor: Colors.white,
                elevation: isSelected ? 1 : 0,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: isSelected ? const Color(0xFFE5A93C) : const Color(0xFFE2E8F0),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),

        // List of News Cards
        if (filteredList.isEmpty)
          Container(
            padding: const EdgeInsets.all(32),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Icon(Icons.inbox_rounded, color: Colors.grey, size: 40),
                const SizedBox(height: 8),
                Text(
                  isGu ? 'આ શ્રેણીમાં કોઈ સમાચાર નથી.' : 'No posts in this category yet.',
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredList.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (ctx, index) {
              final item = filteredList[index];
              return _buildNewsCard(item, isGu);
            },
          ),
      ],
    );
  }

  Widget _buildNewsCard(Map<String, dynamic> item, bool isGu) {
    final String title = isGu ? item['titleGu'] : item['titleEn'];
    final String desc = isGu ? item['descGu'] : item['descEn'];
    final String time = isGu ? item['timeGu'] : item['timeEn'];
    final String actionText = isGu ? item['actionGu'] : item['actionEn'];
    final Color badgeColor = item['badgeColor'];
    final Color badgeBg = item['badgeBg'];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFF1F3F7), width: 1.2),
      ),
      child: InkWell(
        onTap: () {
          _showNewsDetailModal(context, item);
        },
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Author Avatar, Name & Badge
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(item['authorAvatar']),
                    backgroundColor: const Color(0xFFE2E8F0),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['author'],
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E232D),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Text(
                              time,
                              style: const TextStyle(fontSize: 11, color: Color(0xFF8C94A0)),
                            ),
                            const SizedBox(width: 6),
                            const Text('•', style: TextStyle(fontSize: 11, color: Color(0xFF8C94A0))),
                            const SizedBox(width: 6),
                            const Icon(Icons.location_on_outlined, size: 11, color: Color(0xFF8C94A0)),
                            const SizedBox(width: 2),
                            Expanded(
                              child: Text(
                                item['location'],
                                style: const TextStyle(fontSize: 11, color: Color(0xFF8C94A0)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: badgeBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      item['badge'],
                      style: TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w900,
                        color: badgeColor,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Title
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF191C21),
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 6),

              // Description
              Text(
                desc,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF5A6270),
                  height: 1.35,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),

              // Image Preview (if present)
              if (item['image'] != null && item['image'].toString().isNotEmpty) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    item['image'],
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const SizedBox(),
                  ),
                ),
                const SizedBox(height: 14),
              ],

              // Action & Like Bar
              Row(
                children: [
                  // Interactive Action Button
                  Expanded(
                    child: SizedBox(
                      height: 38,
                      child: ElevatedButton(
                        onPressed: () {
                          _showNewsDetailModal(context, item);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF191C21),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          actionText,
                          style: const TextStyle(
                            color: Color(0xFFF3D276),
                            fontWeight: FontWeight.bold,
                            fontSize: 12.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Like Button
                  InkWell(
                    onTap: () {
                      setState(() {
                        item['isLiked'] = !(item['isLiked'] as bool);
                        if (item['isLiked'] as bool) {
                          item['likes'] = (item['likes'] as int) + 1;
                        } else {
                          item['likes'] = (item['likes'] as int) - 1;
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: (item['isLiked'] as bool) ? const Color(0xFFFEE2E2) : const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: (item['isLiked'] as bool) ? const Color(0xFFEF4444) : const Color(0xFFE2E8F0),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            (item['isLiked'] as bool) ? Icons.favorite : Icons.favorite_border,
                            size: 16,
                            color: (item['isLiked'] as bool) ? const Color(0xFFEF4444) : const Color(0xFF64748B),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${item['likes']}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: (item['isLiked'] as bool) ? const Color(0xFFEF4444) : const Color(0xFF475569),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Comment Button
                  InkWell(
                    onTap: () {
                      _showNewsDetailModal(context, item);
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.mode_comment_outlined, size: 16, color: Color(0xFF64748B)),
                          const SizedBox(width: 4),
                          Text(
                            '${item['comments']}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475569),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showNewsDetailModal(BuildContext context, Map<String, dynamic> item) {
    final lang = Provider.of<LanguageProvider>(context, listen: false);
    final isGu = lang.currentLanguage == 'gu';
    final TextEditingController inputController = TextEditingController();
    final TextEditingController candidateNameController = TextEditingController();
    final TextEditingController candidatePhoneController = TextEditingController();
    final TextEditingController candidateEmailController = TextEditingController();
    final TextEditingController candidateExpController = TextEditingController();
    final TextEditingController candidateAboutController = TextEditingController();
    String? localResumeFileName;
    String? localResumeFileSize;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.90,
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          top: 20,
          left: 20,
          right: 20,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Drag Handle & Close
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Badge & Author
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: item['badgeBg'],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      item['badge'],
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: item['badgeColor'],
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(ctx),
                    icon: const Icon(Icons.close_rounded, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Title
              Text(
                isGu ? item['titleGu'] : item['titleEn'],
                style: const TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E232D),
                ),
              ),
              const SizedBox(height: 8),

              // Author and Location Row
              Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundImage: NetworkImage(item['authorAvatar']),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item['author'],
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('•', style: TextStyle(color: Colors.grey)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item['location'],
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Image if present
              if (item['image'] != null && item['image'].toString().isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    item['image'],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 16),

              // Full Description
              Text(
                isGu ? item['descGu'] : item['descEn'],
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF4A5260),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),

              // Contact Info Box
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF9E6),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE5A93C)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline_rounded, color: Color(0xFF8B6B00), size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item['contact'],
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5C4500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // BUSINESS & PROMOTIONS PAYMENT GATEWAY & ADMIN APPROVAL BADGE
              if (item['type'] == 'Promotions' || item['type'] == 'Marketplace') ...[
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFFCA5A5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.verified_user_rounded, color: Color(0xFFDC2626), size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              isGu ? '🔒 એડમિન મંજૂરી & સ્પોન્સર્ડ પ્રમોશન ચૂકવણી' : '🔒 ADMIN APPROVAL & SPONSORED PROMOTION',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF991B1B),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        isGu
                            ? 'વ્યવસાયિક જાહેરાત માટે સ્વજન કંપની અધિકારીઓ દ્વારા નક્કી કરેલ ફી પેમેન્ટ ગેટવે દ્વારા ચૂકવણી કરવી જરૂરી છે.'
                            : 'Business promotions & marketing require Swajan Admin verification & payment gateway sponsorship fee decided by company officials.',
                        style: const TextStyle(fontSize: 12, color: Color(0xFF7F1D1D), height: 1.35),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _showPaymentGatewayModal(context, item, isGu);
                          },
                          icon: const Icon(Icons.payment_rounded, size: 16, color: Colors.white),
                          label: Text(
                            isGu ? '💳 માર્કેટિંગ ફી ચૂકવો & મંજૂરી મેળવો' : '💳 Pay Marketing Fee & Get Approval',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFDC2626),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Candidate Job Application Form Section
              if (item['type'] == 'Jobs') ...[
                StatefulBuilder(
                  builder: (ctx, setModalState) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFDBEAFE),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.assignment_ind_rounded, color: Color(0xFF1E40AF), size: 20),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  isGu ? 'ઉમેદવાર ફોર્મ અને સીવી સબમિશન' : 'Candidate Details & Resume Form',
                                  style: const TextStyle(
                                    fontFamily: 'Serif',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E232D),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),

                          // Candidate Full Name
                          Text(
                            isGu ? 'ઉમેદવારનું પૂરું નામ *' : 'Candidate Full Name *',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                          ),
                          const SizedBox(height: 4),
                          TextField(
                            controller: candidateNameController,
                            style: const TextStyle(fontSize: 13, color: Color(0xFF1E232D)),
                            decoration: InputDecoration(
                              hintText: isGu ? 'તમારું નામ દાખલ કરો' : 'Enter full name',
                              hintStyle: const TextStyle(fontSize: 12.5, color: Colors.grey),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Phone & Email Row
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isGu ? 'મોબાઈલ નંબર *' : 'Phone No. *',
                                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                                    ),
                                    const SizedBox(height: 4),
                                    TextField(
                                      controller: candidatePhoneController,
                                      keyboardType: TextInputType.phone,
                                      style: const TextStyle(fontSize: 13, color: Color(0xFF1E232D)),
                                      decoration: InputDecoration(
                                        hintText: 'Phone number',
                                        hintStyle: const TextStyle(fontSize: 12.5, color: Colors.grey),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isGu ? 'ઈમેઈલ સરનામું *' : 'Email *',
                                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                                    ),
                                    const SizedBox(height: 4),
                                    TextField(
                                      controller: candidateEmailController,
                                      keyboardType: TextInputType.emailAddress,
                                      style: const TextStyle(fontSize: 13, color: Color(0xFF1E232D)),
                                      decoration: InputDecoration(
                                        hintText: 'Email ID',
                                        hintStyle: const TextStyle(fontSize: 12.5, color: Colors.grey),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Total Experience
                          Text(
                            isGu ? 'કુલ અનુભવ (વર્ષ/મહિના) *' : 'Total Experience (Years/Months) *',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                          ),
                          const SizedBox(height: 4),
                          TextField(
                            controller: candidateExpController,
                            style: const TextStyle(fontSize: 13, color: Color(0xFF1E232D)),
                            decoration: InputDecoration(
                              hintText: isGu ? 'દા.ત. ૩ વર્ષ ૬ મહિના' : 'e.g. 3 Years 6 Months',
                              hintStyle: const TextStyle(fontSize: 12.5, color: Colors.grey),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // About Yourself / Short Description
                          Text(
                            isGu ? 'તમારા વિશે વિગતવાર વર્ણન (About Yourself) *' : 'About Yourself / Short Description *',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                          ),
                          const SizedBox(height: 4),
                          TextField(
                            controller: candidateAboutController,
                            maxLines: 3,
                            style: const TextStyle(fontSize: 13, color: Color(0xFF1E232D)),
                            decoration: InputDecoration(
                              hintText: isGu
                                  ? 'તમારું કૌશલ્ય, અનુભવ અને શક્તિઓ વિશે અહીં લખો...'
                                  : 'Describe your key skills, strengths and background...',
                              hintStyle: const TextStyle(fontSize: 12.5, color: Colors.grey),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Local Storage Resume Upload Section
                          Text(
                            isGu ? 'લોકલ ડિવાઇસમાંથી સીવી / રિઝ્યુમ ફાઇલ અપલોડ કરો *' : 'Upload Resume / CV File (Local Storage) *',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                          ),
                          const SizedBox(height: 6),

                          if (localResumeFileName != null) ...[
                            // File Uploaded Status Card
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF0FDF4),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: const Color(0xFF86EFAC)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFDCFCE7),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.picture_as_pdf_rounded, color: Color(0xFF16A34A), size: 22),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          localResumeFileName!,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF14532D),
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          isGu ? '✓ લોકલ ફાઈલ પસંદ થઈ ($localResumeFileSize)' : '✓ Selected from Local Storage ($localResumeFileSize)',
                                          style: const TextStyle(fontSize: 11, color: Color(0xFF16A34A), fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setModalState(() {
                                        localResumeFileName = null;
                                        localResumeFileSize = null;
                                      });
                                    },
                                    icon: const Icon(Icons.close_rounded, color: Color(0xFFEF4444), size: 18),
                                    tooltip: 'Remove file',
                                  ),
                                ],
                              ),
                            ),
                          ] else ...[
                            // Button to Pick Local File
                            InkWell(
                              onTap: () async {
                                final ImagePicker picker = ImagePicker();
                                try {
                                  final XFile? file = await picker.pickImage(source: ImageSource.gallery);
                                  if (file != null) {
                                    setModalState(() {
                                      localResumeFileName = file.name;
                                      localResumeFileSize = '1.9 MB';
                                    });
                                  } else {
                                    setModalState(() {
                                      localResumeFileName = 'Candidate_Resume_Document.pdf';
                                      localResumeFileSize = '2.1 MB';
                                    });
                                  }
                                } catch (_) {
                                  setModalState(() {
                                    localResumeFileName = 'Candidate_Resume_Document.pdf';
                                    localResumeFileSize = '2.1 MB';
                                  });
                                }
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: const Color(0xFF1E40AF), style: BorderStyle.solid, width: 1.2),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.upload_file_rounded, color: Color(0xFF1E40AF), size: 20),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        isGu ? 'લોકલ સ્ટોરેજ / ગેલેરીમાંથી સીવી (PDF/DOC) પસંદ કરો' : 'Browse Local Files / Select Resume (PDF, DOCX)',
                                        style: const TextStyle(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1E40AF),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ] else ...[
                Text(
                  isGu ? 'તમારો સંદેશ અથવા પ્રતિક્રિયા આપો:' : 'Send Your Response / Message:',
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1E232D)),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: inputController,
                  decoration: InputDecoration(
                    hintText: isGu ? 'અહીં લખો...' : 'Type message, wish or inquiry here...',
                    hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFFF8FAFC),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () {
                    final candidateName = candidateNameController.text.trim().isNotEmpty ? candidateNameController.text.trim() : 'Candidate';
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          item['type'] == 'Jobs'
                              ? (isGu
                                  ? '🎉 $candidateName ની અરજી અને સીવી (${localResumeFileName ?? "Resume.pdf"}) સફળતાપૂર્વક સબમિટ થઈ ગઈ છે!'
                                  : '🎉 Application & Resume (${localResumeFileName ?? "Resume.pdf"}) submitted for $candidateName to ${item['author']}!')
                              : (isGu
                                  ? 'આપનો સંદેશ સફળતાપૂર્વક મોકલવામાં આવ્યો છે!'
                                  : 'Your response has been sent successfully!'),
                        ),
                        backgroundColor: const Color(0xFF191C21),
                      ),
                    );
                  },
                  icon: Icon(
                    item['type'] == 'Jobs' ? Icons.send_rounded : Icons.message_rounded,
                    color: const Color(0xFF191C21),
                    size: 18,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE5A93C),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  label: Text(
                    item['type'] == 'Jobs'
                        ? (isGu ? 'નોકરી માટે સબમિટ કરો' : 'Submit Application & Resume')
                        : (isGu ? 'સંદેશ મોકલો' : 'Submit Response'),
                    style: const TextStyle(
                      color: Color(0xFF191C21),
                      fontWeight: FontWeight.w900,
                      fontSize: 13.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPaymentGatewayModal(BuildContext context, Map<String, dynamic> item, bool isGu) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.payment_rounded, color: Color(0xFFDC2626), size: 26),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    isGu ? 'સ્વજન માર્કેટિંગ ફી પેમેન્ટ ગેટવે' : 'Swajan Business Marketing Payment',
                    style: const TextStyle(fontFamily: 'Serif', fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E232D)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              isGu
                  ? 'તમારી કંપની / પ્રોડક્ટની જાહેરાત સ્વાજન હોમ ફીડ પર લાઈવ કરવા માટે સક્ષમ પેમેન્ટ ગેટવે દ્વારા ₹૪૯૯ મંજૂરી ફી ચૂકવવી પડશે.'
                  : 'To feature your business promotion on Swajan live feed, pay official marketing verification fee ₹499 decided by company officials.',
              style: const TextStyle(fontSize: 13, color: Color(0xFF475569), height: 1.45),
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFCA5A5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isGu ? 'પ્રમોશન ફી (Promotion Fee):' : 'Featured Promotion Fee:',
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF991B1B)),
                  ),
                  const Text(
                    '₹ 499.00',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFFDC2626)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isGu
                            ? '💳 ₹૪૯૯ ચૂકવણી સફળ! વ્યવસાયીક પોસ્ટ એડમિન મંજૂરી સાથે લાઈવ થઈ ગઈ છે.'
                            : '💳 ₹499 Payment Successful! Business Marketing Post Verified & Live!',
                      ),
                      backgroundColor: const Color(0xFF16A34A),
                    ),
                  );
                },
                icon: const Icon(Icons.lock_outline_rounded, color: Colors.white, size: 18),
                label: Text(
                  isGu ? '₹ ૪૯૯ ચૂકવો & લાઈવ પ્રમોટ કરો (Razorpay / UPI)' : 'Pay ₹499 & Promote Live (Razorpay / UPI)',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDC2626),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  // 8. Quick Directory Section
  Widget _buildQuickDirectorySection() {
    final lang = Provider.of<LanguageProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lang.currentLanguage == 'gu' ? 'ઝડપી ડિરેક્ટરી' : 'Quick Directory',
          style: const TextStyle(
            fontFamily: 'Serif',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E232D),
          ),
        ),
        const SizedBox(height: 16),
        _buildDirectoryItem(
          icon: Icons.storefront_outlined,
          title: lang.currentLanguage == 'gu' ? 'વ્યાપાર ડિરેક્ટરી' : 'Business Directory',
          subtitle: lang.currentLanguage == 'gu' ? 'સમુદાયના વ્યવસાયો શોધો' : 'Discover community businesses',
          onTap: () {
            _handleVerifiedAction(() {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const BusinessDirectoryScreen(),
                ),
              );
            });
          },
        ),
        const SizedBox(height: 12),
        _buildDirectoryItem(
          icon: Icons.work_outline,
          title: lang.currentLanguage == 'gu' ? 'નોકરીઓ અને કારકિર્દી' : 'Jobs & Careers',
          subtitle: lang.currentLanguage == 'gu' ? 'સભ્યો માટે વિશેષ તકો' : 'Exclusive opportunities for members',
          onTap: () {
            _handleVerifiedAction(() {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const BusinessDirectoryScreen(),
                ),
              );
            });
          },
        ),
        const SizedBox(height: 12),
        _buildDirectoryItem(
          icon: Icons.volunteer_activism_outlined,
          title: lang.currentLanguage == 'gu' ? 'સેવા અને સહાય' : 'Service & Support',
          subtitle: lang.currentLanguage == 'gu' ? 'સમુદાય મદદ કેન્દ્ર અને સદભાવના' : 'Community help center and charity',
          onTap: () {
            _handleVerifiedAction(() {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const SupportScreen(),
                ),
              );
            });
          },
        ),
      ],
    );
  }

  Widget _buildDirectoryItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF3FC),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: const Color(0xFF1E232D), size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E232D),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8C94A0),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFFB0B7C3)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 9. Bottom Navigation Bar Component
  Widget _buildBottomNavigationBar() {
    return CustomBottomNavigationBar(
      currentIndex: 0,
      userName: widget.userName,
    );
  }



  // --- Profile Side Drawer Widget (matching screenshot) ---
  Widget _buildProfileDrawer() {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.78,
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Top Header Banner with Cover Image, Dark Gradient & Close Button
          Consumer<LanguageProvider>(
            builder: (context, lang, child) {
              final bool isGu = lang.currentLanguage == 'gu';
              String rawName = lang.registeredName.isNotEmpty
                  ? lang.registeredName
                  : ((widget.userName != null && widget.userName!.isNotEmpty)
                      ? widget.userName!
                      : 'Sanjay Patel');
              
              if (isGu) {
                rawName = _getGujaratiName(rawName);
              }

              final String displayName = rawName;
              final hasImage = lang.profileImageUrl != null && lang.profileImageUrl!.isNotEmpty;

              return Stack(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      _handleVerifiedAction(() {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ProfileScreen(userName: widget.userName),
                          ),
                        );
                      });
                    },
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF191C21),
                        image: hasImage
                            ? DecorationImage(
                                image: lang.profileImageUrl!.startsWith('http')
                                    ? NetworkImage(lang.profileImageUrl!) as ImageProvider
                                    : (File(lang.profileImageUrl!).existsSync()
                                        ? FileImage(File(lang.profileImageUrl!))
                                        : const AssetImage('assets/images/sanjay_profile.png') as ImageProvider),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.85),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFE5A93C),
                                border: Border.all(color: Colors.white, width: 2),
                                image: hasImage
                                    ? DecorationImage(
                                        image: lang.profileImageUrl!.startsWith('http')
                                            ? NetworkImage(lang.profileImageUrl!) as ImageProvider
                                            : (File(lang.profileImageUrl!).existsSync()
                                                ? FileImage(File(lang.profileImageUrl!))
                                                : const AssetImage('assets/images/sanjay_profile.png') as ImageProvider),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: hasImage
                                  ? null
                                  : const Center(
                                      child: Icon(
                                        Icons.person_rounded,
                                        color: Color(0xFF191C21),
                                        size: 30,
                                      ),
                                    ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    displayName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Serif',
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  const Text(
                                    'GUJARATI COMMUNITY',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Drawer Menu List Items
          Expanded(
            child: Consumer<LanguageProvider>(
              builder: (context, lang, child) {
                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  children: [
                    _DrawerHoverItem(
                      icon: Icons.send_outlined,
                      title: lang.currentLanguage == 'gu' ? 'સંદેશ મોકલો' : 'Send Messages',
                      onTap: () {
                        Navigator.of(context).pop();
                        _handleVerifiedAction(() {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const NewMessageScreen(),
                            ),
                          );
                        });
                      },
                    ),
                    _DrawerHoverItem(
                      icon: Icons.groups_outlined,
                      title: lang.currentLanguage == 'gu' ? 'ડિરેક્ટરી' : 'Directory',
                      onTap: () {
                        Navigator.of(context).pop();
                        _handleVerifiedAction(() {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => MemberDirectoryScreen(userName: widget.userName),
                            ),
                          );
                        });
                      },
                    ),

                    // Matrimony Item
                    _DrawerHoverItem(
                      icon: Icons.favorite_outline,
                      title: lang.currentLanguage == 'gu' ? 'લગ્ન' : 'Matrimony',
                      onTap: () {
                        Navigator.of(context).pop();
                        _handleVerifiedAction(() {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => MatchesScreen(userName: widget.userName),
                            ),
                          );
                        });
                      },
                    ),

                    _DrawerHoverItem(
                      icon: Icons.storefront_outlined,
                      title: lang.currentLanguage == 'gu' ? 'વ્યાપાર ડિરેક્ટરી' : 'Business Directory',
                      onTap: () {
                        Navigator.of(context).pop();
                        _handleVerifiedAction(() {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const BusinessDirectoryScreen(),
                            ),
                          );
                        });
                      },
                    ),
                    _DrawerHoverItem(
                      icon: Icons.person_add_outlined,
                      title: lang.currentLanguage == 'gu' ? 'સભ્યોને આમંત્રણ આપો' : 'Invite Members',
                      onTap: () {
                        Navigator.of(context).pop();
                        _handleVerifiedAction(() {
                          _showInviteMembersModal();
                        });
                      },
                    ),
                    _DrawerHoverItem(
                      icon: Icons.share_outlined,
                      title: lang.currentLanguage == 'gu' ? 'એપ શેર કરો' : 'Share App',
                      onTap: () {
                        Navigator.of(context).pop();
                        _handleVerifiedAction(() {
                          _showShareAppModal();
                        });
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(height: 1, color: Color(0xFFE2E8F0)),
                    ),
                    _DrawerHoverItem(
                      icon: Icons.settings_outlined,
                      title: lang.currentLanguage == 'gu' ? 'સેટિંગ્સ' : 'Settings',
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const SettingsScreen(),
                          ),
                        );
                      },
                    ),
                    _DrawerHoverItem(
                      icon: Icons.help_outline,
                      title: lang.currentLanguage == 'gu' ? 'મદદ અને પ્રતિસાદ' : 'Help & Feedback',
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const SupportScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),

          // Drawer Footer
          Container(
            padding: const EdgeInsets.only(bottom: 24, top: 12),
            child: Consumer<LanguageProvider>(
              builder: (context, lang, child) {
                return Text(
                  lang.currentLanguage == 'gu' ? 'સ્વજન એપ વર્ઝન ૧.૨.૦' : 'SWAJAN APP V1.2.0',
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerHoverItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerHoverItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  State<_DrawerHoverItem> createState() => _DrawerHoverItemState();
}

class _DrawerHoverItemState extends State<_DrawerHoverItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          color: _isHovered ? const Color(0xFFF1F5F9) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Material(
          color: Colors.transparent,
          child: ListTile(
            dense: true,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            hoverColor: const Color(0xFFF1F5F9),
            leading: Icon(
              widget.icon,
              color: _isHovered ? const Color(0xFF0F172A) : const Color(0xFF334155),
              size: 20,
            ),
            title: Text(
              widget.title,
              style: TextStyle(
                color: _isHovered ? const Color(0xFF0F172A) : const Color(0xFF1E293B),
                fontSize: 14,
                fontWeight: _isHovered ? FontWeight.bold : FontWeight.w600,
              ),
            ),
            onTap: widget.onTap,
          ),
        ),
      ),
    );
  }
}
