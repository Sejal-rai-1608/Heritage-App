import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'donation_details_screen.dart';

class DonationScreen extends StatelessWidget {
  const DonationScreen({super.key});

  static const Color primaryNavy = Color(0xFF00005C);
  static const Color accentGold = Color(0xFFE67E22);
  static const Color progressColor = Color(0xFF8E4A00); // Brownish/orange color from mockup progress bar

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryNavy),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          lang.getText('heritage_core'),
          style: const TextStyle(
            color: primaryNavy,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: primaryNavy.withValues(alpha: 0.1),
              backgroundImage: lang.profileImageUrl != null &&
                      lang.profileImageUrl!.isNotEmpty
                  ? (lang.profileImageUrl!.startsWith('http')
                      ? NetworkImage(lang.profileImageUrl!) as ImageProvider
                      : FileImage(File(lang.profileImageUrl!)) as ImageProvider)
                  : const AssetImage('assets/images/sanjay_profile.png') as ImageProvider,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Large Title
              Text(
                lang.getText('community_support'),
                style: const TextStyle(
                  color: primaryNavy,
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 8),
              // Subtitle
              Text(
                lang.getText('support_subtitle') != 'support_subtitle'
                    ? lang.getText('support_subtitle')
                    : 'Your contributions help preserve our heritage and support community welfare programs.',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),

              // SECTION 1: DONATION REQUESTS (URGENT)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    lang.getText('donation_requests'),
                    style: const TextStyle(
                      color: Color(0xFF8B5A2B), // Brownish gold color
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                      letterSpacing: 0.8,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      lang.getText('urgent') != 'urgent' ? lang.getText('urgent') : 'URGENT',
                      style: TextStyle(
                        color: Colors.red.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Village Primary School Renovation Card
              _buildDonationCard(
                context,
                title: 'Village Primary School Renovation',
                raised: 450000,
                goal: 1000000,
                imageAsset: 'assets/images/image1.jpeg',
                isUrgent: true,
                buttonText: lang.getText('donate_now'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const DonationDetailsScreen(
                        title: 'Village Primary School Renovation',
                        description: 'Rebuilding the foundational learning center for 150 local children. Your contribution helps repair leaking roofs and provide modern desks.',
                        raised: 450000,
                        goal: 1000000,
                        imageAsset: 'assets/images/image2.jpeg',
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // SECTION 2: ACTIVE DONATIONS
              Text(
                lang.getText('active_donations'),
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 12),
              // Heritage Temple Restoration Card
              _buildActiveDonationCard(
                context,
                title: 'Heritage Temple Restoration',
                raised: 1280000,
                percentage: 80,
                isContributeMore: true,
                buttonText: lang.getText('contribute_more'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const DonationDetailsScreen(
                        title: 'Heritage Temple Restoration',
                        description: 'Help restore the centuries-old heritage temple including carvings, pillars, and stepwell architecture.',
                        raised: 1280000,
                        goal: 1600000,
                        imageAsset: 'assets/images/image3.png',
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              // Senior Healthcare Fund Card
              _buildDonationCard(
                context,
                title: 'Senior Healthcare Fund',
                raised: 120000,
                goal: 500000,
                imageAsset: null, // Just a placeholder icon
                isUrgent: false,
                buttonText: lang.getText('donate_now'),
                icon: Icons.favorite,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const DonationDetailsScreen(
                        title: 'Senior Healthcare Fund',
                        description: 'Support critical healthcare, medicines, and diagnostic checkups for elderly members in our community.',
                        raised: 120000,
                        goal: 500000,
                        imageAsset: null,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // SECTION 3: COMPLETED DONATIONS
              Text(
                lang.getText('completed_donations'),
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 12),
              // Completed card
              _buildCompletedDonationCard(
                context,
                title: 'Annual Youth Scholarship 2023',
                buttonText: lang.getText('view_impact_report'),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Opening Impact Report for 2023 Scholarship...'),
                      backgroundColor: primaryNavy,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDonationCard(
    BuildContext context, {
    required String title,
    required double raised,
    required double goal,
    required String? imageAsset,
    required bool isUrgent,
    required String buttonText,
    IconData? icon,
    required VoidCallback onPressed,
  }) {
    final double progress = (raised / goal).clamp(0.0, 1.0);
    final String raisedFormatted = raised.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
    final String goalFormatted = goal.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );

    return Container(
      width: double.infinity,
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
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 72,
                    height: 72,
                    color: Colors.grey[100],
                    child: imageAsset != null
                        ? Image.asset(
                            imageAsset,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => const Center(
                              child: Icon(Icons.school, color: primaryNavy, size: 28),
                            ),
                          )
                        : Center(
                            child: Icon(icon ?? Icons.volunteer_activism, color: primaryNavy, size: 28),
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: primaryNavy,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '₹ $raisedFormatted raised',
                            style: const TextStyle(
                              color: Color(0xFF8B5A2B),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'Goal: ₹ $goalFormatted',
                            style: const TextStyle(
                              color: Color(0xFF8B5A2B),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.shade100,
                valueColor: const AlwaysStoppedAnimation<Color>(progressColor),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 12),
            // Button
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton.icon(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryNavy,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: Icon(icon ?? Icons.volunteer_activism_outlined, size: 18),
                label: Text(
                  buttonText,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveDonationCard(
    BuildContext context, {
    required String title,
    required double raised,
    required int percentage,
    required bool isContributeMore,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    final double progress = (percentage / 100.0).clamp(0.0, 1.0);
    final String raisedFormatted = raised.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );

    return Container(
      width: double.infinity,
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
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: primaryNavy,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹ $raisedFormatted raised',
                  style: const TextStyle(
                    color: primaryNavy,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '$percentage% Complete',
                  style: const TextStyle(
                    color: Color(0xFF8B5A2B),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.shade100,
                valueColor: const AlwaysStoppedAnimation<Color>(progressColor),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 12),
            // Button
            SizedBox(
              width: double.infinity,
              height: 44,
              child: OutlinedButton.icon(
                onPressed: onPressed,
                style: OutlinedButton.styleFrom(
                  foregroundColor: primaryNavy,
                  side: const BorderSide(color: primaryNavy),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.add_circle_outline, size: 18),
                label: Text(
                  buttonText,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletedDonationCard(
    BuildContext context, {
    required String title,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
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
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF555555),
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle_outline, color: Colors.green.shade700, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        'SUCCESS',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade100,
                  foregroundColor: Colors.grey.shade700,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
