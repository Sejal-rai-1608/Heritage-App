import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../screens/home_screen.dart';
import '../screens/member_directory_screen.dart';
import '../screens/matches_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/registration_form_screen.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final String? userName;
  final Function(int index)? onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    this.userName,
    this.onTap,
  });

  void _showRegistrationRequiredDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
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
                Navigator.of(ctx).pop();
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
                Navigator.of(ctx).pop();
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

  void _handleTap(BuildContext context, int index) {
    if (onTap != null) {
      onTap!(index);
      return;
    }

    if (index == currentIndex) return;

    final lang = Provider.of<LanguageProvider>(context, listen: false);

    // If user is unverified and taps any tab other than Home (index 0)
    if (!lang.isProfileApproved && index != 0) {
      _showRegistrationRequiredDialog(context);
      return;
    }

    Widget targetScreen;
    switch (index) {
      case 0:
        targetScreen = HomeScreen(userName: userName);
        break;
      case 1:
        targetScreen = MemberDirectoryScreen(userName: userName);
        break;
      case 2:
        targetScreen = MatchesScreen(userName: userName);
        break;
      case 3:
        targetScreen = ProfileScreen(userName: userName);
        break;
      default:
        return;
    }

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => targetScreen,
        transitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final bool isGu = lang.currentLanguage == 'gu';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 15,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(context, 0, Icons.home_outlined, Icons.home, isGu ? 'હોમ' : 'Home'),
              _buildNavItem(context, 1, Icons.explore_outlined, Icons.explore, isGu ? 'શોધો' : 'Discover'),
              _buildNavItem(context, 2, Icons.favorite_outline, Icons.favorite, isGu ? 'મેચ' : 'Matches'),
              _buildNavItem(context, 3, Icons.person_outline, Icons.person, isGu ? 'પ્રોફાઈલ' : 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    int index,
    IconData iconUnselected,
    IconData iconSelected,
    String label,
  ) {
    final bool isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => _handleTap(context, index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF7DB) : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? iconSelected : iconUnselected,
              color: isSelected ? const Color(0xFF806800) : const Color(0xFF7C8BA1),
              size: 22,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? const Color(0xFF806800) : const Color(0xFF7C8BA1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
