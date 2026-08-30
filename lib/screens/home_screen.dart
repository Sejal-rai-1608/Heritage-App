import 'dart:io';
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
import 'notifications_screen.dart';
import 'family_tree_screen.dart';
import 'obituary_screen.dart';
import 'jobs_screen.dart';
import 'property_screen.dart';
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
  final int _selectedIndex = 0;
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
              'Share your exclusive community referral link to invite family & friends to Heritage App:',
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
                      'https://heritageapp.com/invite?ref=COMMUNITY2024',
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
              'Share Heritage App',
              style: TextStyle(fontFamily: 'Serif', fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Help expand our Gujarati community network! Share the Heritage App download link with your contacts:',
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
                      'https://heritageapp.com/download',
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

        // Center: Heritage App Title
        const Text(
          'Heritage App',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E232D),
          ),
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
                          icon: Icons.church_outlined,
                          label: lang.currentLanguage == 'gu' ? 'શ્રદ્ધાંજલિ' : 'Obituary',
                          onTap: () {
                            _handleVerifiedAction(() {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ObituaryScreen(userName: widget.userName),
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

  // 5. Community Stats Card
  Widget _buildCommunityStatsCard() {
    final lang = Provider.of<LanguageProvider>(context);
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
          Text(
            lang.currentLanguage == 'gu' ? 'સમુદાયના આંકડા અને પ્રગતિ' : 'Community Stats & Progress',
            style: TextStyle(
              fontFamily: 'Serif',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E232D),
            ),
          ),
          const SizedBox(height: 16),
          _buildStatRow(lang.currentLanguage == 'gu' ? 'સક્રિય સભ્યો' : 'Active Members', '2,500+'),
          const SizedBox(height: 10),
          _buildStatRow(lang.currentLanguage == 'gu' ? 'લગ્ન પ્રોફાઇલ્સ' : 'Matrimonial Profiles', '720+'),
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
    final lang = Provider.of<LanguageProvider>(context);
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
                children: [
                  Text(
                    lang.currentLanguage == 'gu' ? 'એંગેજમેન્ટ એનાલિટિક્સ' : 'ENGAGEMENT ANALYTICS',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF5A6270),
                      letterSpacing: 0.6,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    lang.currentLanguage == 'gu' ? 'સાપ્તાહિક ભાગીદારી વલણો' : 'WEEKLY PARTICIPATION TRENDS',
                    style: const TextStyle(
                      fontSize: 9,
                      color: Color(0xFF9AA2B0),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              Text(
                '+12%',
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
    final lang = Provider.of<LanguageProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                lang.currentLanguage == 'gu' ? 'સમુદાયના કારણો (દાન)' : 'Community Causes (Donation)',
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E232D),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () {
                _handleVerifiedAction(() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => DonationCausesScreen(userName: widget.userName),
                    ),
                  );
                });
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                lang.currentLanguage == 'gu' ? 'બધા જુઓ →' : 'See All →',
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
            _handleVerifiedAction(() {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => DonationCausesScreen(userName: widget.userName),
                ),
              );
            });
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
                        child: Text(
                          lang.currentLanguage == 'gu' ? '! અત્યંત જરૂરી' : '! URGENT',
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
                      Text(
                        lang.currentLanguage == 'gu' ? 'ગામડાની પ્રાથમિક શાળાનું નવીનીકરણ' : 'Renovation of Village Primary School',
                        style: TextStyle(
                          fontFamily: 'Serif',
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E232D),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        lang.currentLanguage == 'gu' ? 'સ્થાનિક શિક્ષણના પાયાને પુનર્જીવિત કરવું, ૨૦૦+ બાળકો માટે સુરક્ષિત વાતાવરણ.' : 'Revitalizing the foundation of our local education, safe environment for 200+ children.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF687385),
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              lang.currentLanguage == 'gu' ? '₹૪,૫૦,૦૦૦ એકત્રિત' : '₹4,50,000 Raised',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1E232D)),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              lang.currentLanguage == 'gu' ? 'લક્ષ્ય: ₹૧૦,૦૦,૦૦૦' : 'Target: ₹10,00,000',
                              style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
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
                            _handleVerifiedAction(() {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => DonationCausesScreen(userName: widget.userName),
                                ),
                              );
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFDE047),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23),
                            ),
                          ),
                          child: Text(
                            lang.currentLanguage == 'gu' ? 'હમણાં જ દાન કરો' : 'Donate Now',
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
                  lang.currentLanguage == 'gu' ? 'હેરિટેજ એપ વર્ઝન ૧.૨.૦' : 'HERITAGE APP V1.2.0',
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
