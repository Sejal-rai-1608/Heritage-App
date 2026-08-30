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
                        'Are you sure you want to log out of your Heritage Luxe account?',
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
                                  borderRadius: BorderRadius.circular(20),
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
                backgroundColor: const Color(0xFFFCD34D),
                foregroundColor: const Color(0xFF0F172A),
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
    final String currentLang = langProvider.currentLanguage;
    final bool isGu = currentLang == 'gu';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 90,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              children: [
                const Icon(Icons.arrow_back, color: Color(0xFF0F172A), size: 18),
                const SizedBox(width: 4),
                Text(
                  isGu ? 'પાછા' : 'Back',
                  style: const TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/images/sanjay_profile.png'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
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
            const SizedBox(height: 12),
            Row(
              children: [
                // English Option
                GestureDetector(
                  onTap: () => langProvider.changeLanguage('en'),
                  child: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
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
                      const SizedBox(width: 8),
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
                const SizedBox(width: 32),

                // Gujarati Option (ગુજરાતી)
                GestureDetector(
                  onTap: () => langProvider.changeLanguage('gu'),
                  child: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
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
                      const SizedBox(width: 8),
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
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              isGu ? 'પટેલ' : _selectedCommunity,
              style: const TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Serif',
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _showChangeCommunityDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFCD34D), // Warm light gold
                foregroundColor: const Color(0xFF0F172A),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Text(
                isGu ? 'બદલો' : 'Change',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // 3. Settings Menu Items
            // Logout
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.logout_rounded,
                color: Color(0xFFDC2626),
                size: 22,
              ),
              title: Text(
                isGu ? 'લોગઆઉટ' : 'Logout',
                style: const TextStyle(
                  color: Color(0xFFDC2626),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Color(0xFF64748B),
                size: 20,
              ),
              onTap: () => _showLogoutDialog(context),
            ),
            const SizedBox(height: 8),

            // Storage Usage
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.dns_outlined,
                color: Color(0xFF0F172A),
                size: 22,
              ),
              title: Text(
                isGu ? 'સંગ્રહ વપરાશ' : 'Storage Usage',
                style: const TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Color(0xFF64748B),
                size: 20,
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
            const SizedBox(height: 8),

            // Terms of Service
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.description_outlined,
                color: Color(0xFF0F172A),
                size: 22,
              ),
              title: Text(
                isGu ? 'સેવાની શરતો' : 'Terms of Service',
                style: const TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Color(0xFF64748B),
                size: 20,
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
                            ? 'હેરિટેજ લક્સમાં આપનું સ્વાગત છે. અમારા પ્લેટફોર્મનો ઉપયોગ કરીને, તમે તમામ સમુદાય માર્ગદર્શિકાઓ અને ગોપનીયતા શરતોનું પાલન કરવા માટે સંમત થાઓ છો.'
                            : 'Welcome to Heritage Luxe. By using our platform, you agree to comply with all community guidelines and privacy terms.',
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
            const SizedBox(height: 36),

            // 4. Faded Cultural Legacy Image Component
            Center(
              child: Column(
                children: [
                  Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        // Soft faded image using Opacity & BlendMode
                        Opacity(
                          opacity: 0.35,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Image.asset(
                              'assets/images/settings_monument.png',
                              width: double.infinity,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Gradient Overlay for smooth edge fading
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFFF8FAFC).withValues(alpha: 0.8),
                                Colors.transparent,
                                const Color(0xFFF8FAFC).withValues(alpha: 0.85),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                        // Centered Overlay Text
                        Positioned(
                          bottom: 24,
                          child: Text(
                            isGu ? 'સાંસ્કૃતિક વારસો' : 'CULTURAL LEGACY',
                            style: const TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // App Version Footer
                  Text(
                    isGu ? 'એપ વર્ઝન : ૧૦.૧૬' : 'App Version : 10.16',
                    style: const TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isGu ? 'હેરિટેજ કોર કોમ્યુનિટી © ૨૦૨૪' : 'Heritage Core Community © 2024',
                    style: const TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
