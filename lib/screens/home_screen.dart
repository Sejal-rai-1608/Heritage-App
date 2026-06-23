import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'detailed_registration_screen.dart';
import 'membership_request_screen.dart';
import 'login_screen.dart';
import 'settings_screen.dart';
import 'support_screen.dart';
import 'new_message_screen.dart';
import 'community_directory_screen.dart';
import 'invite_members_screen.dart';
import 'business_directory_screen.dart';
import 'matrimony_screen.dart';
import 'donation_screen.dart';
import 'samuhik_vivah_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  static const Color primaryNavy = Color(0xFF00005C);
  static const Color accentGold = Color(0xFFE67E22);
  int _currentNavIndex = 0;
  String _selectedDrawerItem = '';
  String _profileSubTab = 'My Profile';

  // Dynamic Tab Controller state
  List<String> _currentTabTypes = [];
  TabController? _tabController;
  TabController? _matrimonyTabController;

  final List<String> _allMessageTypes = [
    'Job',
    'Property',
    'Commercial',
    'Death',
    'New Born',
    'New Marriage',
    'Engagement',
    'Social',
    'Regional',
    'Buy-Sell',
    'Congratulation',
    'Thank you',
    'Condolence',
    'Birthday',
    'Marriage Anniversary',
    'Punya Tithi',
    'Academic',
    'Medical',
    'General',
    'Donation',
    'Samuhik Vivah',
  ];

  @override
  void initState() {
    super.initState();
    _matrimonyTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _matrimonyTabController?.dispose();
    super.dispose();
  }

  List<String> _getTabTypes(LanguageProvider lang) {
    List<String> types = ['Home'];

    // Find all categories that have approved user posts
    List<String> approvedUserCategories = [];
    for (var post in lang.posts) {
      final isCurrentUserPost = post['userName'] == lang.registeredName;
      if (post['isApproved'] == true && isCurrentUserPost) {
        final String type = post['type'];
        if (!approvedUserCategories.contains(type)) {
          approvedUserCategories.add(type);
        }
      }
    }

    // Add approved categories right after Home
    types.addAll(approvedUserCategories);

    // Add the rest of the 21 categories
    for (var cat in _allMessageTypes) {
      if (!types.contains(cat)) {
        types.add(cat);
      }
    }

    return types;
  }

  void _updateTabController(List<String> newTypes) {
    final oldIndex = _tabController?.index ?? 0;
    _tabController?.dispose();
    _currentTabTypes = List.from(newTypes);

    int newIndex = oldIndex;
    if (newIndex >= _currentTabTypes.length) {
      newIndex = _currentTabTypes.length - 1;
    }
    if (newIndex < 0) newIndex = 0;

    _tabController = TabController(
      length: _currentTabTypes.length,
      vsync: this,
      initialIndex: newIndex,
    );
  }

  bool _isListEqual(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  void _launchWhatsApp(String phone) {
    if (phone.isEmpty) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Simulating WhatsApp Chat to +91 $phone...'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Map<String, dynamic> _getCategoryStyle(String type) {
    switch (type) {
      case 'Job':
        return {'icon': Icons.work_outline, 'color': Colors.orange};
      case 'Property':
        return {'icon': Icons.apartment, 'color': Colors.blue};
      case 'Commercial':
        return {'icon': Icons.business_center, 'color': Colors.teal};
      case 'Death':
        return {
          'icon': Icons.brightness_3_outlined,
          'color': Colors.grey.shade800,
        };
      case 'New Born':
        return {
          'icon': Icons.child_care_outlined,
          'color': Colors.pink.shade300,
        };
      case 'New Marriage':
        return {'icon': Icons.favorite_border, 'color': Colors.red};
      case 'Engagement':
        return {'icon': Icons.brightness_low_outlined, 'color': Colors.purple};
      case 'Social':
        return {'icon': Icons.people_outline, 'color': Colors.indigo};
      case 'Regional':
        return {'icon': Icons.map_outlined, 'color': Colors.brown};
      case 'Buy-Sell':
        return {'icon': Icons.shopping_cart_outlined, 'color': Colors.green};
      case 'Congratulation':
        return {'icon': Icons.thumb_up_alt_outlined, 'color': Colors.teal};
      case 'Thank you':
        return {
          'icon': Icons.card_giftcard_outlined,
          'color': Colors.blueAccent,
        };
      case 'Condolence':
        return {
          'icon': Icons.sentiment_very_dissatisfied_outlined,
          'color': Colors.grey.shade600,
        };
      case 'Birthday':
        return {'icon': Icons.cake_outlined, 'color': Colors.pink};
      case 'Marriage Anniversary':
        return {'icon': Icons.celebration_outlined, 'color': Colors.redAccent};
      case 'Punya Tithi':
        return {
          'icon': Icons.self_improvement_outlined,
          'color': Colors.blueGrey,
        };
      case 'Academic':
        return {'icon': Icons.school_outlined, 'color': Colors.lightBlue};
      case 'Medical':
        return {
          'icon': Icons.local_hospital_outlined,
          'color': Colors.red.shade700,
        };
      case 'General':
        return {'icon': Icons.message_outlined, 'color': Colors.blue};
      case 'Donation':
        return {
          'icon': Icons.volunteer_activism_outlined,
          'color': Colors.green.shade600,
        };
      case 'Samuhik Vivah':
        return {'icon': Icons.groups_outlined, 'color': Colors.pink};
      default:
        return {'icon': Icons.message_outlined, 'color': Colors.blue};
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);

    // Initialize/recreate TabController dynamically based on active categories
    final newTypes = _getTabTypes(lang);
    if (_tabController == null ||
        _currentTabTypes.length != newTypes.length ||
        !_isListEqual(_currentTabTypes, newTypes)) {
      _updateTabController(newTypes);
    }

    if (_matrimonyTabController == null) {
      _matrimonyTabController = TabController(length: 3, vsync: this);
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: primaryNavy),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Text(
          lang.getText('heritage_core'),
          style: const TextStyle(
            color: primaryNavy,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
        centerTitle: _currentNavIndex != 1,
        actions: [
          if (_currentNavIndex == 0 || _currentNavIndex == 2)
            IconButton(
              icon: const Icon(Icons.search, color: primaryNavy),
              onPressed: () {},
            ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: primaryNavy.withValues(alpha: 0.1),
              backgroundImage:
                  lang.profileImageUrl != null &&
                      lang.profileImageUrl!.isNotEmpty
                  ? (lang.profileImageUrl!.startsWith('http')
                        ? NetworkImage(lang.profileImageUrl!) as ImageProvider
                        : FileImage(File(lang.profileImageUrl!))
                              as ImageProvider)
                  : null,
              child:
                  lang.profileImageUrl != null &&
                      lang.profileImageUrl!.isNotEmpty
                  ? null
                  : const Icon(Icons.person, color: primaryNavy, size: 20),
            ),
          ),
        ],
        bottom: _currentNavIndex == 1
            ? TabBar(
                controller: _matrimonyTabController,
                isScrollable: false,
                labelColor: primaryNavy,
                unselectedLabelColor: Colors.grey,
                indicatorColor: primaryNavy,
                indicatorWeight: 3,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
                tabs: const [
                  Tab(text: 'AGE WISE'),
                  Tab(text: 'PREMIUM'),
                  Tab(text: 'PERSONAL'),
                ],
              )
            : (_currentNavIndex == 0
                ? TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: primaryNavy,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: primaryNavy,
                    indicatorWeight: 3,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                    tabs: _currentTabTypes
                        .map((type) => Tab(text: type.toUpperCase()))
                        .toList(),
                  )
                : null),
      ),
      body: _currentNavIndex == 1
          ? MatrimonyScreen(tabController: _matrimonyTabController!)
          : (_currentNavIndex == 2
              ? _buildProfileTab(lang)
              : TabBarView(
                  controller: _tabController,
                  children: _currentTabTypes.map((type) {
                    if (type == 'Home') {
                      return _buildHomeTab(lang);
                    } else {
                      return _buildCategoryTab(type, lang);
                    }
                  }).toList(),
                )),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentNavIndex,
          onTap: (index) {
            if (index == 3) {
              // Edit button takes approved users to New Message posting form
              _checkRegistrationAndNavigate(
                context,
                lang,
                const NewMessageScreen(),
              );
            } else {
              setState(() {
                _currentNavIndex = index;
              });
            }
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: primaryNavy,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label: lang.getText('home'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.favorite_outline),
              activeIcon: const Icon(Icons.favorite),
              label: lang.getText('matrimony'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline),
              activeIcon: const Icon(Icons.person),
              label: lang.getText('profile'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.edit_outlined),
              activeIcon: const Icon(Icons.edit),
              label: lang.getText('edit'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryNavy,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
        ),
        child: Column(
          children: [
            _buildDrawerHeader(lang),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItem(
                    icon: Icons.send,
                    title: lang.getText('send_messages'),
                    isSelected: _selectedDrawerItem == 'send_messages',
                    onTap: () {
                      setState(() {
                        _selectedDrawerItem = 'send_messages';
                      });
                      Navigator.pop(context);
                      _checkRegistrationAndNavigate(
                        context,
                        lang,
                        const NewMessageScreen(),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.people_outline,
                    title: lang.getText('directory'),
                    isSelected: _selectedDrawerItem == 'directory',
                    onTap: () {
                      setState(() {
                        _selectedDrawerItem = 'directory';
                      });
                      Navigator.pop(context);
                      _checkRegistrationAndNavigate(
                        context,
                        lang,
                        const CommunityDirectoryScreen(),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.favorite_border,
                    title: lang.getText('matrimony'),
                    isSelected: _selectedDrawerItem == 'matrimony' || _currentNavIndex == 1,
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        _selectedDrawerItem = 'matrimony';
                        _currentNavIndex = 1;
                      });
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.storefront,
                    title: lang.getText('business_directory'),
                    isSelected: _selectedDrawerItem == 'business_directory',
                    onTap: () {
                      setState(() {
                        _selectedDrawerItem = 'business_directory';
                      });
                      Navigator.pop(context);
                      _checkRegistrationAndNavigate(
                        context,
                        lang,
                        const BusinessDirectoryScreen(),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.person_add_outlined,
                    title: lang.getText('invite_members'),
                    isSelected: _selectedDrawerItem == 'invite_members',
                    onTap: () {
                      setState(() {
                        _selectedDrawerItem = 'invite_members';
                      });
                      Navigator.pop(context);
                      _checkRegistrationAndNavigate(
                        context,
                        lang,
                        const InviteMembersScreen(),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.share_outlined,
                    title: lang.getText('share_app'),
                    isSelected: _selectedDrawerItem == 'share_app',
                    onTap: () {
                      setState(() {
                        _selectedDrawerItem = 'share_app';
                      });
                      Navigator.pop(context);
                      _checkRegistrationAndNavigate(context, lang, null);
                    },
                  ),
                  const Divider(
                    height: 32,
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                  _buildDrawerItem(
                    icon: Icons.settings_outlined,
                    title: lang.getText('settings'),
                    isSelected: _selectedDrawerItem == 'settings',
                    onTap: () {
                      setState(() {
                        _selectedDrawerItem = 'settings';
                      });
                      Navigator.pop(context);
                      _checkRegistrationAndNavigate(
                        context,
                        lang,
                        const SettingsScreen(),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.help_outline,
                    title: lang.getText('help_feedback'),
                    isSelected: _selectedDrawerItem == 'help_feedback',
                    onTap: () {
                      setState(() {
                        _selectedDrawerItem = 'help_feedback';
                      });
                      Navigator.pop(context);
                      _checkRegistrationAndNavigate(
                        context,
                        lang,
                        const SupportScreen(),
                      );
                    },
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'HERITAGE CORE V1.2.0',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- NAVIGATION HELPER ---
  void _navigateToTab(String type) {
    final index = _currentTabTypes.indexOf(type);
    if (index != -1 && _tabController != null) {
      _tabController!.animateTo(index);
    }
  }

  // --- HOME TAB ---
  Widget _buildHomeTab(LanguageProvider lang) {
    final bool isApproved = lang.isProfileApproved;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Explore Categories Header
          Text(
            lang.getText('explore_categories'),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: primaryNavy,
            ),
          ),
          const SizedBox(height: 16),

          // Category Grid
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.0,
            children: [
              _buildCategoryCard(
                Icons.work_outline,
                lang.getText('jobs'),
                primaryNavy,
                () => _navigateToTab('Job'),
              ),
              _buildCategoryCard(
                Icons.apartment,
                lang.getText('property'),
                primaryNavy,
                () => _navigateToTab('Property'),
              ),
              _buildCategoryCard(
                Icons.favorite_outline,
                lang.getText('matrimony'),
                Colors.pink,
                () {
                  setState(() {
                    _currentNavIndex = 1;
                  });
                },
              ),
              _buildCategoryCard(
                Icons.local_florist,
                lang.getText('obituary'),
                Colors.grey.shade700,
                () => _navigateToTab('Death'),
              ),
              _buildCategoryCard(
                Icons.event,
                lang.getText('events'),
                accentGold,
                () => _navigateToTab('Social'),
              ),
              _buildCategoryCard(
                Icons.business_center,
                lang.getText('business'),
                Colors.teal,
                () => _navigateToTab('Commercial'),
              ),
              _buildCategoryCard(
                Icons.volunteer_activism_outlined,
                lang.getText('donation'),
                Colors.green.shade600,
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const DonationScreen(),
                    ),
                  );
                },
              ),
              _buildCategoryCard(
                Icons.groups_outlined,
                lang.getText('samuhik_vivah'),
                Colors.pink,
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SamuhikVivahScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 28),

          // Community Feed Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                lang.getText('community_feed'),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: primaryNavy,
                ),
              ),
              Text(
                lang.getText('view_all'),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: primaryNavy.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (!isApproved) ...[
            // Welcome Card (shown before full registration)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: primaryNavy.withValues(alpha: 0.06),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.waving_hand,
                      color: accentGold,
                      size: 36,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    lang.getText('welcome_heritage'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: primaryNavy,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => lang.isProfileCompleted
                                ? const MembershipRequestScreen()
                                : const DetailedRegistrationScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryNavy,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        lang.isProfileCompleted
                            ? lang.getText('view_registration_status')
                            : lang.getText('complete_registration'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            // Welcome Approved Banner
            _buildWelcomeApprovedBanner(lang),
            // Simulator approval card for pending messages
            _buildPendingApprovalSimulationCard(lang),
            // Feed list for approved posts
            _buildFeedPostsList(lang),
          ],
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // Welcome Approved Banner
  Widget _buildWelcomeApprovedBanner(LanguageProvider lang) {
    final String name = lang.registeredName.isNotEmpty
        ? lang.registeredName
        : 'Sanjay Patel';
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [primaryNavy, Color(0xFF1E3A8A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: primaryNavy.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome,',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Glad to have you with us in the Gujarati Heritage Core community.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12.5,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white24, width: 2),
            ),
            child: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white.withValues(alpha: 0.1),
              backgroundImage:
                  lang.profileImageUrl != null &&
                      lang.profileImageUrl!.isNotEmpty
                  ? (lang.profileImageUrl!.startsWith('http')
                        ? NetworkImage(lang.profileImageUrl!) as ImageProvider
                        : FileImage(File(lang.profileImageUrl!))
                              as ImageProvider)
                  : const AssetImage('assets/images/sanjay_profile.png')
                        as ImageProvider,
              child: const Align(
                alignment: Alignment.center,
                child: SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Pending Approval Simulator Card
  Widget _buildPendingApprovalSimulationCard(LanguageProvider lang) {
    final pendingPosts = lang.posts
        .where((post) => post['isApproved'] == false)
        .toList();
    if (pendingPosts.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        children: [
          Icon(
            Icons.admin_panel_settings,
            color: Colors.blue.shade800,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Admin Simulator',
                  style: TextStyle(
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'You have ${pendingPosts.length} pending post(s) awaiting approval.',
                  style: TextStyle(color: Colors.blue.shade800, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              lang.approveAllPendingPosts();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All pending posts approved successfully!'),
                  backgroundColor: Colors.blue,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade800,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Approve',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // Feed Posts List
  Widget _buildFeedPostsList(LanguageProvider lang) {
    final approvedPosts = lang.posts
        .where((post) => post['isApproved'] == true)
        .toList();
    if (approvedPosts.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.feed_outlined,
                size: 48,
                color: Colors.grey.withValues(alpha: 0.4),
              ),
              const SizedBox(height: 12),
              const Text(
                'No announcements in feed yet',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: approvedPosts.length,
      itemBuilder: (context, index) {
        final post = approvedPosts[index];
        return _buildPostCard(post, lang);
      },
    );
  }

  // Category Card Builder
  Widget _buildCategoryCard(
    IconData icon,
    String label,
    Color iconColor,
    VoidCallback onTap,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 26),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Category Specific Tab View Builder
  Widget _buildCategoryTab(String type, LanguageProvider lang) {
    final categoryStyle = _getCategoryStyle(type);
    final Color categoryColor = categoryStyle['color'] ?? primaryNavy;
    final IconData categoryIcon =
        categoryStyle['icon'] ?? Icons.message_outlined;

    final categoryPosts = lang.posts
        .where((post) => post['type'] == type && post['isApproved'] == true)
        .toList();

    return Column(
      children: [
        // Posting Card
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: InkWell(
            onTap: () {
              _checkRegistrationAndNavigate(
                context,
                lang,
                NewMessageScreen(initialType: type),
              );
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: categoryColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(categoryIcon, color: categoryColor, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Post $type Message in HA',
                          style: const TextStyle(
                            color: primaryNavy,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Tap to create a new announcement',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.mode_edit_outlined,
                    color: Colors.grey,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),

        // Posts List
        Expanded(
          child: categoryPosts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        categoryIcon,
                        size: 48,
                        color: Colors.grey.withValues(alpha: 0.4),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'No approved $type messages yet',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: categoryPosts.length,
                  itemBuilder: (context, index) {
                    final post = categoryPosts[index];
                    return _buildPostCard(post, lang);
                  },
                ),
        ),
      ],
    );
  }

  // Single Post Card Builder
  Widget _buildPostCard(Map<String, dynamic> post, LanguageProvider lang) {
    final String postType = post['type'] ?? 'General';
    final style = _getCategoryStyle(postType);
    final Color categoryColor = style['color'] ?? primaryNavy;
    final IconData categoryIcon = style['icon'] ?? Icons.message_outlined;

    final String userName = post['userName'] ?? 'Sanjay Patel';
    final String date = post['date'] ?? '14-Jun-2026';
    final String content = post['content'] ?? '';
    final String whatsapp = post['whatsappNumber'] ?? '';

    final isCurrentUser =
        userName == lang.registeredName ||
        (lang.registeredName.isEmpty && userName == 'Sanjay Patel');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: isCurrentUser
                      ? Colors.transparent
                      : categoryColor.withValues(alpha: 0.1),
                  backgroundImage: isCurrentUser
                      ? (lang.profileImageUrl != null &&
                                lang.profileImageUrl!.isNotEmpty
                            ? (lang.profileImageUrl!.startsWith('http')
                                  ? NetworkImage(lang.profileImageUrl!)
                                        as ImageProvider
                                  : FileImage(File(lang.profileImageUrl!))
                                        as ImageProvider)
                            : const AssetImage(
                                    'assets/images/sanjay_profile.png',
                                  )
                                  as ImageProvider)
                      : null,
                  child: isCurrentUser
                      ? null
                      : Text(
                          userName.isNotEmpty ? userName[0].toUpperCase() : 'P',
                          style: TextStyle(
                            color: categoryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                          color: primaryNavy,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        date,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: categoryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(categoryIcon, color: categoryColor, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        postType.toUpperCase(),
                        style: TextStyle(
                          color: categoryColor,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey[100]),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              content,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 13.5,
                height: 1.45,
              ),
            ),
          ),
          if (post['imagePath'] != null &&
              post['imagePath'].toString().isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: post['imagePath'].toString().startsWith('http')
                    ? Image.network(
                        post['imagePath'],
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox.shrink(),
                      )
                    : Image.file(
                        File(post['imagePath']),
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox.shrink(),
                      ),
              ),
            ),
          ],
          if (whatsapp.isNotEmpty) ...[
            Divider(height: 1, color: Colors.grey[100]),
            InkWell(
              onTap: () => _launchWhatsApp(whatsapp),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade50.withValues(alpha: 0.3),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.green,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Chat on WhatsApp',
                      style: TextStyle(
                        color: Colors.green.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
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
  }

  // --- DRAWER BUILDERS ---
  Widget _buildDrawerHeader(LanguageProvider lang) {
    if (lang.isLoggedIn) {
      return Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: primaryNavy,
          image: DecorationImage(
            image:
                lang.profileImageUrl != null && lang.profileImageUrl!.isNotEmpty
                ? (lang.profileImageUrl!.startsWith('http')
                      ? NetworkImage(lang.profileImageUrl!) as ImageProvider
                      : FileImage(File(lang.profileImageUrl!)) as ImageProvider)
                : const AssetImage('assets/images/sanjay_profile.png')
                      as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.85),
              ],
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lang.registeredName.isNotEmpty
                    ? lang.registeredName
                    : 'Sanjay Patel',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                lang.getText('gujarati_community'),
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const LoginScreen()));
        },
        child: Container(
          height: 200,
          width: double.infinity,
          color: primaryNavy,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 48,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                lang.getText('please_login'),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                lang.getText('gujarati_community'),
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void _checkRegistrationAndNavigate(
    BuildContext context,
    LanguageProvider lang,
    Widget? destination,
  ) {
    if (!lang.isLoggedIn) {
      final bool pending = lang.isProfileCompleted;
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Icon(
                  pending ? Icons.hourglass_empty : Icons.warning_amber_rounded,
                  color: pending ? Colors.blue : Colors.orange,
                  size: 28,
                ),
                const SizedBox(width: 8),
                Text(
                  pending
                      ? lang.getText('registration_pending')
                      : 'Registration Incomplete',
                  style: const TextStyle(
                    color: Color(0xFF00005C),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: Text(
              pending
                  ? lang.getText('registration_pending_desc')
                  : 'Your registration is currently incomplete. Please complete your registration to access this page.',
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => pending
                          ? const MembershipRequestScreen()
                          : const DetailedRegistrationScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00005C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  pending
                      ? lang.getText('view_status')
                      : 'Complete Registration',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else {
      if (destination != null) {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => destination));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Feature coming soon!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? primaryNavy : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? Colors.white : primaryNavy,
          size: 22,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
            fontSize: 14,
          ),
        ),
        onTap: () {
          onTap();
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      ),
    );
  }

  Widget _buildProfileTab(LanguageProvider lang) {
    final String displayName = lang.registeredName.isNotEmpty
        ? lang.registeredName
        : 'Sanjay Patel';
    
    final String displayBirthDate = lang.isProfileCompleted
        ? (lang.profileDetails['birthDate'] ?? '15 July 1958')
        : '15 July 1958';

    final String rawBloodGroup = lang.profileDetails['bloodGroup'] ?? 'B Positive (B+)';
    final String displayBloodGroup = (rawBloodGroup == 'Select' || rawBloodGroup.isEmpty)
        ? 'B Positive (B+)'
        : rawBloodGroup;

    final String displayNativePlace = lang.isProfileCompleted
        ? (lang.profileDetails['nativePlace'] ?? 'Kheda, Gujarat')
        : 'Kheda, Gujarat';

    final String marital = lang.profileDetails['maritalStatus'] ?? 'Select';
    final String defaultSpouse = (marital == 'Single') ? 'N/A (Single)' : 'Meena Patel';
    final String displaySpouseName = lang.isProfileCompleted
        ? (lang.profileDetails['spouseName']?.isNotEmpty == true ? lang.profileDetails['spouseName']! : defaultSpouse)
        : 'Meena Patel';

    final String defaultChildren = (marital == 'Single') ? 'None' : '2 (Rajesh, Anjali)';
    final String displayChildren = lang.isProfileCompleted
        ? (lang.profileDetails['children']?.isNotEmpty == true ? lang.profileDetails['children']! : defaultChildren)
        : '2 (Rajesh, Anjali)';

    final String rawCommunityWing = lang.profileDetails['communityWing'] ?? 'North Zone Senior Circle';
    final String displayCommunityWing = (rawCommunityWing == 'Select' || rawCommunityWing.isEmpty)
        ? 'North Zone Senior Circle'
        : rawCommunityWing;

    final String memberId = lang.isProfileCompleted
        ? 'HC-2026-${displayName.hashCode.abs().toString().padLeft(4, '0').substring(0, 4)}'
        : 'HC-1998-0422';

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: Column(
        children: [
          // Sanjay Patel / User photo inside double border box
          Center(
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFD6DBDF), // light grey/blue double border
                  width: 1.5,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  (lang.profileImageUrl != null && lang.profileImageUrl!.isNotEmpty)
                      ? lang.profileImageUrl!
                      : 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150', // Default senior Gujarati man portrait
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 90,
                    height: 90,
                    color: Colors.grey[200],
                    child: const Icon(Icons.person, size: 48, color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            displayName,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: primaryNavy,
            ),
          ),
          const SizedBox(height: 24),

          // Secondary Tab Bar (My Profile / Family Tree)
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1.2),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _profileSubTab = 'My Profile';
                      });
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          child: Text(
                            'My Profile',
                            style: TextStyle(
                              color: _profileSubTab == 'My Profile' ? primaryNavy : Colors.grey[500],
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        if (_profileSubTab == 'My Profile')
                          Container(
                            height: 3,
                            color: primaryNavy,
                          )
                        else
                          const SizedBox(height: 3),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _profileSubTab = 'Family Tree';
                      });
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          child: Text(
                            'Family Tree',
                            style: TextStyle(
                              color: _profileSubTab == 'Family Tree' ? primaryNavy : Colors.grey[500],
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        if (_profileSubTab == 'Family Tree')
                          Container(
                            height: 3,
                            color: primaryNavy,
                          )
                        else
                          const SizedBox(height: 3),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Tab Body
          if (_profileSubTab == 'My Profile') ...[
            // Card 1: Personal Details
            _buildProfileDataCard(
              title: 'Personal Details',
              rows: [
                {'label': 'DATE OF BIRTH', 'value': displayBirthDate},
                {'label': 'BLOOD GROUP', 'value': displayBloodGroup},
                {'label': 'NATIVE PLACE', 'value': displayNativePlace},
              ],
            ),
            const SizedBox(height: 16),

            // Card 2: Family Details
            _buildProfileDataCard(
              title: 'Family Details',
              rows: [
                {'label': 'SPOUSE NAME', 'value': displaySpouseName},
                {'label': 'CHILDREN', 'value': displayChildren},
              ],
            ),
            const SizedBox(height: 16),

            // Card 3: Community
            _buildProfileDataCard(
              title: 'Community',
              rows: [
                {'label': 'COMMUNITY WING', 'value': displayCommunityWing},
                {'label': 'MEMBER ID', 'value': memberId},
              ],
            ),
            const SizedBox(height: 24),

            // Edit Profile Details Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const DetailedRegistrationScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryNavy,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                icon: const Icon(Icons.edit, size: 18),
                label: const Text(
                  'Edit Profile Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ] else ...[
            // Family Tree Tab Content
            _buildFamilyTreeTab(lang, displayName, displaySpouseName, displayChildren),
          ],
        ],
      ),
    );
  }

  Widget _buildProfileDataCard({
    required String title,
    required List<Map<String, String>> rows,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: primaryNavy,
                fontWeight: FontWeight.w800,
                fontSize: 14.5,
              ),
            ),
          ),
          // Rows
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: List.generate(rows.length, (index) {
                final row = rows[index];
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          row['label']!,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 11.5,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          row['value']!,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    if (index < rows.length - 1)
                      const Divider(height: 24, thickness: 0.5, color: Color(0xFFEEEEEE)),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFamilyTreeTab(
    LanguageProvider lang,
    String userName,
    String spouseName,
    String children,
  ) {
    // Read parent detail strings
    final details = lang.profileDetails;
    final String father = details['fatherName']?.isNotEmpty == true ? details['fatherName']! : 'Amratlal Patel';
    final String mother = details['motherName']?.isNotEmpty == true ? details['motherName']! : 'Savita Patel';
    final String patGrandfather = details['fathersFatherName']?.isNotEmpty == true ? details['fathersFatherName']! : 'Hansraj Patel';
    final String patGrandmother = details['fathersMotherName']?.isNotEmpty == true ? details['fathersMotherName']! : 'Kantilata Patel';
    final String matGrandfather = details['mothersFatherName']?.isNotEmpty == true ? details['mothersFatherName']! : 'Ramanlal Shah';
    final String matGrandmother = details['mothersMotherName']?.isNotEmpty == true ? details['mothersMotherName']! : 'Nirmala Shah';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Family Tree',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: primaryNavy,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Generational lineage compiled from your registered details.',
          style: TextStyle(color: Colors.grey[600], fontSize: 12.5, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 20),

        // Generation 1: Grandparents
        _buildTreeGenerationHeader('Generation 1: Grandparents'),
        Row(
          children: [
            Expanded(
              child: _buildTreeNodeCard(
                title: 'Paternal',
                names: [patGrandfather, patGrandmother],
                icon: Icons.elderly_outlined,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTreeNodeCard(
                title: 'Maternal',
                names: [matGrandfather, matGrandmother],
                icon: Icons.elderly_woman_outlined,
              ),
            ),
          ],
        ),
        _buildVerticalConnector(),

        // Generation 2: Parents
        _buildTreeGenerationHeader('Generation 2: Parents'),
        _buildTreeNodeCard(
          title: 'Father & Mother',
          names: [father, mother],
          icon: Icons.people_outline_rounded,
        ),
        _buildVerticalConnector(),

        // Generation 3: Self & Spouse
        _buildTreeGenerationHeader('Generation 3: Self & Spouse'),
        _buildTreeNodeCard(
          title: 'You & Spouse',
          names: [userName, spouseName],
          icon: Icons.favorite_border_rounded,
          isHighlight: true,
        ),
        _buildVerticalConnector(),

        // Generation 4: Children
        _buildTreeGenerationHeader('Generation 4: Children'),
        _buildTreeNodeCard(
          title: 'Children',
          names: [children],
          icon: Icons.child_care_outlined,
        ),
      ],
    );
  }

  Widget _buildTreeGenerationHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 10.5,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _buildTreeNodeCard({
    required String title,
    required List<String> names,
    required IconData icon,
    bool isHighlight = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isHighlight ? primaryNavy : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHighlight ? primaryNavy : Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: isHighlight ? Colors.orange.shade300 : primaryNavy,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isHighlight ? Colors.white70 : Colors.grey.shade500,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                ...names.map((name) => Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Text(
                    name,
                    style: TextStyle(
                      color: isHighlight ? Colors.white : Colors.black87,
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalConnector() {
    return Center(
      child: Container(
        width: 2,
        height: 20,
        color: Colors.grey.shade300,
      ),
    );
  }
}
