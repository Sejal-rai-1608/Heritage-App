import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'notifications_screen.dart';
import 'become_premium_screen.dart';
import '../widgets/custom_bottom_navbar.dart';

class MatchesScreen extends StatefulWidget {
  final String? userName;
  final bool isEmbedded;

  const MatchesScreen({super.key, this.userName, this.isEmbedded = false});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {

  String _getJoinedAgoLabel(String joinedAgo, bool isGu) {
    if (!isGu) return joinedAgo;
    if (joinedAgo.contains('2 hours')) return '૨ કલાક પહેલાં';
    if (joinedAgo.contains('5 hours')) return '૫ કલાક પહેલાં';
    if (joinedAgo.contains('1 day')) return '૧ દિવસ પહેલાં';
    if (joinedAgo.contains('2 days')) return '૨ દિવસ પહેલાં';
    return joinedAgo;
  }


  String _getProfileName(String name, bool isGu) {
    if (!isGu) return name;
    switch (name) {
      case 'Rajesh V. Patel':
        return 'રાજેશ વી. પટેલ';
      case 'Meera S. Shah':
        return 'મીરા એસ. શાહ';
      case 'Suresh K. Mehta':
        return 'સુરેશ કે. મહેતા';
      case 'Ananya R. Desai':
        return 'અનન્યા આર. દેસાઈ';
      case 'Harsh M. Trivedi':
        return 'હર્ષ એમ. ત્રિવેદી';
      case 'Karan B. Shah':
        return 'કરણ બી. શાહ';
      case 'Pooja N. Mehta':
        return 'પૂજા એન. મહેતા';
      case 'Kavya P. Joshi':
        return 'કાબ્યા પી. જોશી';
      case 'Aarav R. Shah':
        return 'આરવ આર. શાહ';
      case 'Devam M. Patel':
        return 'દેવમ એમ. પટેલ';
      default:
        return name;
    }
  }

  String _getAgeLabel(String age, bool isGu) {
    if (!isGu) return age;
    switch (age) {
      case '18 - 24':
        return '૧૮ - ૨૪';
      case '25 - 30':
        return '૨૫ - ૩૦';
      case '31 - 35':
        return '૩૧ - ૩૫';
      case '36 - 40':
        return '૩૬ - ૪૦';
      case '40+':
        return '૪૦+';
      default:
        return age;
    }
  }

  String _getGenderLabel(String gender, bool isGu) {
    if (!isGu) return gender;
    switch (gender) {
      case 'Groom':
        return 'વર';
      case 'Bride':
        return 'કન્યા';
      default:
        return gender;
    }
  }

  String _getEducationLabel(String? edu, bool isGu) {
    if (edu == null || edu.isEmpty) return isGu ? 'અનુસ્નાતક' : 'Post Graduate';
    if (!isGu) return edu;
    switch (edu) {
      case 'All Qualifications':
        return 'બધી લાયકાતો';
      case 'Post Graduate':
        return 'અનુસ્નાતક';
      case 'Graduate':
        return 'સ્નાતક';
      case 'Doctorate / Ph.D':
        return 'પીએચ.ડી';
      case 'Chartered Accountant':
        return 'સી.એ.';
      case 'Medical / Doctor':
        return 'ડોક્ટર';
      case 'Engineering / IT':
        return 'એન્જિનિયરિંગ / આઇટી';
      default:
        return edu;
    }
  }

  String _getSortLabel(String sort, bool isGu) {
    if (!isGu) return sort;
    switch (sort) {
      case 'Newest':
        return 'નવીનતમ';
      case 'Age: Low to High':
        return 'ઉંમર: ઓછી થી વધુ';
      case 'Age: High to Low':
        return 'ઉંમર: વધુ થી ઓછી';
      case 'Recently Active':
        return 'તાજેતરમાં સક્રિય';
      default:
        return sort;
    }
  }

  String _getProfessionLabel(String prof, bool isGu) {
    if (!isGu) return prof;
    switch (prof) {
      case 'Chartered Accountant':
        return 'ચાર્ટર્ડ એકાઉન્ટન્ટ';
      case 'Pediatrician (M.D.)':
        return 'બાળરોગ નિષ્ણાત (એમ.ડી.)';
      case 'Software Architect':
        return 'સોફ્ટવેર આર્કિટેક્ટ';
      case 'Senior UI/UX Designer':
        return 'સીનિયર UI/UX ડિઝાઇનર';
      case 'Financial Analyst':
        return 'ફાઇનાન્સિયલ એનાલિસ્ટ';
      case 'Software Engineer':
        return 'સોફ્ટવેર એન્જિનિયર';
      case 'Architectural Consultant':
        return 'આર્કિટેક્ચરલ કન્સલ્ટન્ટ';
      case 'Architect (B.Arch)':
        return 'આર્કિટેક્ટ (બી.આર્ક)';
      case 'Data Scientist at MNC':
        return 'ડેટા સાયન્ટિસ્ટ';
      case 'Clinical Psychologist':
        return 'ક્લિનિકલ સાયકોલોજિસ્ટ';
      case 'Textile Business Owner':
        return 'કાપડ વ્યવસાય માલિક';
      default:
        return prof;
    }
  }

  String _getCityLabel(String city, bool isGu) {
    if (!isGu) return city;
    switch (city) {
      case 'Ahmedabad, Gujarat':
        return 'અમદાવાદ, ગુજરાત';
      case 'Surat, Gujarat':
        return 'સુરત, ગુજરાત';
      case 'Vadodara, Gujarat':
        return 'વડોદરા, ગુજરાત';
      case 'Rajkot, Gujarat':
        return 'રાજકોટ, ગુજરાત';
      case 'Mumbai, Maharashtra':
        return 'મુંબઈ, મહારાષ્ટ્ર';
      default:
        return city;
    }
  }

  // Active top tab index
  int _selectedTabIndex = 0;
  final List<String> _tabs = [
    'Age Wise',
    'Premium Matches',
    'Personal Matches',
    'New Joined',
    'Verified Only',
  ];

  // New Joined Filters
  String _selectedNewJoinedFilter = 'All New';
  bool _newMemberAlertsEnabled = true;

  // Verified Only Filters
  String _selectedVerifiedFilter = 'All Verified';

  // Filter States
  String _selectedAgeRange = '25 - 30';
  String _selectedGender = 'Groom';
  String _selectedEducation = 'Post Graduate';
  String _selectedSort = 'Newest';

  // Sample Age options
  final List<String> _ageOptions = [
    '18 - 24',
    '25 - 30',
    '31 - 35',
    '36 - 40',
    '40+',
  ];

  // Sample Gender options
  final List<String> _genderOptions = ['Groom', 'Bride'];

  // Sample Education options
  final List<String> _educationOptions = [
    'All Qualifications',
    'Post Graduate',
    'Graduate',
    'Doctorate / Ph.D',
    'Chartered Accountant',
    'Medical / Doctor',
    'Engineering / IT',
  ];

  // Sorting options
  final List<String> _sortOptions = [
    'Newest',
    'Age: Low to High',
    'Age: High to Low',
    'Recently Active',
  ];

  // Favorites tracking
  final Set<String> _favoriteProfileIds = {};

  // Mock Profiles Data
  final List<Map<String, dynamic>> _allProfiles = [
    {
      'id': '1',
      'name': 'Rajesh V. Patel',
      'age': 32,
      'height': "5'11\"",
      'profession': 'Chartered Accountant',
      'city': 'Ahmedabad, Gujarat',
      'isVerified': true,
      'isStar': false,
      'gender': 'Groom',
      'education': 'Post Graduate',
      'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800',
    },
    {
      'id': '2',
      'name': 'Meera S. Shah',
      'age': 29,
      'height': "5'4\"",
      'profession': 'Pediatrician (M.D.)',
      'city': 'Surat, Gujarat',
      'isVerified': true,
      'isStar': true,
      'gender': 'Bride',
      'education': 'Doctorate / Ph.D',
      'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=800',
    },
    {
      'id': '3',
      'name': 'Suresh K. Mehta',
      'age': 35,
      'height': "5'9\"",
      'profession': 'Software Architect',
      'city': 'Vadodara, Gujarat',
      'isVerified': false,
      'isStar': false,
      'gender': 'Groom',
      'education': 'Post Graduate',
      'image': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=800',
    },
    {
      'id': '4',
      'name': 'Ananya R. Desai',
      'age': 26,
      'height': "5'3\"",
      'profession': 'Senior UI/UX Designer',
      'city': 'Rajkot, Gujarat',
      'isVerified': true,
      'isStar': true,
      'gender': 'Bride',
      'education': 'Graduate',
      'image': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=800',
    },
    {
      'id': '5',
      'name': 'Harsh M. Trivedi',
      'age': 31,
      'height': "6'0\"",
      'profession': 'Financial Analyst',
      'city': 'Mumbai, Maharashtra',
      'isVerified': true,
      'isStar': false,
      'gender': 'Groom',
      'education': 'Post Graduate',
      'image': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=800',
    },
    {
      'id': '6',
      'name': 'Karan B. Shah',
      'age': 28,
      'height': "5'10\"",
      'profession': 'Software Engineer',
      'city': 'Vadodara, Gujarat',
      'isVerified': true,
      'isStar': true,
      'gender': 'Groom',
      'education': 'Engineering / IT',
      'image': 'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=800',
    },
    {
      'id': '7',
      'name': 'Pooja N. Mehta',
      'age': 27,
      'height': "5'5\"",
      'profession': 'Architectural Consultant',
      'city': 'Ahmedabad, Gujarat',
      'isVerified': true,
      'isStar': false,
      'gender': 'Bride',
      'education': 'Post Graduate',
      'image': 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=800',
    },
  ];

  List<Map<String, dynamic>> get _filteredProfiles {
    return _allProfiles.where((p) {
      // Filter by tab
      if (_selectedTabIndex == 1 && !p['isStar']) return false;
      if (_selectedTabIndex == 4 && !p['isVerified']) return false;
      return true;
    }).toList();
  }

  void _showProfileDetailDialog(Map<String, dynamic> profile) {
    final lang = Provider.of<LanguageProvider>(context, listen: false);
    final bool isGu = lang.currentLanguage == 'gu';
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Handle bar
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Photo
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        profile['image'],
                        height: 280,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => Container(
                          height: 280,
                          color: Colors.grey[200],
                          child: const Icon(Icons.person, size: 80, color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _getProfileName(profile['name'], isGu),
                          style: const TextStyle(
                            fontFamily: 'Serif',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E232D),
                          ),
                        ),
                        if (profile['isVerified'])
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF34C759),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.check_circle, size: 14, color: Colors.white),
                                SizedBox(width: 4),
                                Text(
                                  'VERIFIED',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      isGu ? '${profile['age']} વર્ષ • ${profile['height']}' : '${profile['age']} Years • ${profile['height']}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Divider(height: 32),
                    _buildDetailRow(Icons.work_outline, isGu ? 'વ્યવસાય' : 'Profession', _getProfessionLabel(profile['profession'], isGu)),
                    const SizedBox(height: 12),
                    _buildDetailRow(Icons.location_on_outlined, isGu ? 'સ્થળ' : 'Location', _getCityLabel(profile['city'], isGu)),
                    const SizedBox(height: 12),
                    _buildDetailRow(Icons.school_outlined, isGu ? 'શિક્ષણ' : 'Education', _getEducationLabel(profile['education'], isGu)),
                    const SizedBox(height: 12),
                    _buildDetailRow(Icons.groups_outlined, isGu ? 'સમુદાય' : 'Community', isGu ? 'ગુજરાતી પટેલ' : 'Gujarati Patel'),
                    const SizedBox(height: 28),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isGu ? '${_getProfileName(profile['name'], isGu)} ને સંપર્ક વિનંતી મોકલી!' : 'Contact request sent to ${profile['name']}!'),
                            backgroundColor: const Color(0xFF0F172A),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F172A),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        isGu ? 'રસ દર્શાવો / સંપર્ક કરો' : 'Send Interest / Connect',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String val) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF0F172A)),
        const SizedBox(width: 12),
        Text(
          '$title: ',
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        Expanded(
          child: Text(val, style: TextStyle(color: Colors.grey[800])),
        ),
      ],
    );
  }

  void _showMoreFiltersSheet() {
    final lang = Provider.of<LanguageProvider>(context, listen: false);
    final bool isGu = lang.currentLanguage == 'gu';
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isGu ? 'વધુ ફિલ્ટર્સ' : 'More Filters',
                  style: TextStyle(
                    fontFamily: 'Serif',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E232D),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(isGu ? 'વૈવાહિક સ્થિતિ' : 'Marital Status', style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [isGu ? 'ક્યારેય પરણેલા નથી' : 'Never Married', isGu ? 'છૂટાછેડા થયેલ' : 'Divorced', isGu ? 'વિધુર / વિધવા' : 'Widowed']
                  .map((s) => Chip(
                        label: Text(s),
                        backgroundColor: const Color(0xFFEFF3FA),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            Text(isGu ? 'શહેર / જિલ્લો' : 'City / District', style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [isGu ? 'અમદાવાદ' : 'Ahmedabad', isGu ? 'સુરત' : 'Surat', isGu ? 'વડોદરા' : 'Vadodara', isGu ? 'રાજકોટ' : 'Rajkot', isGu ? 'મુંબઈ' : 'Mumbai']
                  .map((c) => Chip(
                        label: Text(c),
                        backgroundColor: const Color(0xFFEFF3FA),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F172A),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(isGu ? 'ફિલ્ટર્સ લાગુ કરો' : 'Apply Filters', style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final bool isGu = lang.currentLanguage == 'gu';
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),

      // Header App Bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        title: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300, width: 1),
                image: const DecorationImage(
                  image: AssetImage('assets/images/sanjay_profile.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              isGu ? 'સ્વજન એપ' : 'SWAJAN',
              style: TextStyle(
                fontFamily: 'Serif',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E232D),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const NotificationsScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.notifications_none_outlined,
              color: Color(0xFF2D3139),
              size: 24,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: Column(
        children: [
          // 1. Top Horizontal Slide Tabs Bar
          _buildHorizontalTabBar(),

          // 2. Main Content: Route to specific tab views
          Expanded(
            child: _selectedTabIndex == 1
                ? _buildPremiumMatchesView()
                : _selectedTabIndex == 2
                    ? _buildPersonalMatchesView()
                    : _selectedTabIndex == 3
                        ? _buildNewJoinedView()
                        : _selectedTabIndex == 4
                            ? _buildVerifiedOnlyView()
                            : SingleChildScrollView(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                        // Filter Section Card
                        _buildFilterCard(),
                        const SizedBox(height: 20),

                        // Results Info Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              isGu ? '${_filteredProfiles.length * 24 + 4} પ્રોફાઇલ્સ મળી' : 'Found ${_filteredProfiles.length * 24 + 4} Profiles',
                              style: const TextStyle(
                                fontFamily: 'Serif',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E232D),
                              ),
                            ),
                            PopupMenuButton<String>(
                              onSelected: (val) {
                                setState(() {
                                  _selectedSort = val;
                                });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    isGu ? 'ગોઠવો: ${_getSortLabel(_selectedSort, isGu)}' : 'Sort: $_selectedSort',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF5A6270),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 18,
                                    color: Color(0xFF5A6270),
                                  ),
                                ],
                              ),
                              itemBuilder: (context) => _sortOptions
                                  .map((s) => PopupMenuItem(value: s, child: Text(_getSortLabel(s, isGu))))
                                  .toList(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // List of Match Profiles
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _filteredProfiles.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 20),
                          itemBuilder: (context, index) {
                            return _buildProfileCard(_filteredProfiles[index]);
                          },
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // Horizontal Slide Tabs
  Widget _buildHorizontalTabBar() {
    final lang = Provider.of<LanguageProvider>(context);
    final bool isGu = lang.currentLanguage == 'gu';

    return Container(
      color: Colors.white,
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: List.generate(_tabs.length, (index) {
            final isSelected = _selectedTabIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? const Color(0xFFC5A059) : Colors.transparent,
                      width: 2.5,
                    ),
                  ),
                ),
                child: Text(
                  isGu ? (_tabs[index] == 'Age Wise' ? 'ઉંમર મુજબ' : _tabs[index] == 'Premium Matches' ? 'પ્રીમિયમ મેચ' : _tabs[index] == 'Personal Matches' ? 'વ્યક્તિગત મેચ' : _tabs[index] == 'New Joined' ? 'નવા જોડાયેલા' : 'માત્ર ચકાસાયેલ') : _tabs[index],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? const Color(0xFF1E232D) : const Color(0xFF7D8593),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // Premium Matches Content View
  Widget _buildPremiumMatchesView() {
    final lang = Provider.of<LanguageProvider>(context);
    final bool isGu = lang.currentLanguage == 'gu';
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Hero Card: Benefits Of Premium Matrimony
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFBF0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Heart Icon Container
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF0F2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Color(0xFFD32F2F),
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Title
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    isGu ? 'પ્રીમિયમ લગ્નના\nલાભો' : 'Benefits Of Premium\nMatrimony',
                    style: TextStyle(
                      fontFamily: 'Serif',
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E232D),
                      height: 1.25,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Subtitle Description
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    isGu ? 'વિવેકી સમુદાયના સભ્યો માટે રચાયેલ વિશિષ્ટ સુવિધાઓ સાથે તમારી શોધને શ્રેષ્ઠ બનાવો.' : 'Elevate your search with exclusive features designed for the discerning community member.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF5E6573),
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Become Premium Member Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BecomePremiumScreen(userName: widget.userName),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0C1017),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle_outline, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        isGu ? 'પ્રીમિયમ સભ્ય બનો' : 'Become Premium Member',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 36),

          // 2. Feature 1: Verified Community Profiles
          Center(
            child: Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: Color(0xFFFFF9E6),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.verified_outlined,
                color: Color(0xFF8B6B1B),
                size: 28,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Center(
            child: Text(
              isGu ? 'ચકાસાયેલ સમુદાય\nપ્રોફાઇલ્સ' : 'Verified Community\nProfiles',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Serif',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E232D),
                height: 1.25,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              isGu ? 'ચકાસાયેલ પૃષ્ઠભૂમિવાળા વિશ્વસનીય ગુજરાતી પરિવારોમાંથી પસંદ કરેલ પ્રોફાઇલ્સ ઍક્સેસ કરો. અમારી ટીમ સુરક્ષિત વાતાવરણ પ્રદાન કરવા માટે વ્યક્તિગત રીતે દરેક પ્રીમિયમ સભ્યની પ્રમાણિકતા સુનિશ્ચિત કરે છે.' : 'Access hand-picked profiles from trusted Gujarati families with verified backgrounds. Our team personally ensures the authenticity of every premium member to provide a secure environment.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF5E6573),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 36),

          // 3. Feature 2: Profile Views
          Center(
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F0FE),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.remove_red_eye_outlined,
                color: Color(0xFF8B6B1B),
                size: 26,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Center(
            child: Text(
              isGu ? 'પ્રોફાઇલ વ્યૂઝ' : 'Profile Views',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Serif',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E232D),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              isGu ? 'તમારી પ્રોફાઇલ કોણે જોઈ તે તુરંત જુઓ અને તેઓ રસ દર્શાવે તે પહેલાં રસ વ્યક્ત કરો. ક્યારેય સંભવિત કનેક્શન ચૂકી ન જાવ.' : 'See who visited your profile instantly and express interest before they do. Never miss a potential connection.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF5E6573),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 36),

          // 4. Feature 3: Direct Chat
          Center(
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F0FE),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.chat_bubble_outline_rounded,
                color: Color(0xFF8B6B1B),
                size: 26,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Center(
            child: Text(
              isGu ? 'સીધો ચેટ' : 'Direct Chat',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Serif',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E232D),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              isGu ? 'કોઈપણ મધ્યસ્થી વિના મેળ ખાતા પરિવારો સાથે સીધા જ જોડાઓ. સુરક્ષિત, એનક્રિપ્ટેડ અને વ્યક્તિગત મેસેજિંગ.' : 'Connect directly with matched families without any intermediaries. Secure, encrypted, and personal messaging.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF5E6573),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 36),

          // 5. Testimonial Card (Dark Navy)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            decoration: BoxDecoration(
              color: const Color(0xFF131B2E),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                // Quote Badge Container
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFC5A059), width: 1.5),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        right: 4,
                        bottom: 4,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Color(0xFFF0D597),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.format_quote_rounded,
                            size: 14,
                            color: Color(0xFF131B2E),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Quote Content
                Text(
                  isGu ? "'સ્વજન એપની પ્રીમિયમ સેવા દ્વારા મારા પુત્રનો જીવનસાથી મળ્યો. વ્યક્તિગત ધ્યાન અને મેચોની ગુણવત્તા ખરેખર અસાધારણ હતી. ખૂબ આગ્રહણીય.'" : "'Found my son's life partner through Swajan App's premium service. The personalized attention and quality of matches were truly exceptional. Highly recommended.'",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Serif',
                    fontSize: 16,
                    color: Colors.white,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 20),

                // Author Name
                Text(
                  isGu ? 'સંગીતા શાહ' : 'SANGEETA SHAH',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE5C17C),
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 4),

                // Author Subtitle
                Text(
                  isGu ? '૨૦૨૩ થી પ્રીમિયમ સભ્ય' : 'Premium Member since 2023',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF8A99AD),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 36),

          // 6. Support Contact Section
          Text(
            isGu ? 'સહાયતાની જરૂર છે? અમારા સમર્પિત રિલેશનશિપ મેનેજર મદદ માટે અહીં છે.' : 'Need assistance? Our dedicated relationship managers are here to help.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF5E6573),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),

          // Support Phone Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.phone_outlined,
                  color: Color(0xFF8B6B1B),
                  size: 24,
                ),
                const SizedBox(width: 14),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontFamily: 'Serif',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: isGu ? 'સપોર્ટ: ' : 'Support: ',
                        style: const TextStyle(color: Color(0xFF8B6B1B)),
                      ),
                      const TextSpan(
                        text: '+91 98234 56789',
                        style: TextStyle(color: Color(0xFF8B6B1B)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // Personal Matches Content View
  Widget _buildPersonalMatchesView() {
    final lang = Provider.of<LanguageProvider>(context);
    final bool isGu = lang.currentLanguage == 'gu';
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),

          // 1. Heading: Your Personal List
          Text(
            isGu ? 'તમારી વ્યક્તિગત યાદી' : 'Your Personal List',
            style: TextStyle(
              fontFamily: 'Serif',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E232D),
            ),
          ),
          const SizedBox(height: 20),

          // 2. Selected Members Row / Card
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/sanjay_profile.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey[300],
                        child: const Icon(Icons.person, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isGu ? 'તમે ૦ સભ્યો પસંદ કર્યા છે' : 'You have selected 0 members',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E232D),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Start adding members to your list',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF7D8593),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF9EA6B4),
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),

          // 3. Dashed Card: Build Your Connection
          DashedBorderContainer(
            color: const Color(0xFFD0D7E2),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: Column(
                children: [
                  // Gold Heart Icon
                  const Icon(
                    Icons.favorite_rounded,
                    color: Color(0xFFF3D276),
                    size: 64,
                  ),
                  const SizedBox(height: 20),

                  // Title: Build Your Connection
                  Text(
                    isGu ? 'તમારો સંપર્ક બનાવો' : 'Build Your Connection',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Serif',
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E232D),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Description Text with bold "Personal List"
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF5A6270),
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text: isGu ? 'સુસંગત મેચ શોધવા માટે ડિરેક્ટરીનું અન્વેષણ કરો. અમારા સમુદાયમાં તમને રસપ્રદ લાગતી પ્રોફાઇલ્સ ટ્રેક કરવા માટે ' : 'Explore the directory to find compatible matches. Use the ',
                        ),
                        TextSpan(
                          text: isGu ? '"વ્યક્તિગત યાદી"' : '"Personal List"',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E232D),
                          ),
                        ),
                        TextSpan(
                          text: isGu ? ' નો ઉપયોગ કરો.' : ' to track profiles you find interesting within our community.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Discover Members Button
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedTabIndex = 0; // Jump to Age Wise / All Matches
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFDE089),
                      foregroundColor: const Color(0xFF1E232D),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.search_rounded, size: 20, color: Color(0xFF1E232D)),
                        const SizedBox(width: 8),
                        Text(
                          isGu ? 'સભ્યો શોધો' : 'Discover Members',
                          style: const TextStyle(
                            color: Color(0xFF1E232D),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // New Joined Content View
  Widget _buildNewJoinedView() {
    final lang = Provider.of<LanguageProvider>(context);
    final bool isGu = lang.currentLanguage == 'gu';
    final List<Map<String, dynamic>> newProfiles = [
      {
        'id': 'nj1',
        'name': 'Kavya P. Joshi',
        'age': 25,
        'height': "5'4\"",
        'profession': 'Architect (B.Arch)',
        'education': 'Graduate',
        'city': 'Ahmedabad, Gujarat',
        'isVerified': true,
        'joinedAgo': '2 hours ago',
        'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=800',
      },
      {
        'id': 'nj2',
        'name': 'Aarav R. Shah',
        'age': 28,
        'height': "5'11\"",
        'profession': 'Data Scientist at MNC',
        'education': 'Post Graduate',
        'city': 'Surat, Gujarat',
        'isVerified': true,
        'joinedAgo': '5 hours ago',
        'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800',
      },
      {
        'id': 'nj3',
        'name': 'Pooja N. Mehta',
        'age': 27,
        'height': "5'5\"",
        'profession': 'Clinical Psychologist',
        'education': 'Doctorate / Ph.D',
        'city': 'Vadodara, Gujarat',
        'isVerified': true,
        'joinedAgo': '1 day ago',
        'image': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=800',
      },
      {
        'id': 'nj4',
        'name': 'Devam M. Patel',
        'age': 30,
        'height': "6'1\"",
        'profession': 'Textile Business Owner',
        'education': 'Graduate',
        'city': 'Rajkot, Gujarat',
        'isVerified': false,
        'joinedAgo': '2 days ago',
        'image': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=800',
      },
    ];

    final filterOptions = ['All New', 'Joined Today', 'This Week', 'This Month'];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4F46E5), Color(0xFF3730A3)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4F46E5).withValues(alpha: 0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.bolt, color: Color(0xFFFFD700), size: 16),
                          SizedBox(width: 4),
                          Text(
                            'FRESH PROFILES',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isGu ? '૧૪ આજે નવા' : '14 New Today',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  isGu ? 'તાજેતરમાં જોડાયેલ પ્રોફાઇલ્સ' : 'Recently Joined Profiles',
                  style: TextStyle(
                    fontFamily: 'Serif',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  isGu ? 'સ્વજન એપ પર તાજેતરમાં નોંધાયેલા નવા સભ્યો સાથે જોડાનારાઓમાં પ્રારંભિક બનો.' : 'Be among the first to connect with new members who recently registered on Swajan App.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFFE0E7FF),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Horizontal Sub-filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: filterOptions.map((opt) {
                final isSelected = _selectedNewJoinedFilter == opt;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(isGu ? (opt == 'All Verified' ? 'બધા ચકાસાયેલ' : opt == 'ID Verified' ? 'આઈડી ચકાસાયેલ' : opt == 'Family Verified' ? 'પરિવાર ચકાસાયેલ' : 'શિક્ષણ ચકાસાયેલ') : opt),
                    selected: isSelected,
                    onSelected: (val) {
                      setState(() => _selectedNewJoinedFilter = opt);
                    },
                    selectedColor: const Color(0xFF4F46E5),
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFF4B5563),
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      fontSize: 13,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected ? const Color(0xFF4F46E5) : const Color(0xFFE5E7EB),
                      ),
                    ),
                    showCheckmark: false,
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),

          // Profiles List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: newProfiles.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              return _buildNewProfileCard(newProfiles[index]);
            },
          ),
          const SizedBox(height: 24),

          // Alerts Box
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF2FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.notifications_active_outlined,
                    color: Color(0xFF4F46E5),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'New Member Instant Alerts',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xFF1E232D),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Get notified as soon as a matching profile joins.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _newMemberAlertsEnabled,
                  activeThumbColor: const Color(0xFF4F46E5),
                  onChanged: (val) {
                    setState(() => _newMemberAlertsEnabled = val);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // New Joiner Profile Card Widget
  Widget _buildNewProfileCard(Map<String, dynamic> profile) {
    final lang = Provider.of<LanguageProvider>(context);
    final bool isGu = lang.currentLanguage == 'gu';
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  profile['image'],
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(
                    height: 220,
                    color: Colors.grey[200],
                    child: const Icon(Icons.person, size: 60, color: Colors.grey),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4F46E5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.access_time_filled_rounded, size: 12, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        isGu ? _getJoinedAgoLabel(profile['joinedAgo'].toString(), isGu) : 'JOINED ${profile['joinedAgo'].toString().toUpperCase()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (profile['isVerified'])
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.verified, size: 12, color: Colors.white),
                        SizedBox(width: 3),
                        Text(
                          'VERIFIED',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _getProfileName(profile['name'], isGu),
                      style: const TextStyle(
                        fontFamily: 'Serif',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E232D),
                      ),
                    ),
                    Text(
                      isGu ? '${profile['age']} વર્ષ • ${profile['height']}' : '${profile['age']} Yrs • ${profile['height']}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4F46E5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.work_outline_rounded, size: 16, color: Color(0xFF6B7280)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        _getProfessionLabel(profile['profession'], isGu),
                        style: const TextStyle(fontSize: 13, color: Color(0xFF4B5563)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 16, color: Color(0xFF6B7280)),
                    const SizedBox(width: 6),
                    Text(
                      _getCityLabel(profile['city'], isGu),
                      style: const TextStyle(fontSize: 13, color: Color(0xFF4B5563)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _showProfileDetailDialog(profile),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: const BorderSide(color: Color(0xFF4F46E5)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          isGu ? 'પ્રોફાઇલ જુઓ' : isGu ? 'પ્રોફાઇલ જુઓ' : 'View Profile',
                          style: TextStyle(
                            color: Color(0xFF4F46E5),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(isGu ? '${_getProfileName(profile['name'], isGu)} માં રસ વ્યક્ત કર્યો!' : 'Expressed interest in ${profile['name']}!'),
                              backgroundColor: const Color(0xFF4F46E5),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4F46E5),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Express Interest',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Verified Only Content View
  Widget _buildVerifiedOnlyView() {
    final lang = Provider.of<LanguageProvider>(context);
    final bool isGu = lang.currentLanguage == 'gu';
    final List<Map<String, dynamic>> verifiedProfiles = _allProfiles
        .where((p) => p['isVerified'] == true)
        .toList();

    final filterOptions = ['All Verified', 'ID Verified', 'Family Verified', 'Education Verified'];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Trust Banner Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF059669), Color(0xFF047857)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF059669).withValues(alpha: 0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 6),
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
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.verified_user_rounded,
                        color: Color(0xFF059669),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '100% VERIFIED',
                          style: TextStyle(
                            color: Color(0xFFA7F3D0),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                        Text(
                          'Trusted Profiles',
                          style: TextStyle(
                            fontFamily: 'Serif',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  isGu ? 'અહીં સૂચિબદ્ધ દરેક પ્રોફાઇલ સરકારી આઈડી, શિક્ષણ અને પારિવારિક પૃષ્ઠભૂમિ સહિત અમારી સખત મલ્ટી-પોઇન્ટ ચકાસણીમાંથી પસાર થઈ છે.' : 'Every profile listed here has passed our rigorous multi-point verification including Govt ID, education, and family background.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFFD1FAE5),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildVerificationBadgeChip(isGu ? 'સરકારી ID ✓' : 'Govt ID ✓', isGu),
                    const SizedBox(width: 8),
                    _buildVerificationBadgeChip(isGu ? 'પરિવાર ચકાસાયેલ ✓' : 'Family Checked ✓', isGu),
                    const SizedBox(width: 8),
                    _buildVerificationBadgeChip(isGu ? 'ડિગ્રી ✓' : 'Degree ✓', isGu),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Sub-Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: filterOptions.map((opt) {
                final isSelected = _selectedVerifiedFilter == opt;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(isGu ? (opt == 'All Verified' ? 'બધા ચકાસાયેલ' : opt == 'ID Verified' ? 'આઈડી ચકાસાયેલ' : opt == 'Family Verified' ? 'પરિવાર ચકાસાયેલ' : 'શિક્ષણ ચકાસાયેલ') : opt),
                    selected: isSelected,
                    onSelected: (val) {
                      setState(() => _selectedVerifiedFilter = opt);
                    },
                    selectedColor: const Color(0xFF059669),
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFF4B5563),
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      fontSize: 13,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected ? const Color(0xFF059669) : const Color(0xFFE5E7EB),
                      ),
                    ),
                    showCheckmark: false,
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),

          // Profiles Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isGu ? '${verifiedProfiles.length} ચકાસાયેલ પ્રોફાઇલ્સ દર્શાવી રહ્યા છીએ' : 'Showing ${verifiedProfiles.length} Verified Profiles',
                style: const TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E232D),
                ),
              ),
              const Icon(Icons.shield_outlined, color: Color(0xFF059669), size: 20),
            ],
          ),
          const SizedBox(height: 16),

          // Profile Cards List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: verifiedProfiles.length,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              return _buildVerifiedProfileCard(verifiedProfiles[index]);
            },
          ),
          const SizedBox(height: 28),

          // Get Profile Verified Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFA7F3D0)),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.verified_sharp,
                  color: Color(0xFF059669),
                  size: 40,
                ),
                const SizedBox(height: 10),
                Text(
                  isGu ? 'તમારી પ્રોફાઇલ ૧૦૦% ચકાસાયેલ બનાવો' : 'Get Your Profile 100% Verified',
                  style: TextStyle(
                    fontFamily: 'Serif',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF065F46),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  isGu ? 'ચકાસાયેલ પ્રોફાઇલ્સને ૩ ગણો વધુ પ્રતિસાદ અને વાસ્તવિક પરિવારો તરફથી ત્વરિત વિશ્વાસ મળે છે.' : 'Verified profiles get 3x higher responses and instant trust from genuine families.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF047857),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Opening Verification Portal...'),
                        backgroundColor: Color(0xFF059669),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF059669),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    isGu ? 'આઈડી દસ્તાવેજો અપલોડ કરો' : 'Upload ID Documents',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildVerificationBadgeChip(String text, bool isGu) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Verified Profile Card Widget
  Widget _buildVerifiedProfileCard(Map<String, dynamic> profile) {
    final lang = Provider.of<LanguageProvider>(context);
    final bool isGu = lang.currentLanguage == 'gu';
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  profile['image'],
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(
                    height: 250,
                    color: Colors.grey[200],
                    child: const Icon(Icons.person, size: 60, color: Colors.grey),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF059669),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.check_circle_rounded, size: 14, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        '100% VERIFIED',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getProfileName(profile['name'], isGu),
                  style: const TextStyle(
                    fontFamily: 'Serif',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E232D),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isGu ? '${profile['age']} વર્ષ • ${profile['height']}' : '${profile['age']} Years • ${profile['height']}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF5A6270),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),

                // Trust verification checkmarks row
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    _buildVerifiedTag(isGu ? 'સરકારી આઈડી કન્ફર્મ' : 'Govt ID Confirmed'),
                    _buildVerifiedTag(isGu ? 'ડિગ્રી ચકાસાયેલ' : 'Degree Verified'),
                    _buildVerifiedTag(isGu ? 'કૌટુંબિક બેકગ્રાઉન્ડ ચકાસાયેલ' : 'Family Background Checked'),
                  ],
                ),
                const SizedBox(height: 16),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _showProfileDetailDialog(profile),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: const BorderSide(color: Color(0xFF059669)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          isGu ? 'વિગતો જુઓ' : 'View Details',
                          style: TextStyle(
                            color: Color(0xFF059669),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(isGu ? '${_getProfileName(profile['name'], isGu)} ને સંપર્ક વિનંતી મોકલી!' : 'Contact request sent to ${profile['name']}!'),
                              backgroundColor: const Color(0xFF059669),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF059669),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          isGu ? 'સંપર્ક વિનંતી' : 'Request Contact',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerifiedTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFECFDF5),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFA7F3D0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check, size: 12, color: Color(0xFF059669)),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF065F46),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Filter Card Component
  Widget _buildFilterCard() {
    final lang = Provider.of<LanguageProvider>(context);
    final bool isGu = lang.currentLanguage == 'gu';
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Age Range Dropdown
          _buildFilterDropdownLabel(isGu ? 'ઉંમરની શ્રેણી' : 'Age Range'),
          const SizedBox(height: 6),
          _buildCustomDropdown(
            value: _selectedAgeRange,
            items: _ageOptions,
            onChanged: (val) {
              if (val != null) setState(() => _selectedAgeRange = val);
            },
          ),
          const SizedBox(height: 14),

          // Looking for Dropdown
          _buildFilterDropdownLabel(isGu ? 'હું શોધી રહ્યો છું / રહી છું' : 'I am looking for'),
          const SizedBox(height: 6),
          _buildCustomDropdown(
            value: _selectedGender,
            items: _genderOptions,
            onChanged: (val) {
              if (val != null) setState(() => _selectedGender = val);
            },
          ),
          const SizedBox(height: 14),

          // Education Dropdown
          _buildFilterDropdownLabel(isGu ? 'શિક્ષણ' : 'Education'),
          const SizedBox(height: 6),
          _buildCustomDropdown(
            value: _selectedEducation,
            items: _educationOptions,
            onChanged: (val) {
              if (val != null) setState(() => _selectedEducation = val);
            },
          ),
          const SizedBox(height: 20),

          // Action Buttons Row (More Filters & Search)
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _showMoreFiltersSheet,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: Color(0xFF1E232D), width: 1.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.tune_outlined, size: 18, color: Color(0xFF1E232D)),
                      SizedBox(width: 8),
                      Text(isGu ? 'વધુ ફિલ્ટર્સ' : 'More Filters', style: const TextStyle(
                          color: Color(0xFF1E232D),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Search filters applied!'),
                        duration: Duration(seconds: 1),
                        backgroundColor: Color(0xFF0F172A),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F172A),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.search, size: 18, color: Colors.white),
                      SizedBox(width: 8),
                      Text(isGu ? 'શોધો' : 'Search', style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
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
    );
  }

  Widget _buildFilterDropdownLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Color(0xFF5A6270),
      ),
    );
  }

  Widget _buildCustomDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    final lang = Provider.of<LanguageProvider>(context);
    final bool isGu = lang.currentLanguage == 'gu';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF3FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(
            Icons.unfold_more_rounded,
            color: Color(0xFF4A5568),
            size: 20,
          ),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1E232D),
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(_ageOptions.contains(item) ? _getAgeLabel(item, isGu) : (_genderOptions.contains(item) ? _getGenderLabel(item, isGu) : (_educationOptions.contains(item) ? _getEducationLabel(item, isGu) : item))),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // Match Profile Card Component
  Widget _buildProfileCard(Map<String, dynamic> profile) {
    final lang = Provider.of<LanguageProvider>(context);
    final bool isGu = lang.currentLanguage == 'gu';
    final isFav = _favoriteProfileIds.contains(profile['id']);

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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Container with Badges
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(
                  profile['image'],
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(
                    height: 300,
                    color: Colors.grey[200],
                    child: const Icon(Icons.person, size: 80, color: Colors.grey),
                  ),
                ),
              ),

              // Verified Badge (Top-Left)
              if (profile['isVerified'])
                Positioned(
                  top: 14,
                  left: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF34C759),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.check_circle, size: 14, color: Colors.white),
                        SizedBox(width: 4),
                        Text(
                          'VERIFIED',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Favorite Heart Button (Top-Right)
              Positioned(
                top: 14,
                right: 14,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isFav) {
                        _favoriteProfileIds.remove(profile['id']);
                      } else {
                        _favoriteProfileIds.add(profile['id']);
                      }
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.25),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.redAccent : Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ),

              // Star Premium Badge (Bottom-Right of Image)
              if (profile['isStar'])
                Positioned(
                  bottom: 14,
                  right: 14,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF3D276),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.star_rounded,
                      color: Color(0xFF1E232D),
                      size: 22,
                    ),
                  ),
                ),
            ],
          ),

          // Profile Content Details
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getProfileName(profile['name'], isGu),
                  style: const TextStyle(
                    fontFamily: 'Serif',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E232D),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isGu ? '${profile['age']} વર્ષ • ${profile['height']}' : '${profile['age']} Years • ${profile['height']}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF5A6270),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),

                // Profession
                Row(
                  children: [
                    const Icon(
                      Icons.work_outline_rounded,
                      size: 18,
                      color: Color(0xFF5A6270),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _getProfessionLabel(profile['profession'], isGu),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF2D3139),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Location
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 18,
                      color: Color(0xFF5A6270),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _getCityLabel(profile['city'], isGu),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF2D3139),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // View Profile Button
                ElevatedButton(
                  onPressed: () => _showProfileDetailDialog(profile),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F172A),
                    minimumSize: const Size(double.infinity, 48),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    isGu ? 'પ્રોફાઇલ જુઓ' : isGu ? 'પ્રોફાઇલ જુઓ' : 'View Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
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

  // Footer Navigation Bar
  Widget _buildBottomNavigationBar() {
    return CustomBottomNavigationBar(
      currentIndex: 2,
      userName: widget.userName,
    );
  }


}

// Dashed Border Custom Container
class DashedBorderContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final double strokeWidth;
  final double gap;
  final double dash;

  const DashedBorderContainer({
    super.key,
    required this.child,
    this.color = const Color(0xFFD0D7E2),
    this.strokeWidth = 1.5,
    this.gap = 5.0,
    this.dash = 7.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedRectPainter(
        color: color,
        strokeWidth: strokeWidth,
        gap: gap,
        dash: dash,
      ),
      child: child,
    );
  }
}

class _DashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double dash;

  _DashedRectPainter({
    required this.color,
    required this.strokeWidth,
    required this.gap,
    required this.dash,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(20),
    );

    final Path path = Path()..addRRect(rrect);
    final Path dashPath = Path();

    for (final PathMetric metric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        dashPath.addPath(
          metric.extractPath(distance, distance + dash),
          Offset.zero,
        );
        distance += dash + gap;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant _DashedRectPainter oldDelegate) => false;
}

