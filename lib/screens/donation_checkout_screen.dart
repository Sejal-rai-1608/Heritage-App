import 'package:flutter/material.dart';
import 'home_screen.dart';

class DonationCheckoutScreen extends StatefulWidget {
  final String? userName;
  final String causeTitle;
  final String imagePath;
  final String defaultAmount;

  const DonationCheckoutScreen({
    super.key,
    this.userName,
    this.causeTitle = 'ગામડાની પ્રાથમિક શાળાનું નવીનીકરણ',
    this.imagePath = 'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=800&auto=format&fit=crop&q=80',
    this.defaultAmount = '1000',
  });

  @override
  State<DonationCheckoutScreen> createState() => _DonationCheckoutScreenState();
}

class _DonationCheckoutScreenState extends State<DonationCheckoutScreen> {
  late String _selectedAmount;
  final _customAmountController = TextEditingController();
  bool _isAnonymous = false;
  String _selectedPaymentMethod = 'upi'; // 'upi', 'card', 'netbanking'

  final List<Map<String, String>> _amountOptions = [
    {'title': 'નાની ભેટ', 'amount': '500'},
    {'title': 'અસરકારક', 'amount': '1000'},
    {'title': 'ઉદાર', 'amount': '2000'},
    {'title': 'સંરક્ષક', 'amount': '5000'},
  ];

  @override
  void initState() {
    super.initState();
    _selectedAmount = widget.defaultAmount;
  }

  String get _finalAmountFormatted {
    final raw = _customAmountController.text.trim().isNotEmpty
        ? _customAmountController.text.trim()
        : _selectedAmount;
    final parsed = double.tryParse(raw) ?? 1000;
    return parsed.toStringAsFixed(2);
  }

