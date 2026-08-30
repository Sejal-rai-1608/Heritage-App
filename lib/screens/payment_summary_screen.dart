import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'notifications_screen.dart';

class PaymentSummaryScreen extends StatefulWidget {
  final String memberName;
  final String planTitle;
  final int planMonths;
  final int totalAmount;
  final String paymentMethod;

  const PaymentSummaryScreen({
    super.key,
    this.memberName = 'Soham Aaditya More',
    this.planTitle = '12 Months Premium Membership',
    this.planMonths = 12,
    this.totalAmount = 3000,
    this.paymentMethod = 'UPI Payment',
  });

  @override
  State<PaymentSummaryScreen> createState() => _PaymentSummaryScreenState();
}

class _PaymentSummaryScreenState extends State<PaymentSummaryScreen> {
  String _currentPaymentMethod = 'UPI Payment';

  @override
  void initState() {
    super.initState();
    _currentPaymentMethod = widget.paymentMethod;
  }

  String _getMemberName(String name, bool isGu) {
    if (!isGu) return name;
    if (name.contains('Soham')) {
      return 'સોહમ આદિત્ય મોરે';
    } else if (name.contains('Riya')) {
      return 'રિયા આદિત્ય મોરે';
    }
    return name;
  }

  String _getPlanTitle(String title, bool isGu) {
    if (!isGu) return title;
    if (title.contains('6')) {
      return '૬ મહિનાની પ્રીમિયમ સભ્યપદ';
    }
    return '૧૨ મહિનાની પ્રીમિયમ સભ્યપદ';
  }

