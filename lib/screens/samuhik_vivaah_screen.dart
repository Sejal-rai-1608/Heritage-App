import 'package:flutter/material.dart';
import 'couple_registration_screen.dart';

class SamuhikVivaahScreen extends StatelessWidget {
  final String? userName;

  const SamuhikVivaahScreen({super.key, this.userName});

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
          'સમૂહ લગ્ન',
          style: TextStyle(
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
            const Text(
              'સમુદાયના નેતૃત્વમાં સમૂહ લગ્ન સમારોહ દ્વારા પરંપરાની ઉજવણી, દરેક યુગલ ગૌરવ અને સામુદાયિક સમર્થન સાથે તેમની સફર શરૂ કરે તેની ખાતરી કરે છે.',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF64748B),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),

            // MAIN EVENT CARD (Annual Community Mass Marriage 2024)
            _buildMainEventCard(context),
            const SizedBox(height: 24),

            // UPCOMING CEREMONIES SECTION
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'આગામી સમારોહ',
                  style: TextStyle(
                    fontFamily: 'Serif',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E232D),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Text(
                        'બધા જુઓ',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF856404)),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward, size: 14, color: Color(0xFF856404)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildUpcomingCeremonyCard(context),
            const SizedBox(height: 28),

            // PAST SUCCESSES SECTION
            const Text(
              'ભૂતકાળની સફળતાઓ',
              style: TextStyle(
                fontFamily: 'Serif',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E232D),
              ),
            ),
            const SizedBox(height: 14),
            _buildPastSuccessesCard(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildMainEventCard(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Background Image
            Image.network(
              'https://images.unsplash.com/photo-1519741497674-611481863552?w=800&auto=format&fit=crop&q=80',
              height: 440,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            // Gradient Overlay
            Container(
              height: 440,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.25),
                    Colors.black.withValues(alpha: 0.85),
                  ],
                ),
              ),
            ),

            // Card Body Content
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Top Tag: MAIN EVENT
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDE047),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'મુખ્ય ઇવેન્ટ',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E232D),
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        const Text(
                          'વાર્ષિક સામુદાયિક\nસમૂહ લગ્ન ૨૦૨૪',
                          style: TextStyle(
                            fontFamily: 'Serif',
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Funding Progress Glass Box
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'ફંડિંગ પ્રગતિ',
                                    style: TextStyle(fontSize: 12, color: Colors.white70),
                                  ),
                                  Text(
                                    '૩૩% એકત્રિત',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFFDE047),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: const LinearProgressIndicator(
                                  value: 0.33,
                                  minHeight: 6,
                                  backgroundColor: Colors.white24,
                                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFDE047)),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    '₹ ૫,૦૦,૦૦૦ એકત્રિત',
                                    style: TextStyle(fontSize: 10, color: Colors.white70),
                                  ),
                                  Text(
                                    'લક્ષ્ય: ₹ ૧૫,૦૦,૦૦૦',
                                    style: TextStyle(fontSize: 10, color: Colors.white70),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Button: REGISTER AS COUPLE
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => CoupleRegistrationScreen(userName: userName),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFDE047),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.person_add_alt_1_outlined, color: Color(0xFF1E232D), size: 18),
                                SizedBox(width: 8),
                                Text(
                                  'દંપતી તરીકે નોંધણી કરો',
                                  style: TextStyle(
                                    color: Color(0xFF1E232D),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingCeremonyCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
          const Text(
            'પ્રાદેશિક સમૂહ લગ્ન - સુરત',
            style: TextStyle(
              fontFamily: 'Serif',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E232D),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: const [
              Icon(Icons.calendar_today_outlined, size: 14, color: Color(0xFF64748B)),
              SizedBox(width: 8),
              Text('૧૫ ડિસેમ્બર ૨૦૨૪', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: const [
              Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF64748B)),
              SizedBox(width: 8),
              Text('સરદાર પટેલ હોલ, સુરત', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
            ],
          ),
          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            height: 44,
            child: OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('સુરત ઇવેન્ટની સ્પોન્સરશિપ વિગતો ખુલી છે')),
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF1E232D)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.handshake_outlined, color: Color(0xFF1E232D), size: 18),
                  SizedBox(width: 8),
                  Text(
                    'એક દંપતીને સ્પોન્સર કરો',
                    style: TextStyle(
                      color: Color(0xFF1E232D),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPastSuccessesCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.groups, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '૫૦+ યુગલો',
                  style: TextStyle(
                    fontFamily: 'Serif',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  '૨૦૨૩ ના સમારોહમાં જોડાયા',
                  style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('૨૦૨૩ સમારોહ ગેલેરી ખુલી રહી છે...')),
                    );
                  },
                  child: Row(
                    children: const [
                      Text(
                        'ગેલેરી જુઓ ↗',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFDE047),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
