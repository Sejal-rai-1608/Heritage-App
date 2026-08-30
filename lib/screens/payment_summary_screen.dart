import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
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
        title: const Text(
          'Payment Summary',
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
                      const Text(
                        'Membership\nSummary',
                        style: TextStyle(
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
                        child: const Text(
                          'Active\nSelection',
                          textAlign: TextAlign.center,
                          style: TextStyle(
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
                            const Text(
                              'PREMIUM PLAN',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.planTitle,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E232D),
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Access to all exclusive community features',
                              style: TextStyle(
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
                  const Text(
                    'Member Name',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.memberName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E232D),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Valid Until
                  const Text(
                    'Valid Until',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'October 24, 2025',
                    style: TextStyle(
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
                  const Text(
                    'Selected Payment Method',
                    style: TextStyle(
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
                                _currentPaymentMethod,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E232D),
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Google Pay / BHIM app etc.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showChangePaymentBottomSheet();
                          },
                          child: const Text(
                            'Change',
                            style: TextStyle(
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
                  const Text(
                    'Price Details',
                    style: TextStyle(
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
                      const Text(
                        'Base Subscription',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                      Text(
                        'Rs. ${baseAmount.round()}',
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
                      const Text(
                        'GST (18%)',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                      Text(
                        'Rs. ${gstAmount.round()}',
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
                      const Text(
                        'TOTAL AMOUNT',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                          color: Color(0xFFFDE089),
                        ),
                      ),
                      Text(
                        'Rs. ${widget.totalAmount}',
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
                      _showPaymentSuccessDialog();
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
                      children: const [
                        Text(
                          'COMPLETE PAYMENT',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, size: 18),
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
                      children: const [
                        Icon(
                          Icons.verified_user_outlined,
                          color: Color(0xFFFDE089),
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Secure Transaction via 256-bit SSL',
                          style: TextStyle(
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
                      children: const [
                        Text(
                          'Tax Exemption Notice',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E232D),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'All donations and membership fees are eligible for tax exemption under Section 80G of the Income Tax Act. A receipt will be sent to your registered email address.',
                          style: TextStyle(
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

  void _showChangePaymentBottomSheet() {
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
              const Text(
                'Select Payment Method',
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.account_balance_wallet_outlined),
                title: const Text('UPI Payment (GPay, PhonePe, BHIM)'),
                onTap: () {
                  setState(() => _currentPaymentMethod = 'UPI Payment');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.credit_card_outlined),
                title: const Text('Online Payment (Cards / Netbanking)'),
                onTap: () {
                  setState(() => _currentPaymentMethod = 'Online Payment');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.payments_outlined),
                title: const Text('Pay using Cash (In-person)'),
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

  void _showPaymentSuccessDialog() {
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
              const Text(
                'Payment Successful!',
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E232D),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Thank you! ${widget.memberName} is now upgraded to ${widget.planTitle}.',
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
                child: const Text('Back to Home', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }
}
