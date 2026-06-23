import 'dart:async';
import 'package:flutter/material.dart';
import 'heritage_core_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _realPage = 0;
  Timer? _timer;

  final Color primaryNavy = const Color(0xFF00005C);
  final Color primaryGold = const Color(0xFFB87333);
  final Color inactiveDot = const Color(0xFFE0E0E0);

  @override
  void initState() {
    super.initState();
    // Auto-slide every 4 seconds
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      _realPage++;
      _pageController.animateToPage(
        _realPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutQuart,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    // Stop the timer and navigate to the Heritage Core screen
    _timer?.cancel();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HeritageCoreScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    int currentPage = _realPage % 3;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              // Page View for sliding content (Infinite Loop)
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _realPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    int slideIndex = index % 3;
                    if (slideIndex == 0) return _buildPage1();
                    if (slideIndex == 1) return _buildPage2();
                    return _buildPage3();
                  },
                ),
              ),

              const SizedBox(height: 32),

              // Pagination Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDot(isActive: currentPage == 0),
                  const SizedBox(width: 8),
                  _buildDot(isActive: currentPage == 1),
                  const SizedBox(width: 8),
                  _buildDot(isActive: currentPage == 2),
                ],
              ),
              const SizedBox(height: 32),

              // Next Button (Always static "Next" here, takes user to the Heritage Core screen)
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryNavy,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 0,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Bottom Gujarati Text
              const Text(
                'આગળ વધો',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // --- PAGE 1 ---
  Widget _buildPage1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: Image.asset(
                'assets/images/onboarding_people.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Text(
                    'Please save the image as\n"onboarding_people.jpg"\nin the assets/images/ folder',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        Text(
          'Connect with Your\nCommunity',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: primaryNavy,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'તમારા સમુદાય સાથે જોડાઓ',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: primaryGold,
          ),
        ),
      ],
    );
  }

  // --- PAGE 2 ---
  Widget _buildPage2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: Image.asset(
                'assets/images/image2.jpeg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Text(
                    'Image 2 Placeholder',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFeatureIcon(Icons.account_tree, 'Family Tree'),
            const SizedBox(width: 24),
            _buildFeatureIcon(Icons.favorite, 'Matrimony'),
            const SizedBox(width: 24),
            _buildFeatureIcon(Icons.business, 'Directory'),
          ],
        ),
        const SizedBox(height: 32),
        Text(
          'Preserving Heritage',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: primaryNavy,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'આપણો ગૌરવશાળી વારસો સાચવો',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: primaryGold,
          ),
        ),
      ],
    );
  }

  // --- PAGE 3 ---
  Widget _buildPage3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: Image.asset(
                'assets/images/image3.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Text(
                    'Image 3 Placeholder',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFeatureIcon(Icons.article, 'News'),
            const SizedBox(width: 24),
            _buildFeatureIcon(Icons.event, 'Events'),
            const SizedBox(width: 24),
            _buildFeatureIcon(Icons.volunteer_activism, 'Charity'),
          ],
        ),
        const SizedBox(height: 32),
        Text(
          'Community News\n& Events',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: primaryNavy,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'સમાજના સમાચાર અને ઇવેન્ટ્સ',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: primaryGold,
          ),
        ),
      ],
    );
  }

  // Helper for feature icons
  Widget _buildFeatureIcon(IconData iconData, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: primaryNavy.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: primaryNavy.withValues(alpha: 0.1)),
          ),
          child: Icon(iconData, color: primaryNavy, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: primaryNavy.withValues(alpha: 0.8),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Helper for pagination dot
  Widget _buildDot({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? 24 : 10,
      height: 10,
      decoration: BoxDecoration(
        color: isActive ? primaryNavy : inactiveDot,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