  String _getPaymentMethodTitle(String method, bool isGu) {
    if (!isGu) return method;
    if (method.contains('UPI')) return 'UPI ચુકવણી';
    if (method.contains('Online')) return 'ઓનલાઇન ચુકવણી';
    return 'રોકડ દ્વારા ચુકવણી';
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final bool isGu = lang.currentLanguage == 'gu';

    final double gstAmount = widget.totalAmount * 0.15266; // Approx 18% GST calculation
    final double baseAmount = widget.totalAmount - gstAmount;

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
        title: Text(
          isGu ? 'ચુકવણીનો સારાંશ' : 'Payment Summary',
          style: const TextStyle(
            fontFamily: 'Serif',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E232D),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const NotificationsScreen(),
                ),
              );
            },
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
              color: const Color(0xFFFDE089),
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
            child: const Icon(Icons.person, color: Color(0xFF1E232D), size: 20),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // 1. Membership Summary Card
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
                  // Title Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isGu ? 'સભ્યપદનો\nસારાંશ' : 'Membership\nSummary',
                        style: const TextStyle(
                          fontFamily: 'Serif',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E232D),
                          height: 1.2,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF8DF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          isGu ? 'સક્રિય\nપસંદગી' : 'Active\nSelection',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8B6B1B),
                            height: 1.1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Plan Graphic & Info Row
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: 56,
                          height: 56,
                          color: const Color(0xFF131B2E),
                          child: const Icon(
                            Icons.auto_awesome,
                            color: Color(0xFFFDE089),
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isGu ? 'પ્રીમિયમ પ્લાન' : 'PREMIUM PLAN',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _getPlanTitle(widget.planTitle, isGu),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E232D),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              isGu ? 'તમામ વિશિષ્ટ સમુદાય સુવિધાઓની ઍક્સેસ' : 'Access to all exclusive community features',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Member Name
                  Text(
                    isGu ? 'સભ્યનું નામ' : 'Member Name',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _getMemberName(widget.memberName, isGu),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E232D),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Valid Until
                  Text(
                    isGu ? 'સુધી માન્ય' : 'Valid Until',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isGu ? '૨૪ ઓક્ટોબર, ૨૦૨૫' : 'October 24, 2025',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E232D),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 2. Selected Payment Method Card
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
                  Text(
                    isGu ? 'પસંદ કરેલ ચુકવણી પદ્ધતિ' : 'Selected Payment Method',
                    style: const TextStyle(
                      fontFamily: 'Serif',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E232D),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Inner box
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFBF0),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFFDE089)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F0FE),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.account_balance_wallet_outlined,
                            color: Color(0xFF1E232D),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getPaymentMethodTitle(_currentPaymentMethod, isGu),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E232D),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                isGu ? 'ગુગલ પે / ભીમ એપ વગેરે' : 'Google Pay / BHIM app etc.',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showChangePaymentBottomSheet(isGu);
                          },
                          child: Text(
                            isGu ? 'બદલો' : 'Change',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8B6B1B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 3. Price Details (Dark Navy Card)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: const Color(0xFF131B2E),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isGu ? 'કિંમતની વિગતો' : 'Price Details',
                    style: const TextStyle(
                      fontFamily: 'Serif',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFDE089),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Base Subscription
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isGu ? 'મૂળ સબસ્ક્રિપ્શન' : 'Base Subscription',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                      Text(
                        isGu ? 'રૂ. ${baseAmount.round()}' : 'Rs. ${baseAmount.round()}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // GST
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isGu ? 'જીએસટી (૧૮%)' : 'GST (18%)',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                      Text(
                        isGu ? 'રૂ. ${gstAmount.round()}' : 'Rs. ${gstAmount.round()}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Total Amount Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isGu ? 'કુલ રકમ' : 'TOTAL AMOUNT',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                          color: Color(0xFFFDE089),
                        ),
                      ),
                      Text(
                        isGu ? 'રૂ. ${widget.totalAmount}' : 'Rs. ${widget.totalAmount}',
                        style: const TextStyle(
                          fontFamily: 'Serif',
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFDE089),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Complete Payment Button
                  ElevatedButton(
                    onPressed: () {
                      _showPaymentSuccessDialog(isGu);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFDE089),
                      foregroundColor: const Color(0xFF1E232D),
                      minimumSize: const Size(double.infinity, 52),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isGu ? 'ચુકવણી પૂર્ણ કરો' : 'COMPLETE PAYMENT',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward, size: 18),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Lock security badge
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.verified_user_outlined,
                          color: Color(0xFFFDE089),
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isGu ? '૨૫૬-બીટ SSL દ્વારા સુરક્ષિત વ્યવહાર' : 'Secure Transaction via 256-bit SSL',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 4. Tax Exemption Notice Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFBFDBFE)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Color(0xFF1D4ED8),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isGu ? 'કર મુક્તિ સૂચના' : 'Tax Exemption Notice',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E232D),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isGu ? 'તમામ દાન અને સભ્યપદ ફી આવકવેરા કાયદાની કલમ 80G હેઠળ કરમુક્તિ માટે પાત્ર છે. રસીદ તમારા રજિસ્ટર્ડ ઈમેઈલ સરનામે મોકલવામાં આવશે.' : 'All donations and membership fees are eligible for tax exemption under Section 80G of the Income Tax Act. A receipt will be sent to your registered email address.',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF475569),
                            height: 1.4,
                          ),
                        ),
                      ],
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

  void _showChangePaymentBottomSheet(bool isGu) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isGu ? 'ચુકવણી પદ્ધતિ પસંદ કરો' : 'Select Payment Method',
                style: const TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.account_balance_wallet_outlined),
                title: Text(isGu ? 'UPI ચુકવણી (GPay, PhonePe, BHIM)' : 'UPI Payment (GPay, PhonePe, BHIM)'),
                onTap: () {
                  setState(() => _currentPaymentMethod = 'UPI Payment');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.credit_card_outlined),
                title: Text(isGu ? 'ઓનલાઇન ચુકવણી (કાર્ડ્સ / નેટબેંકિંગ)' : 'Online Payment (Cards / Netbanking)'),
                onTap: () {
                  setState(() => _currentPaymentMethod = 'Online Payment');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.payments_outlined),
                title: Text(isGu ? 'રોકડ દ્વારા ચુકવણી (રૂબરૂ)' : 'Pay using Cash (In-person)'),
                onTap: () {
                  setState(() => _currentPaymentMethod = 'Cash Payment');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPaymentSuccessDialog(bool isGu) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Color(0xFFECFDF5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_rounded, color: Color(0xFF059669), size: 40),
              ),
              const SizedBox(height: 16),
              Text(
                isGu ? 'ચુકવણી સફળ રહી!' : 'Payment Successful!',
                style: const TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E232D),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isGu ? 'આભાર! ${_getMemberName(widget.memberName, isGu)} હવે ${_getPlanTitle(widget.planTitle, isGu)} માં અપગ્રેડ થયા છે.' : 'Thank you! ${widget.memberName} is now upgraded to ${widget.planTitle}.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Color(0xFF5E6573)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF131B2E),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  minimumSize: const Size(double.infinity, 44),
                ),
                child: Text(isGu ? 'મુખ્ય પૃષ્ઠ પર પાછા જાઓ' : 'Back to Home', style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }
}
