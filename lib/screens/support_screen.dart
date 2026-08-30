import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'new_message_screen.dart';
import 'profile_screen.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  void _showCallSupportDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFFEFF4FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.phone_outlined,
                  color: Color(0xFF1E293B),
                  size: 28,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Call Support Team',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Our community helpline is available Mon-Sat (9 AM - 7 PM).',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F172A),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Dialing Gujarati Community Support (+91 98765 43210)...'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.call, color: Colors.white, size: 20),
                  label: const Text(
                    '+91 98765 43210',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  void _showFaqBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Frequently Asked Questions',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Serif',
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Find quick answers to common questions below.',
                style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: const [
                    _FaqTile(
                      question: 'How do I complete my profile verification?',
                      answer: 'Go to Settings > Profile, submit your official ID details, and our admin team will review and verify your profile within 24 hours.',
                    ),
                    _FaqTile(
                      question: 'How can I list my business in the Directory?',
                      answer: 'Open the Business Directory from the side menu and click "Add Business". Fill out your business details and submit for approval.',
                    ),
                    _FaqTile(
                      question: 'Who can view my contact details?',
                      answer: 'Only verified members of the Gujarati Community can view your details based on your privacy settings in the app.',
                    ),
                    _FaqTile(
                      question: 'How do I contact support directly?',
                      answer: 'You can tap "Call Support" or use "Send Message To Admin" on the Support screen to reach out to our administration.',
                    ),
                    _FaqTile(
                      question: 'What is Swajan Community membership?',
                      answer: 'Swajan is an exclusive network for verified Gujarati community members to connect, network, and access premium benefits.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final bool isGu = lang.currentLanguage == 'gu';

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F8FC),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF0F172A), size: 24),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          isGu ? 'મદદ' : 'Support',
          style: const TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Serif',
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ProfileScreen(userName: 'Sanjay Rai'),
                  ),
                );
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Color(0xFFEBF0F5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_outline,
                  color: Color(0xFF334155),
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. HELP CENTER Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isGu ? 'મદદ કેન્દ્ર' : 'HELP CENTER',
                      style: const TextStyle(
                        color: Color(0xFF9E814D),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      isGu
                          ? 'આજે અમે તમારી શું મદદ કરી શકીએ?'
                          : 'How can we help you today?',
                      style: const TextStyle(
                        color: Color(0xFF0F172A),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      isGu
                          ? 'ગુજરાતી સમુદાય જોડાયેલ અને સહાયિત રહે તે માટે અમે અહીં છીએ. વ્યક્તિગત સહાય માટે અમારા સંસાધનોનો ઉપયોગ કરો અથવા અમારી ટીમનો સંપર્ક કરો.'
                          : 'We are here to ensure the Gujarati community stays connected and supported. Access our resources or reach out to our team for personalized assistance.',
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 13.5,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 2. Call Support Card
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => _showCallSupportDialog(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFF1F5F9)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF4FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.phone_outlined,
                            color: Color(0xFF0F172A),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            isGu ? 'સપોર્ટ પર કૉલ કરો' : 'Call Support',
                            style: const TextStyle(
                              color: Color(0xFF0F172A),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: Color(0xFF0F172A),
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 3. Send Message To Admin Card
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const NewMessageScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFF1F5F9)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF4FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.chat_bubble_outline_rounded,
                            color: Color(0xFF0F172A),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            isGu
                                ? 'એડમિનને સંદેશ મોકલો'
                                : 'Send Message To\nAdmin',
                            style: const TextStyle(
                              color: Color(0xFF0F172A),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              height: 1.25,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: Color(0xFF0F172A),
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 4. Frequently Asked Questions Card
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F6FE),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isGu ? 'વારંવાર પૂછાતા પ્રશ્નો' : 'Frequently Asked\nQuestions',
                      style: const TextStyle(
                        color: Color(0xFF0F172A),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Serif',
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isGu
                          ? 'સામાન્ય વિષયો અને સમુદાય માર્ગદર્શિકાઓ જુઓ.'
                          : 'Browse common topics and community guides.',
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 13.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        onPressed: () => _showFaqBottomSheet(context),
                        child: Text(
                          isGu ? 'બ્રાઉઝ કરો' : 'Browse',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 5. Image Banner Card with Badge Overlay
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/support_handshake.png',
                      width: double.infinity,
                      height: 220,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 220,
                          color: const Color(0xFF1E293B),
                          child: const Center(
                            child: Icon(Icons.people, color: Colors.white54, size: 48),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 14,
                      left: 14,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.55),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFFD4AF37).withValues(alpha: 0.7),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 18,
                              height: 18,
                              decoration: const BoxDecoration(
                                color: Color(0xFFD4AF37),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.black,
                                size: 12,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              isGu ? '૧૦,૦૦૦+ સભ્યો દ્વારા વિશ્વાસપાત્ર' : 'Trusted by 10,000+ members',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Footer
              Center(
                child: Text(
                  'SWAJAN COMMUNITY SUPPORT V1.4.2',
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _FaqTile extends StatelessWidget {
  final String question;
  final String answer;

  const _FaqTile({
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0F172A),
          ),
        ),
        childrenPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        expandedAlignment: Alignment.centerLeft,
        children: [
          Text(
            answer,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
