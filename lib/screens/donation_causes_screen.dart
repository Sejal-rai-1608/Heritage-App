import 'package:flutter/material.dart';
import 'donation_checkout_screen.dart';

class DonationCausesScreen extends StatefulWidget {
  final String? userName;

  const DonationCausesScreen({super.key, this.userName});

  @override
  State<DonationCausesScreen> createState() => _DonationCausesScreenState();
}

class _DonationCausesScreenState extends State<DonationCausesScreen> {
  int _activeTab = 0; // 0 = Community Causes, 1 = My Giving History

  void _navigateToCheckout(String title, String image, String amount) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DonationCheckoutScreen(
          userName: widget.userName,
          causeTitle: title,
          imagePath: image,
          defaultAmount: amount,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Color(0xFF1E232D)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'હેરિટેજ લક્સ',
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E232D),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined, color: Color(0xFF1E232D)),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFD9B854), width: 1.5),
                image: const DecorationImage(
                  image: AssetImage('assets/images/sanjay_profile.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToCheckout(
            'ગામડાની પ્રાથમિક શાળાનું નવીનીકરણ',
            'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=800&auto=format&fit=crop&q=80',
            '1000',
          );
        },
        backgroundColor: const Color(0xFFFDE047),
        child: const Icon(Icons.add, color: Color(0xFF1E232D), size: 28),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Header Title & Subtitle (Screenshot 2)
            const Text(
              'આપણા વારસાના ભવિષ્યને\nઆકાર આપો',
              style: TextStyle(
                fontFamily: 'Serif',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E232D),
                height: 1.2,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'તમારું યોગદાન સુનિશ્ચિત કરે છે કે આપણો સાંસ્કૃતિક વારસો અને સામુદાયિક પાયો આવનારી પેઢીઓ માટે મજબૂત રહે.',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF64748B),
                height: 1.45,
              ),
            ),
            const SizedBox(height: 20),

            // Tab Buttons: Community Causes | My Giving History
            Row(
              children: [
                GestureDetector(
                  onTap: () => setState(() => _activeTab = 0),
                  child: Column(
                    children: [
                      Text(
                        'સમુદાયના હેતુઓ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: _activeTab == 0 ? const Color(0xFF1E232D) : const Color(0xFF94A3B8),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 3,
                        width: 120,
                        color: _activeTab == 0 ? const Color(0xFFFDE047) : Colors.transparent,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                GestureDetector(
                  onTap: () => setState(() => _activeTab = 1),
                  child: Column(
                    children: [
                      Text(
                        'મારો દાન ઇતિહાસ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: _activeTab == 1 ? const Color(0xFF1E232D) : const Color(0xFF94A3B8),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 3,
                        width: 120,
                        color: _activeTab == 1 ? const Color(0xFFFDE047) : Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            if (_activeTab == 0) ...[
              // HERO CAUSE CARD: Village Primary School Renovation (Screenshot 2)
              _buildHeroCauseCard(),
              const SizedBox(height: 28),

              // YOUR GIVING IMPACT CARD (Dark Navy - Screenshot 3)
              _buildGivingImpactCard(),
              const SizedBox(height: 28),

              // COMMUNITY INITIATIVES SECTION (Screenshots 3 & 4)
              const Text(
                'સામુદાયિક પહેલ',
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E232D),
                ),
              ),
              const SizedBox(height: 14),

              // Initiative 1: Heritage Temple Restoration
              _buildInitiativeCard(
                icon: Icons.temple_hindu_outlined,
                title: 'હેરિટેજ મંદિરનું પુનરુદ્ધાર',
                tagText: '૮૦% પૂર્ણ',
                tagBg: const Color(0xFFFEF9C3),
                tagTextColor: const Color(0xFF856404),
                subtitle: 'આપણા સેન્ટ્રલ કમ્યુનિટી મંદિરના ૨૦૦ વર્ષ જૂના સ્થાપત્યનું જતન.',
                progressText: 'એકત્રિત\n₹૧૨,૮૦,૦૦૦',
                buttonText: 'વધુ યોગદાન આપો',
                onPressed: () {
                  _navigateToCheckout(
                    'હેરિટેજ મંદિરનું પુનરુદ્ધાર',
                    'https://images.unsplash.com/photo-1548013146-72479768bada?w=800&auto=format&fit=crop&q=80',
                    '2000',
                  );
                },
              ),
              const SizedBox(height: 16),

              // Initiative 2: Senior Healthcare Fund
              _buildInitiativeCard(
                icon: Icons.local_hospital_outlined,
                title: 'વરિષ્ઠ નાગરિક આરોગ્ય ભંડોળ',
                tagText: 'ચાલુ ભંડોળ',
                tagBg: const Color(0xFFDBEAFE),
                tagTextColor: const Color(0xFF1E40AF),
                subtitle: 'આપણા સમુદાયના વડીલો માટે વિશેષ તબીબી સાધનો અને નિયમિત તપાસ પ્રદાન કરવી.',
                progressText: 'પ્રગતિ\n₹૫,૦૦,૦૦૦ માંથી ₹૧,૨૦,૦૦૦',
                buttonText: 'હેતુને ટેકો આપો',
                onPressed: () {
                  _navigateToCheckout(
                    'વરિષ્ઠ નાગરિક આરોગ્ય ભંડોળ',
                    'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=800&auto=format&fit=crop&q=80',
                    '500',
                  );
                },
              ),
              const SizedBox(height: 28),

              // QUOTE CARD (Dark Navy - Screenshot 4)
              _buildQuoteCard(),
              const SizedBox(height: 40),
            ] else ...[
              // Giving History View
              _buildGivingHistoryTab(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCauseCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with ! Urgent Tag
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(
                  'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=800&auto=format&fit=crop&q=80',
                  height: 190,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 16,
                top: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDC2626),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: const [
                      Text(
                        '! તાત્કાલિક',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ગામડાની પ્રાથમિક શાળાનું\nનવીનીકરણ',
                  style: TextStyle(
                    fontFamily: 'Serif',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E232D),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'આપણા સ્થાનિક શિક્ષણના પાયાને પુનર્જીવિત કરી રહ્યા છીએ, ૨૦૦+ બાળકો માટે સુરક્ષિત અને પ્રેરણાદાયી વાતાવરણ.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      '₹૪,૫૦,૦૦૦ એકત્રિત',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1E232D)),
                    ),
                    Text(
                      'લક્ષ્ય: ₹૧૦,૦૦,૦૦૦',
                      style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: const LinearProgressIndicator(
                    value: 0.45,
                    minHeight: 6,
                    backgroundColor: Color(0xFFE2E8F0),
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFDE047)),
                  ),
                ),
                const SizedBox(height: 18),

                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: () {
                      _navigateToCheckout(
                        'ગામડાની પ્રાથમિક શાળાનું નવીનીકરણ',
                        'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=800&auto=format&fit=crop&q=80',
                        '1000',
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFDE047),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23),
                      ),
                    ),
                    child: const Text(
                      'હમણાં જ દાન કરો',
                      style: TextStyle(
                        color: Color(0xFF1E232D),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
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

  Widget _buildGivingImpactCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.volunteer_activism_outlined, color: Color(0xFFFDE047), size: 22),
              SizedBox(width: 10),
              Text(
                'તમારા દાનની અસર',
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Causes count box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '૧૨',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFDE047),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'આ વર્ષે સપોર્ટ કરેલ હેતુઓ',
                  style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Latest milestone box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'તાજેતરની સિદ્ધિ',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF64748B),
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'વાર્ષિક યુવા શિષ્યવૃત્તિ ૨૦૨૩',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'પ્રોજેક્ટ સફળતાપૂર્વક ભંડોળ પૂરું પડાયેલ અને સક્રિય.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'અસર અહેવાલ જુઓ ↗',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFDE047),
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

  Widget _buildInitiativeCard({
    required IconData icon,
    required String title,
    required String tagText,
    required Color tagBg,
    required Color tagTextColor,
    required String subtitle,
    required String progressText,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Serif',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E232D),
                  ),
                ),
              ),
              Icon(icon, color: const Color(0xFF1E232D), size: 22),
            ],
          ),
          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: tagBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              tagText,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: tagTextColor,
              ),
            ),
          ),
          const SizedBox(height: 10),

          Text(
            subtitle,
            style: const TextStyle(fontSize: 13, color: Color(0xFF64748B), height: 1.4),
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                progressText,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1E232D), height: 1.3),
              ),
              OutlinedButton(
                onPressed: onPressed,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF856404)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF856404),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: const [
          Text(
            '"ઉદારતા એ માનવતાનું પુષ્પ છે."',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Serif',
              fontStyle: FontStyle.italic,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '— હેરિટેજ કાઉન્સિલ',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFDE047),
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGivingHistoryTab() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: const [
              Icon(Icons.history_outlined, size: 48, color: Color(0xFF64748B)),
              SizedBox(height: 12),
              Text(
                'દાન ઇતિહાસ',
                style: TextStyle(fontFamily: 'Serif', fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text(
                'તમે ૨૦૨૪ માં ૧૨ સામુદાયિક હેતુઓમાં યોગદાન આપ્યું છે. તમારી ઉદારતા માટે આભાર.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
