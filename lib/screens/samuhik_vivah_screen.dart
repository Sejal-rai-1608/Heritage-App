import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'couple_registration_screen.dart';

class SamuhikVivahScreen extends StatelessWidget {
  const SamuhikVivahScreen({super.key});

  static const Color primaryNavy = Color(0xFF00005C);
  static const Color accentGold = Color(0xFFE67E22);
  static const Color orangeAccent = Color(0xFFD35400);


  void _showSponsorDialog(BuildContext context, String eventTitle) {
    final nameController = TextEditingController();
    final amountController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text(
            'Sponsor a Couple',
            style: const TextStyle(color: primaryNavy, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Support $eventTitle',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Sponsor Name / Company Name",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.business, color: primaryNavy),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Sponsorship Amount (₹)",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money, color: Colors.green),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Contact Phone Number",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone, color: primaryNavy),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isEmpty || amountController.text.isEmpty || phoneController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill all fields'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                Navigator.of(context).pop(); // Dismiss form
                _showSuccessAlert(context, 'Thank you for your generous sponsorship offer! Organizers will contact you.');
              },
              style: ElevatedButton.styleFrom(backgroundColor: primaryNavy),
              child: const Text('Submit Support', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessAlert(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text('Success', style: TextStyle(color: primaryNavy, fontWeight: FontWeight.bold)),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK', style: TextStyle(fontWeight: FontWeight.bold, color: primaryNavy)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
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
              // Page Title: Samuhik Vivaah
              Text(
                lang.getText('samuhik_vivah_title'),
                style: const TextStyle(
                  color: primaryNavy,
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 6),
              // Page Subtitle
              Text(
                lang.getText('samuhik_vivah_subtitle'),
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13.5,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 20),

              // MAIN EVENT CARD
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Image Stack
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          child: Container(
                            height: 180,
                            width: double.infinity,
                            color: Colors.orange.shade50,
                            child: Image.asset(
                              'assets/images/image2.jpeg',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Center(
                                child: Icon(Icons.celebration, color: primaryNavy, size: 64),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: primaryNavy,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'MAIN EVENT',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 10,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Card Body details
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            lang.getText('annual_community_mass_marriage'),
                            style: const TextStyle(
                              color: primaryNavy,
                              fontWeight: FontWeight.w800,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Funding Progress headers
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                lang.getText('funding_progress'),
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                lang.getText('raised_percent'),
                                style: const TextStyle(
                                  color: orangeAccent,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Progress bar (33%)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: 0.33,
                              backgroundColor: Colors.grey.shade200,
                              valueColor: const AlwaysStoppedAnimation<Color>(orangeAccent),
                              minHeight: 8,
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Stats row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '₹ 5,00,000 raised',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.5,
                                ),
                              ),
                              Text(
                                'Goal: ₹ 15,00,000',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.5,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // REGISTER AS COUPLE Button
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const CoupleRegistrationScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryNavy,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              icon: const Icon(Icons.person_add_alt_1_outlined, size: 18),
                              label: Text(
                                lang.getText('register_as_couple'),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13,
                                  letterSpacing: 0.5,
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
              const SizedBox(height: 28),

              // UPCOMING CEREMONIES SECTION
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    lang.getText('upcoming_ceremonies'),
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Showing all ceremonies...')),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    iconAlignment: IconAlignment.end,
                    label: Text(
                      '${lang.getText('see_all')} ',
                      style: const TextStyle(
                        color: primaryNavy,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: primaryNavy,
                      size: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Upcoming Event Card (Surat)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lang.getText('regional_vivah_surat'),
                        style: const TextStyle(
                          color: primaryNavy,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Info details
                      _buildInfoDetail(Icons.calendar_today_outlined, '15 Dec 2024'),
                      const SizedBox(height: 6),
                      _buildInfoDetail(Icons.location_on_outlined, 'Sardar Patel Hall, Surat'),
                      const SizedBox(height: 14),

                      // Sponsor a Couple button
                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: OutlinedButton.icon(
                          onPressed: () => _showSponsorDialog(
                            context,
                            lang.getText('regional_vivah_surat'),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: primaryNavy,
                            side: const BorderSide(color: primaryNavy),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          icon: const Icon(Icons.volunteer_activism_outlined, size: 16),
                          label: Text(
                            lang.getText('sponsor_a_couple'),
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // PAST SUCCESSES SECTION
              Text(
                lang.getText('past_successes'),
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),

              // Success stats card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Navy Box Icon
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: primaryNavy,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.groups_outlined,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Info text
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lang.getText('couples_united_count'),
                              style: const TextStyle(
                                color: primaryNavy,
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              lang.getText('united_in_year'),
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 4),

                            // View Gallery link
                            InkWell(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Opening Gallery...')),
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    lang.getText('view_gallery'),
                                    style: const TextStyle(
                                      color: orangeAccent,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.open_in_new,
                                    color: orangeAccent,
                                    size: 12,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoDetail(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey.shade600, size: 15),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
