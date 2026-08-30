import 'package:flutter/material.dart';
import 'payment_summary_screen.dart';

class BecomePremiumScreen extends StatefulWidget {
  final String? userName;

  const BecomePremiumScreen({super.key, this.userName});

  @override
  State<BecomePremiumScreen> createState() => _BecomePremiumScreenState();
}

class _BecomePremiumScreenState extends State<BecomePremiumScreen> {
  // Member selection
  String _selectedMemberId = '1';

  // Plan selection (6 vs 12 months)
  int _selectedPlanMonths = 6;

  // Purchase type (Personal vs Business)
  String _purchaseType = 'Personal';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),

      // App Bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E232D)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Become Premium Member',
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E232D),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_outlined,
              color: Color(0xFF2D3139),
              size: 24,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 16),
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300, width: 1),
              image: const DecorationImage(
                image: AssetImage('assets/images/sanjay_profile.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // 1. Title: Select Community Members
            const Text(
              'Select Community\nMembers',
              style: TextStyle(
                fontFamily: 'Serif',
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E232D),
                height: 1.2,
              ),
            ),
            const SizedBox(height: 20),

            // Member 1 Card
            _buildMemberCard(
              id: '1',
              name: 'Soham Aaditya More',
              status: 'Active Member',
              imagePath: 'assets/images/sanjay_profile.png',
              isAsset: true,
            ),
            const SizedBox(height: 16),

            // Member 2 Card
            _buildMemberCard(
              id: '2',
              name: 'Riya Aaditya More',
              status: 'Active Member',
              imagePath: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=800',
              isAsset: false,
            ),
            const SizedBox(height: 28),

            // 2. Membership Plan Selection Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Membership Plan Selection',
                    style: TextStyle(
                      fontFamily: 'Serif',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E232D),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Plan Option 1: 6 Months
                  _buildPlanOption(
                    months: 6,
                    title: '6 Months Premium Membership',
                    subtitle: 'Limited Access +\nPriority Networking',
                    price: 'Rs. 2000',
                  ),
                  const SizedBox(height: 14),

                  // Plan Option 2: 12 Months
                  _buildPlanOption(
                    months: 12,
                    title: '12 Months Premium Membership',
                    subtitle: 'All Access +\nConcierge Support',
                    price: 'Rs. 3000',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 3. Purchase Type Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'PURCHASE TYPE',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      _buildRadioOption('Personal', 'Personal Purchase'),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      _buildRadioOption('Business', 'Business Purchase'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 4. Choose Payment Method (Dark Navy Card)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF131B2E),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CHOOSE PAYMENT METHOD',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // UPI Payment Option
                  _buildPaymentTile(
                    icon: Icons.account_balance_wallet_outlined,
                    title: 'UPI Payment',
                    subtitle: 'Google Pay / BHIM etc.',
                    actionWidget: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDE089),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Pay',
                        style: TextStyle(
                          color: Color(0xFF1E232D),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    onTap: () => _handlePayment('UPI'),
                  ),
                  const SizedBox(height: 14),

                  // Online Payment Option
                  _buildPaymentTile(
                    icon: Icons.credit_card_outlined,
                    title: 'Online Payment',
                    subtitle: 'Card, Wallet, Netbanking',
                    actionWidget: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF374151),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Pay Online',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    onTap: () => _handlePayment('Online'),
                  ),
                  const SizedBox(height: 14),

                  // Pay Using Cash Option
                  _buildPaymentTile(
                    icon: Icons.payments_outlined,
                    title: 'Pay using Cash',
                    subtitle: 'In-person Collection',
                    actionWidget: const Text(
                      'Contact Us',
                      style: TextStyle(
                        color: Color(0xFFFDE089),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    onTap: () => _handlePayment('Cash'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 5. Notice Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBF0),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFDE089).withValues(alpha: 0.6)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(
                    Icons.info_outline,
                    color: Color(0xFF8B6B1B),
                    size: 20,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Upgrading to premium grants you access to exclusive networking events and historical archives for the Heritage Luxe community.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF8B6B1B),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // Member Card Helper
  Widget _buildMemberCard({
    required String id,
    required String name,
    required String status,
    required String imagePath,
    required bool isAsset,
  }) {
    final isSelected = _selectedMemberId == id;
    return GestureDetector(
      onTap: () => setState(() => _selectedMemberId = id),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFFFDE089) : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: isAsset
                  ? Image.asset(
                      imagePath,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => Container(
                        width: 56,
                        height: 56,
                        color: Colors.grey[300],
                        child: const Icon(Icons.person, color: Colors.grey),
                      ),
                    )
                  : Image.network(
                      imagePath,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => Container(
                        width: 56,
                        height: 56,
                        color: Colors.grey[300],
                        child: const Icon(Icons.person, color: Colors.grey),
                      ),
                    ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: 'Serif',
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E232D),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    status,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF5E6573),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PaymentSummaryScreen(
                      memberName: name,
                      planTitle: '$_selectedPlanMonths Months Premium Membership',
                      planMonths: _selectedPlanMonths,
                      totalAmount: _selectedPlanMonths == 6 ? 2000 : 3000,
                      paymentMethod: 'UPI Payment',
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDE089),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Text(
                  'Become\nPremium\nMember',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF1E232D),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Membership Plan Option
  Widget _buildPlanOption({
    required int months,
    required String title,
    required String subtitle,
    required String price,
  }) {
    final isSelected = _selectedPlanMonths == months;
    return GestureDetector(
      onTap: () => setState(() => _selectedPlanMonths = months),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF8B6B1B) : const Color(0xFFE5E7EB),
            width: isSelected ? 1.8 : 1.0,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Icon(
                isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: isSelected ? const Color(0xFF8B6B1B) : const Color(0xFF9CA3AF),
                size: 22,
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
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E232D),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF5E6573),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              price,
              style: const TextStyle(
                fontFamily: 'Serif',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8B6B1B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Purchase Type Radio Helper
  Widget _buildRadioOption(String value, String label) {
    final isSelected = _purchaseType == value;
    return GestureDetector(
      onTap: () => setState(() => _purchaseType = value),
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: isSelected ? const Color(0xFF8B6B1B) : const Color(0xFF9CA3AF),
            size: 22,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1E232D),
            ),
          ),
        ],
      ),
    );
  }

  // Payment Option Card Helper
  Widget _buildPaymentTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget actionWidget,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF334155)),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFFFDE089), size: 24),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ),
            actionWidget,
          ],
        ),
      ),
    );
  }

  void _handlePayment(String method) {
    final String selectedMemberName = _selectedMemberId == '1' ? 'Soham Aaditya More' : 'Riya Aaditya More';
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PaymentSummaryScreen(
          memberName: selectedMemberName,
          planTitle: '$_selectedPlanMonths Months Premium Membership',
          planMonths: _selectedPlanMonths,
          totalAmount: _selectedPlanMonths == 6 ? 2000 : 3000,
          paymentMethod: '$method Payment',
        ),
      ),
    );
  }
}
