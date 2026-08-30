import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final String _selectedCommunity = 'Patel';

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 32),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 4,
                  decoration: const BoxDecoration(
                    color: Color(0xFFDC2626),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                  child: Column(
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFEE2E2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.logout_rounded,
                          color: Color(0xFFDC2626),
                          size: 26,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Logout',
                        style: TextStyle(
                          color: Color(0xFF0F172A),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Serif',
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Are you sure you want to log out of your Swajan account?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 13.5,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                'CANCEL',
                                style: TextStyle(
                                  color: Color(0xFF64748B),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                final lang = Provider.of<LanguageProvider>(
                                  context,
                                  listen: false,
                                );
                                lang.setLoggedIn(false);
                                lang.resetProfile();
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (_) => const LoginScreen(),
                                  ),
                                  (route) => false,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFDC2626),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(vertical: 11),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'LOGOUT',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  letterSpacing: 0.8,
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
          ),
        );
      },
    );
  }

  void _showChangeCommunityDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'Community Profile',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontWeight: FontWeight.bold,
              fontFamily: 'Serif',
            ),
          ),
          content: const Text(
            'Current Community: Patel\n\nTo change your community profile, please contact community admin or update your profile registration.',
            style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE5A93C),
                foregroundColor: const Color(0xFF191C21),
              ),
              child: const Text('OK', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final bool isApproved = langProvider.isProfileApproved;
    final String currentLang = langProvider.currentLanguage;
    final bool isGu = currentLang == 'gu';

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFC),
        elevation: 0,
        leadingWidth: 90,
        leading: TextButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A), size: 18),
          label: Text(
            isGu ? 'પાછા' : 'Back',
            style: const TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        title: Text(
          isGu ? 'સેટિંગ્સ' : 'Settings',
          style: const TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Serif',
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Consumer<LanguageProvider>(
              builder: (context, lang, child) {
                final hasImage = lang.profileImageUrl != null && lang.profileImageUrl!.isNotEmpty;
                return CircleAvatar(
                  radius: 17,
                  backgroundColor: const Color(0xFFE5A93C),
                  backgroundImage: hasImage ? NetworkImage(lang.profileImageUrl!) : null,
                  child: hasImage
                      ? null
                      : const Icon(
                          Icons.person_rounded,
                          color: Color(0xFF191C21),
                          size: 20,
                        ),
                );
              },
            ),
          ),
        ],
      ),
      body: isApproved
          ? SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. SELECT LANGUAGE Section
                  Text(
                    isGu ? 'ભાષા પસંદ કરો' : 'SELECT LANGUAGE',
                    style: const TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 12,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      // English Option
                      GestureDetector(
                        onTap: () => langProvider.changeLanguage('en'),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: currentLang == 'en'
                                      ? const Color(0xFF0F172A)
                                      : const Color(0xFFCBD5E1),
                                  width: 2,
                                ),
                              ),
                              child: currentLang == 'en'
                                  ? Center(
                                      child: Container(
                                        width: 10,
                                        height: 10,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF0F172A),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'English',
                              style: TextStyle(
                                color: Color(0xFF0F172A),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 36),

                      // Gujarati Option (ગુજરાતી)
                      GestureDetector(
                        onTap: () => langProvider.changeLanguage('gu'),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: currentLang == 'gu'
                                      ? const Color(0xFF0F172A)
                                      : const Color(0xFFCBD5E1),
                                  width: 2,
                                ),
                              ),
                              child: currentLang == 'gu'
                                  ? Center(
                                      child: Container(
                                        width: 10,
                                        height: 10,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF0F172A),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'ગુજરાતી',
                              style: TextStyle(
                                color: Color(0xFF0F172A),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),

                  // 2. Community Profile Section
                  Text(
                    isGu ? 'સમુદાય પ્રોફાઇલ' : 'Community Profile',
                    style: const TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isGu ? 'પટેલ' : _selectedCommunity,
                    style: const TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Serif',
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Soft Yellow Change Button (matching screenshot)
                  SizedBox(
                    width: 240,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () => _showChangeCommunityDialog(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFDE047),
                        foregroundColor: const Color(0xFF191C21),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      child: Text(
                        isGu ? 'બદલો' : 'Change',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF191C21),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),

                  // 3. Settings List Options (matching screenshot)
                  // Logout
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 4),
                    leading: const Icon(
                      Icons.logout_rounded,
                      color: Color(0xFFDC2626),
                      size: 22,
                    ),
                    title: Text(
                      isGu ? 'લોગઆઉટ' : 'Logout',
                      style: const TextStyle(
                        color: Color(0xFFDC2626),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Color(0xFF475569),
                      size: 22,
                    ),
                    onTap: () => _showLogoutDialog(context),
                  ),
                  const SizedBox(height: 6),

                  // Storage Usage
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 4),
                    leading: const Icon(
                      Icons.dns_outlined,
                      color: Color(0xFF0F172A),
                      size: 22,
                    ),
                    title: Text(
                      isGu ? 'સંગ્રહ વપરાશ' : 'Storage Usage',
                      style: const TextStyle(
                        color: Color(0xFF0F172A),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Color(0xFF475569),
                      size: 22,
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isGu ? 'સ્ટોરેજ વપરાશ: ૧૪.૨ MB વપરાયેલ' : 'Storage Usage: 14.2 MB used',
                          ),
                          backgroundColor: const Color(0xFF0F172A),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 6),

                  // Terms of Service
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 4),
                    leading: const Icon(
                      Icons.description_outlined,
                      color: Color(0xFF0F172A),
                      size: 22,
                    ),
                    title: Text(
                      isGu ? 'સેવાની શરતો' : 'Terms of Service',
                      style: const TextStyle(
                        color: Color(0xFF0F172A),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Color(0xFF475569),
                      size: 22,
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          title: Text(
                            isGu ? 'સેવાની શરતો' : 'Terms of Service',
                            style: const TextStyle(
                              fontFamily: 'Serif',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: SingleChildScrollView(
                            child: Text(
                              isGu
                                  ? 'સ્વજન એપમાં આપનું સ્વાગત છે. અમારા પ્લેટફોર્મનો ઉપયોગ કરીને, તમે તમામ સમુદાય માર્ગદર્શિકાઓ અને ગોપનીયતા શરતોનું પાલન કરવા માટે સંમત થાઓ છો.'
                                  : 'Welcome to Swajan App. By using our platform, you agree to comply with all community guidelines and privacy terms.',
                              style: const TextStyle(fontSize: 13.5, height: 1.4),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                isGu ? 'બંધ કરો' : 'CLOSE',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 28),

                  // 4. CULTURAL LEGACY MONUMENT CARD (matching screenshot)
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned.fill(
                            child: Image.asset(
                              'assets/images/settings_monument.png',
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: const Color(0xFFF1F5F9),
                                child: const Icon(Icons.account_balance_rounded, size: 64, color: Color(0xFF94A3B8)),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Container(
                              color: Colors.white.withValues(alpha: 0.25),
                            ),
                          ),
                          Positioned(
                            bottom: 24,
                            child: Text(
                              'CULTURAL LEGACY',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF475569).withValues(alpha: 0.9),
                                letterSpacing: 2.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 5. App Version Footer (matching screenshot)
                  Center(
                    child: Column(
                      children: [
                        Text(
                          isGu ? 'એપ વર્ઝન : ૧.૨.૦' : 'App Version : 10.16',
                          style: const TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isGu ? 'સ્વજન સમુદાય © ૨૦૨૪' : 'Swajan Community © 2024',
                          style: const TextStyle(
                            color: Color(0xFFCBD5E1),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ACCOUNT & SESSION',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 12,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Clean Container with Only Log Out Button for Unverified Users
                  Container(
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
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color(0xFFFEE2E2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.logout_rounded,
                          color: Color(0xFFDC2626),
                          size: 22,
                        ),
                      ),
                      title: const Text(
                        'Log Out',
                        style: TextStyle(
                          color: Color(0xFFDC2626),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text(
                        'Sign out of your account session',
                        style: TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 12,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color(0xFF94A3B8),
                        size: 16,
                      ),
                      onTap: () => _showLogoutDialog(context),
                    ),
                  ),
                  const Spacer(),

                  Center(
                    child: Column(
                      children: [
                        Text(
                          isGu ? 'સ્વજન એપ' : 'SWAJAN APP',
                          style: const TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isGu ? 'વર્ઝન ૧.૨.૦ • સ્વજન સમુદાય' : 'Version 1.2.0 • Swajan Community',
                          style: const TextStyle(
                            color: Color(0xFFCBD5E1),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
    );
  }
}
