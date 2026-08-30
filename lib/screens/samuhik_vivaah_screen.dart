import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'couple_registration_screen.dart';

class SamuhikVivaahScreen extends StatelessWidget {
  final String? userName;

  const SamuhikVivaahScreen({super.key, this.userName});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final bool isGu = lang.currentLanguage == 'gu';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Color(0xFF1E232D)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isGu ? 'સમૂહ લગ્ન' : 'Samuhik Vivaah',
          style: const TextStyle(
            fontFamily: 'Serif',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E232D),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header Subtitle
            Text(
              isGu
                  ? 'સમુદાયના નેતૃત્વમાં સમૂહ લગ્ન સમારોહ દ્વારા પરંપરાની ઉજવણી, દરેક યુગલ ગૌરવ અને સામુદાયિક સમર્થન સાથે તેમની સફર શરૂ કરે તેની ખાતરી કરે છે.'
                  : 'Celebrating tradition through community-led mass marriage ceremonies, ensuring every couple begins their journey with dignity and communal support.',
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF64748B),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),

            // MAIN EVENT CARD (Annual Community Mass Marriage 2024)
            _buildMainEventCard(context, isGu),
            const SizedBox(height: 24),

            // SECTION 1: UPCOMING CEREMONIES
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isGu ? 'આગામી સમારોહ' : 'Upcoming Ceremonies',
                  style: const TextStyle(
                    fontFamily: 'Serif',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E232D),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    isGu ? 'બધા જુઓ' : 'See All',
                    style: const TextStyle(
                      color: Color(0xFF1E232D),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildUpcomingEventItem(context, isGu),
            const SizedBox(height: 24),

            // SECTION 2: PAST SUCCESSES / GALLERY
            Text(
              isGu ? 'ભૂતકાળની સફળતાઓ' : 'Past Successes',
              style: const TextStyle(
                fontFamily: 'Serif',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E232D),
              ),
            ),
            const SizedBox(height: 12),
            _buildPastSuccessCard(context, isGu),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildMainEventCard(BuildContext context, bool isGu) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event Banner Image with Badges
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Container(
                  height: 180,
                  width: double.infinity,
                  color: const Color(0xFFFFF7DB),
                  child: Image.asset(
                    'assets/images/image1.jpeg',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Center(
                      child: Icon(Icons.volunteer_activism, size: 60, color: Color(0xFFE5A93C)),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 14,
                left: 14,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E232D),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    isGu ? 'મુખ્ય ઇવેન્ટ' : 'FLAGSHIP EVENT',
                    style: const TextStyle(
                      color: Color(0xFFE5A93C),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isGu ? 'વાર્ષિક સામુદાયિક\nસમૂહ લગ્ન ૨૦૨૪' : 'Annual Community\nMass Marriage 2024',
                  style: const TextStyle(
                    fontFamily: 'Serif',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E232D),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),

                // Date & Location Info
                Row(
                  children: const [
                    Icon(Icons.calendar_today_outlined, size: 15, color: Color(0xFF64748B)),
                    SizedBox(width: 6),
                    Text(
                      '25-Nov-2024',
                      style: TextStyle(fontSize: 13, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 16),
                    Icon(Icons.location_on_outlined, size: 16, color: Color(0xFF64748B)),
                    SizedBox(width: 4),
                    Text(
                      'Ahmedabad, Gujarat',
                      style: TextStyle(fontSize: 13, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Progress Indicator (Funding Progress)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isGu ? 'ફંડિંગ પ્રગતિ' : 'Funding Progress',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
                    ),
                    Text(
                      isGu ? '૩૩% એકત્રિત' : '33% Raised',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1E232D)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: const LinearProgressIndicator(
                    value: 0.33,
                    minHeight: 7,
                    backgroundColor: Color(0xFFF1F5F9),
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE5A93C)),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isGu ? '₹ ૫,૦૦,૦૦૦ એકત્રિત' : '₹ 5,00,000 Raised',
                      style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                    ),
                    Text(
                      isGu ? 'લક્ષ્ય: ₹ ૧૫,૦૦,૦૦૦' : 'Goal: ₹ 15,00,000',
                      style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // REGISTER AS COUPLE Button (Yellow Theme)
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CoupleRegistrationScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE5A93C),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                    ),
                    child: Text(
                      isGu ? 'દંપતી તરીકે નોંધણી કરો' : 'REGISTER AS COUPLE',
                      style: const TextStyle(
                        color: Color(0xFF191C21),
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
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
    );
  }

  Widget _buildUpcomingEventItem(BuildContext context, bool isGu) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF7DB),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.favorite_rounded, color: Color(0xFFE5A93C), size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isGu ? 'પ્રાદેશિક સમૂહ લગ્ન - સુરત' : 'Regional Vivaah - Surat',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF1E232D)),
                ),
                const SizedBox(height: 4),
                Text(
                  isGu ? '૧૫ ડિસેમ્બર ૨૦૨૪ • સરદાર પટેલ હોલ, સુરત' : '15-Dec-2024 • Sardar Patel Hall, Surat',
                  style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isGu ? 'સુરત ઇવેન્ટની વિગતો' : 'Surat Event Details'),
                  backgroundColor: const Color(0xFF191C21),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF191C21),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              isGu ? 'સ્પોન્સર કરો' : 'Sponsor',
              style: const TextStyle(color: Color(0xFFE5A93C), fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPastSuccessCard(BuildContext context, bool isGu) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color(0xFFF1F5F9),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.groups_rounded, color: Color(0xFF475569), size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isGu ? '૫૦+ યુગલો' : '50+ Couples United',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF1E232D)),
                ),
                const SizedBox(height: 2),
                Text(
                  isGu ? '૨૦૨૩ ના સમારોહમાં જોડાયા' : 'United in 2023 ceremony',
                  style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isGu ? 'ગેલેરી ઓપન થાય છે...' : 'Opening Gallery...'),
                  backgroundColor: const Color(0xFF191C21),
                ),
              );
            },
            child: Text(
              isGu ? 'ગેલેરી જુઓ ↗' : 'View Gallery ↗',
              style: const TextStyle(color: Color(0xFF1E232D), fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
