import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/member_directory_screen.dart';
import '../screens/matches_screen.dart';
import '../screens/profile_screen.dart';

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

  void _handleTap(BuildContext context, int index) {
    if (onTap != null) {
      onTap!(index);
      return;
    }

    if (index == currentIndex) return;

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
              _buildNavItem(context, 0, Icons.home_outlined, Icons.home, 'Home'),
              _buildNavItem(context, 1, Icons.explore_outlined, Icons.explore, 'Discover'),
              _buildNavItem(context, 2, Icons.favorite_outline, Icons.favorite, 'Matches'),
              _buildNavItem(context, 3, Icons.person_outline, Icons.person, 'Profile'),
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
