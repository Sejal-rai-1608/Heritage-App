import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
import '../widgets/custom_bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  final String? userName;

  const HomeScreen({super.key, this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageController _pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;
  bool _isCategoriesExpanded = true;

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
              Icon(Icons.assignment_ind_outlined, color: Color(0xFF00005C), size: 24),
              SizedBox(width: 10),
              Text(
                'Complete Registration',
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E232D),
                ),
              ),
            ],
          ),
          content: const Text(
            'Please complete your registration profile to access full features and community benefits.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF5A6270),
              height: 1.4,
            ),
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Later',
                style: TextStyle(
                  color: Colors.black87,
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
                backgroundColor: const Color(0xFF00005C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const Text(
                'Proceed',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
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
      key: _scaffoldKey,
      drawer: _buildProfileDrawer(),
      backgroundColor: bgLight,
      body: _buildHomeBody(),

      // --- Floating Action Button ---
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const NewMessageScreen(),
            ),
          );
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

  Widget _buildHomeBody() {
    final lang = Provider.of<LanguageProvider>(context);
    final bool isGu = lang.currentLanguage == 'gu';

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
              isGu
                  ? 'નમસ્તે, ${widget.userName != null && widget.userName!.isNotEmpty ? widget.userName : 'સોહમ'}!'
                  : 'Namaste, ${widget.userName != null && widget.userName!.isNotEmpty ? widget.userName : 'Soham'}!',
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
              isGu
                  ? 'કમ્યુનિટી હબમાં તમારું સ્વાગત છે'
                  : 'Welcome back to your community hub.',
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF757D8A),
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 24),

            // --- Action Cards (My Profile, Family Tree, Community Directory) ---
            _buildMainActionCard(
              icon: Icons.person,
              title: isGu ? 'મારું પ્રોફાઇલ' : 'MY PROFILE',
              subtitle: isGu ? 'તમારી પ્રોફાઇલ અને વિગતો મેનેજ કરો' : 'Manage your personal legacy',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProfileScreen(userName: widget.userName),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildMainActionCard(
              icon: Icons.account_tree,
              title: isGu ? 'ફેમિલી ટ્રી' : 'FAMILY TREE',
              subtitle: isGu ? 'તમારા વંશાવળી અને કુટુંબ વૃક્ષને જુઓ' : 'Explore your ancestral roots',
              onTap: _showCompleteRegistrationDialog,
            ),
            const SizedBox(height: 12),
            _buildMainActionCard(
              icon: Icons.groups,
              title: isGu ? 'સમુદાય ડિરેક્ટરી' : 'COMMUNITY DIRECTORY',
              subtitle: isGu ? 'સમુદાયના સ્થાનિક સભ્યો સાથે જોડાઓ' : 'Connect with local members',
              onTap: _showCompleteRegistrationDialog,
            ),
            const SizedBox(height: 24),

            // --- Explore Categories Dropdown Tile ---
            _buildCategoriesTile(),
            const SizedBox(height: 24),

            // --- Featured Event Card (Grand Mass Marriage 2024) ---
            _buildFeaturedEventCard(),
            const SizedBox(height: 24),

            // --- Community Stats ---
            _buildCommunityStatsCard(),
            const SizedBox(height: 20),

            // --- Engagement Analytics ---
            _buildEngagementAnalyticsCard(),
            const SizedBox(height: 28),

            // --- Donation Banner Section ---
            _buildDonationBannerSection(),
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
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/sanjay_profile.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Heritage App',
              style: TextStyle(
                fontFamily: 'Serif',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E232D),
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_none_outlined,
            color: Color(0xFF2D3139),
            size: 26,
          ),
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
                  const Expanded(
                    child: Text(
                      'Explore Categories',
                      style: TextStyle(
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
                          label: 'Jobs',
                          onTap: _showCompleteRegistrationDialog,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildCategoryGridItem(
                          icon: Icons.apartment_rounded,
                          label: 'Property',
                          onTap: _showCompleteRegistrationDialog,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildCategoryGridItem(
                          icon: Icons.favorite_border_rounded,
                          label: 'Matrimony',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => MatchesScreen(userName: widget.userName),
                              ),
                            );
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
                          icon: Icons.church_outlined,
                          label: 'Obituary',
                          onTap: _showCompleteRegistrationDialog,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildCategoryGridItem(
                          icon: Icons.celebration_outlined,
                          label: 'Events',
                          onTap: _showCompleteRegistrationDialog,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildCategoryGridItem(
                          icon: Icons.business_center_outlined,
                          label: 'Business',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const BusinessDirectoryScreen(),
                              ),
                            );
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
                  child: const Text(
                    'મુખ્ય ઇવેન્ટ',
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
                const Text(
                  'ભવ્ય સમૂહ લગ્ન ૨૦૨૪',
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
                  'દાયકાના સૌથી પ્રતિષ્ઠિત સામુદાયિક લગ્ન સમારોહમાં જોડાઓ. એકતા અને સંસ્કૃતિની ઉજવણી.',
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
                      '૧૫ ડિસેમ્બર, ૨૦૨૪',
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SamuhikVivaahScreen(userName: widget.userName),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentGold,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'વધુ જુઓ',
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

  // 5. Community Stats Card
  Widget _buildCommunityStatsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'સમુદાયના આંકડા અને પ્રગતિ',
            style: TextStyle(
              fontFamily: 'Serif',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E232D),
            ),
          ),
          const SizedBox(height: 16),
          _buildStatRow('સક્રિય સભ્યો', '૨,૫૦૦+'),
          const SizedBox(height: 10),
          _buildStatRow('લગ્ન વિષયક પ્રોફાઇલ', '૭૨૦+'),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: softBluePill,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF4A5260),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1E232D),
            ),
          ),
        ],
      ),
    );
  }

  // 6. Engagement Analytics Card
  Widget _buildEngagementAnalyticsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'સહભાગિતા વિશ્લેષણ',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF5A6270),
                      letterSpacing: 0.6,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'સાપ્તાહિક ભાગીદારી વલણો',
                    style: TextStyle(
                      fontSize: 9,
                      color: Color(0xFF9AA2B0),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              Text(
                '+૧૨%',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF8B6B00),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Simple Custom Bar Chart
          SizedBox(
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBar(0.4, isHighlighted: false),
                _buildBar(0.65, isHighlighted: false),
                _buildBar(0.95, isHighlighted: true),
                _buildBar(0.5, isHighlighted: false),
                _buildBar(0.75, isHighlighted: false),
                _buildBar(0.45, isHighlighted: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(double factor, {required bool isHighlighted}) {
    return Container(
      width: 24,
      height: 90 * factor,
      decoration: BoxDecoration(
        color: isHighlighted ? accentGold : const Color(0xFFD6E2F5),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  // 7. Donation Banner Section (Shape the Future of Our Legacy)
  Widget _buildDonationBannerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'સમુદાયના હેતુઓ (દાન)',
              style: TextStyle(
                fontFamily: 'Serif',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E232D),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DonationCausesScreen(userName: widget.userName),
                  ),
                );
              },
              child: const Text(
                'બધા જુઓ →',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF9C7611),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Hero Cause Card
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => DonationCausesScreen(userName: widget.userName),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=800&auto=format&fit=crop&q=80',
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 16,
                      top: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDC2626),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          '! તાત્કાલિક',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ગામડાની પ્રાથમિક શાળાનું નવીનીકરણ',
                        style: TextStyle(
                          fontFamily: 'Serif',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E232D),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'આપણા સ્થાનિક શિક્ષણના પાયાને પુનર્જીવિત કરી રહ્યા છીએ, ૨૦૦+ બાળકો માટે સુરક્ષિત વાતાવરણ.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF687385),
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('₹૪,૫૦,૦૦૦ એકત્રિત', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1E232D))),
                          Text('લક્ષ્ય: ₹૧૦,૦૦,૦૦૦', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: const LinearProgressIndicator(
                          value: 0.45,
                          minHeight: 6,
                          backgroundColor: Color(0xFFE2E8F0),
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFDE047)),
                        ),
                      ),
                      const SizedBox(height: 18),

                      SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => DonationCausesScreen(userName: widget.userName),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFDE047),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23),
                            ),
                          ),
                          child: const Text(
                            'હમણાં જ દાન કરો',
                            style: TextStyle(
                              color: Color(0xFF1E232D),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarDot(double left, Color color) {
    return Positioned(
      left: left,
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
      ),
    );
  }

  // 8. Quick Directory Section
  Widget _buildQuickDirectorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ઝડપી ડિરેક્ટરી',
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E232D),
          ),
        ),
        const SizedBox(height: 16),
        _buildDirectoryItem(
          icon: Icons.storefront_outlined,
          title: 'વ્યાપાર ડિરેક્ટરી',
          subtitle: 'સમુદાયના વ્યવસાયો શોધો',
          onTap: _showCompleteRegistrationDialog,
        ),
        const SizedBox(height: 12),
        _buildDirectoryItem(
          icon: Icons.work_outline,
          title: 'નોકરીઓ અને કારકિર્દી',
          subtitle: 'સભ્યો માટે ખાસ તકો',
          onTap: _showCompleteRegistrationDialog,
        ),
        const SizedBox(height: 12),
        _buildDirectoryItem(
          icon: Icons.volunteer_activism_outlined,
          title: 'સેવા અને સહાય',
          subtitle: 'સમુદાય મદદ કેન્દ્ર અને ચેરિટી',
          onTap: _showCompleteRegistrationDialog,
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
    final String displayName = (widget.userName != null && widget.userName!.isNotEmpty)
        ? widget.userName!
        : 'Sanjay Patel';

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.78,
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Top Header Banner with Cover Image, Dark Gradient & Close Button
          Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ProfileScreen(userName: widget.userName),
                    ),
                  );
                },
                child: Container(
                  height: 220,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/sanjay_profile.png'),
                      fit: BoxFit.cover,
                    ),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          displayName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
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
                ),
              ),
            ],
          ),

          // Drawer Menu List Items
          Expanded(
            child: Consumer<LanguageProvider>(
              builder: (context, lang, child) {
                final bool isGu = lang.currentLanguage == 'gu';
                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  children: [
                    _DrawerHoverItem(
                      icon: Icons.send_outlined,
                      title: isGu ? 'સંદેશા મોકલો' : 'Send Messages',
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const NewMessageScreen(),
                          ),
                        );
                      },
                    ),
                    _DrawerHoverItem(
                      icon: Icons.groups_outlined,
                      title: isGu ? 'સભ્ય ડિરેક્ટરી' : 'Directory',
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => MemberDirectoryScreen(userName: widget.userName),
                          ),
                        );
                      },
                    ),

                    // Matrimony Item
                    _DrawerHoverItem(
                      icon: Icons.favorite_outline,
                      title: isGu ? 'લગ્ન વિષયક' : 'Matrimony',
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => MatchesScreen(userName: widget.userName),
                          ),
                        );
                      },
                    ),

                    _DrawerHoverItem(
                      icon: Icons.storefront_outlined,
                      title: isGu ? 'વ્યાપાર ડિરેક્ટરી' : 'Business Directory',
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const BusinessDirectoryScreen(),
                          ),
                        );
                      },
                    ),
                    _DrawerHoverItem(
                      icon: Icons.person_add_outlined,
                      title: isGu ? 'સભ્યોને આમંત્રિત કરો' : 'Invite Members',
                      onTap: () {
                        Navigator.of(context).pop();
                        _showCompleteRegistrationDialog();
                      },
                    ),
                    _DrawerHoverItem(
                      icon: Icons.share_outlined,
                      title: isGu ? 'એપ્લિકેશન શેર કરો' : 'Share App',
                      onTap: () {
                        Navigator.of(context).pop();
                        _showCompleteRegistrationDialog();
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(height: 1, color: Color(0xFFE2E8F0)),
                    ),
                    _DrawerHoverItem(
                      icon: Icons.settings_outlined,
                      title: isGu ? 'સેટિંગ્સ' : 'Settings',
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
                      title: isGu ? 'મદદ અને પ્રતિસાદ' : 'Help & Feedback',
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
            child: const Text(
              'HERITAGE LUXE V1.2.0',
              style: TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
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