  void _handleConfirmDonation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: Color(0xFFDCFCE7),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_rounded,
                    color: Color(0xFF16A34A),
                    size: 40,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'દાનની પુષ્ટિ થઈ!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Serif',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E232D),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  ' "${widget.causeTitle}" માટે ₹$_finalAmountFormatted ના તમારા ઉદાર યોગદાન બદલ આભાર. ${_isAnonymous ? "તમારું દાન અનામી રીતે નોંધાયેલ છે." : "તમારો સપોર્ટ એક વાસ્તવિક તફાવત બનાવે છે!"}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (_) => HomeScreen(userName: widget.userName),
                        ),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F172A),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      'હોમ પેજ પર પાછા જાઓ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HERO CAUSE BANNER
            Container(
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
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                        child: Image.network(
                          widget.imagePath,
                          height: 190,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFDE047),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'ઇમ્પેક્ટ પ્રોજેક્ટ',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E232D),
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.causeTitle,
                          style: const TextStyle(
                            fontFamily: 'Serif',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E232D),
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'આપણા સમુદાયના ભવિષ્યના હૃદયને પુનર્જીવિત કરી રહ્યા છીએ. આ પહેલ માળખાકીય મજબૂતીકરણ, ડિજિટલ સાધનો સાથે વર્ગખંડોના આધુનિકીકરણ અને ૪૫૦ વંચિત બાળકો માટે શિક્ષણ વાતાવરણ ઊભું કરવા પર ધ્યાન કેન્દ્રિત કરે છે.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF64748B),
                            height: 1.45,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('ભંડોળ પૂરું પડાએલ', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF64748B))),
                            Text('લક્ષ્ય', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF64748B))),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              '₹૭,૪૨,૦૦૦',
                              style: TextStyle(fontFamily: 'Serif', fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E232D)),
                            ),
                            Text(
                              '₹૧૨,૦૦,૦૦૦',
                              style: TextStyle(fontFamily: 'Serif', fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF64748B)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: const LinearProgressIndicator(
                            value: 0.62,
                            minHeight: 8,
                            backgroundColor: Color(0xFFE2E8F0),
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF856404)),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('૬૨% હાંસલ કરેલ', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF856404))),
                            Text('૧૪ દિવસ બાકી', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF64748B))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // CARD 1: SELECT DONATION AMOUNT
            Container(
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
                    'દાનની રકમ પસંદ કરો',
                    style: TextStyle(
                      fontFamily: 'Serif',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E232D),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 2x2 Grid of Amount Cards
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2.2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: _amountOptions.length,
                    itemBuilder: (ctx, idx) {
                      final item = _amountOptions[idx];
                      final isSelected = _selectedAmount == item['amount'] && _customAmountController.text.isEmpty;

                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedAmount = item['amount']!;
                            _customAmountController.clear();
                          });
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFFFFF9E6) : const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected ? const Color(0xFF856404) : const Color(0xFFE2E8F0),
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item['title']!,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? const Color(0xFF856404) : const Color(0xFF64748B),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '₹${item['amount']}',
                                style: const TextStyle(
                                  fontFamily: 'Serif',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E232D),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 18),

                  // Label: CUSTOM AMOUNT
                  const Text(
                    'અન્ય રકમ',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF64748B),
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Soft Blue Custom Amount TextField with ₹
                  TextField(
                    controller: _customAmountController,
                    keyboardType: TextInputType.number,
                    onChanged: (val) => setState(() {}),
                    decoration: InputDecoration(
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 16, right: 8, top: 12, bottom: 12),
                        child: Text(
                          '₹',
                          style: TextStyle(
                            fontFamily: 'Serif',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E232D),
                          ),
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                      hintText: 'અન્ય રકમ દાખલ કરો',
                      hintStyle: const TextStyle(
                        fontFamily: 'Serif',
                        color: Color(0xFF94A3B8),
                        fontSize: 16,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFEFF6FF),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // DONATE ANONYMOUSLY TOGGLE CARD
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFF1F5F9)),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.visibility_off_outlined,
                          color: Color(0xFF856404),
                          size: 22,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'અનામી દાન કરો',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E232D),
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'જાહેર દાન આપનારની યાદીમાંથી તમારું નામ છુપાવો',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: _isAnonymous,
                          activeThumbColor: const Color(0xFF856404),
                          activeTrackColor: const Color(0xFFFEF08A),
                          onChanged: (val) => setState(() => _isAnonymous = val),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // CARD 2: PAYMENT METHOD
            Container(
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
                    'ચુકવણી પદ્ધતિ',
                    style: TextStyle(
                      fontFamily: 'Serif',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E232D),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Option 1: UPI Payments
                  _buildPaymentOptionTile(
                    id: 'upi',
                    icon: Icons.account_balance_wallet_outlined,
                    title: 'UPI ચુકવણીઓ',
                    subtitle: 'Google Pay, PhonePe, Paytm',
                  ),
                  const SizedBox(height: 12),

                  // Option 2: Credit / Debit Card
                  _buildPaymentOptionTile(
                    id: 'card',
                    icon: Icons.credit_card_outlined,
                    title: 'ક્રેડિટ / ડેબિટ કાર્ડ',
                    subtitle: 'Visa, Mastercard, Amex',
                  ),
                  const SizedBox(height: 12),

                  // Option 3: Net Banking
                  _buildPaymentOptionTile(
                    id: 'netbanking',
                    icon: Icons.account_balance_outlined,
                    title: 'નેટ બેંકિંગ',
                    subtitle: 'બધી મુખ્ય ભારતીય બેંકો',
                  ),
                  const SizedBox(height: 24),

                  const Divider(color: Color(0xFFF1F5F9), thickness: 1),
                  const SizedBox(height: 16),

                  // Summary Breakdown
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('દાનની રકમ', style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
                      Text('₹$_finalAmountFormatted', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1E232D))),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('પ્રોસેસિંગ ફી', style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
                      Text(
                        'હેરિટેજ ફાઉન્ડેશન દ્વારા આવરી લેવાયેલ',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF856404)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'કુલ ચૂકવવાપાત્ર રકમ',
                        style: TextStyle(
                          fontFamily: 'Serif',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E232D),
                        ),
                      ),
                      Text(
                        '₹$_finalAmountFormatted',
                        style: const TextStyle(
                          fontFamily: 'Serif',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E232D),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Confirm Donation Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _handleConfirmDonation,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFDE047),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'દાનની પુષ્ટિ કરો',
                            style: TextStyle(
                              color: Color(0xFF1E232D),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, color: Color(0xFF1E232D), size: 18),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  const Center(
                    child: Text(
                      'પુષ્ટિ કરીને, તમે અમારી સેવા ક્ષમતાની શરતો સાથે સંમત થાઓ છો. તમારું\nદાન કલમ 80G હેઠળ કરમુક્ત છે.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF94A3B8),
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOptionTile({
    required String id,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final isSelected = _selectedPaymentMethod == id;

    return InkWell(
      onTap: () => setState(() => _selectedPaymentMethod = id),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF9E6) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF856404) : const Color(0xFFE2E8F0),
            width: isSelected ? 1.8 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Icon(icon, color: const Color(0xFF64748B), size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E232D),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF856404) : const Color(0xFFCBD5E1),
                  width: isSelected ? 6 : 1.5,
                ),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
