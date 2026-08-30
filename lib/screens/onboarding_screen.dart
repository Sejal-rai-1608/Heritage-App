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
    _timer?.cancel();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HeritageCoreScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _realPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final pageIndex = index % 3;
                    if (pageIndex == 0) {
                      return _buildPage1();
                    } else if (pageIndex == 1) {
                      return _buildPage2();
                    } else {
                      return _buildPage3();
                    }
                  },
                ),
              ),

              // Page Indicator Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  final pageIndex = _realPage % 3;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    height: 8.0,
                    width: pageIndex == index ? 24.0 : 8.0,
                    decoration: BoxDecoration(
                      color: pageIndex == index ? primaryNavy : inactiveDot,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 32),

              // Next Button (Primary Action)
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE5A93C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF191C21),
                      letterSpacing: 0.5,
                    ),
                  ),
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
                    'Swajan Community',
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
        const Text(
          'Discover family members, matrimony & culture',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
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
                    'Swajan Traditions',
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
          'Preserving Culture',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: primaryNavy,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Preserving ancestral lineage and cultural bonds',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
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
                    'Community Events',
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
        const Text(
          'Stay updated with upcoming mass marriages and news',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureIcon(IconData iconData, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7DB),
            shape: BoxShape.circle,
          ),
          child: Icon(iconData, color: const Color(0xFFE5A93C), size: 24),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E232D),
          ),
        ),
      ],
    );
  }
}
