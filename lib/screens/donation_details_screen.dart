import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class DonationDetailsScreen extends StatefulWidget {
  final String title;
  final String description;
  final double raised;
  final double goal;
  final String? imageAsset;

  const DonationDetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.raised,
    required this.goal,
    this.imageAsset,
  });

  @override
  State<DonationDetailsScreen> createState() => _DonationDetailsScreenState();
}

class _DonationDetailsScreenState extends State<DonationDetailsScreen> {
  static const Color primaryNavy = Color(0xFF00005C);
  static const Color accentGold = Color(0xFFE67E22);
  static const Color progressColor = Color(0xFF000080); // Darker blue for details progress bar in mockup

  final TextEditingController _amountController = TextEditingController();
  final List<int> _predefinedAmounts = [500, 1000, 2000, 5000];
  int? _selectedPredefinedIndex;
  bool _donateAnonymously = false;
  String _selectedPaymentMethod = 'upi'; // 'upi', 'card', 'netbanking'

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _selectAmount(int index, int amount) {
    setState(() {
      _selectedPredefinedIndex = index;
      _amountController.text = amount.toString();
    });
  }

  void _onAmountChanged(String val) {
    if (val.isEmpty) {
      setState(() {
        _selectedPredefinedIndex = null;
      });
      return;
    }
    final parsed = int.tryParse(val);
    if (parsed != null && _predefinedAmounts.contains(parsed)) {
      setState(() {
        _selectedPredefinedIndex = _predefinedAmounts.indexOf(parsed);
      });
    } else {
      setState(() {
        _selectedPredefinedIndex = null;
      });
    }
  }

  void _showSuccessDialog(LanguageProvider lang, double amountVal) {
    final String amountFormatted = amountVal.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
    final txnId = 'TXN${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green.shade700,
                    size: 52,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Donation Successful!',
                  style: TextStyle(
                    color: primaryNavy,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Thank you for your generous contribution.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(height: 1),
                const SizedBox(height: 16),
                _buildReceiptRow('Campaign:', widget.title),
                const SizedBox(height: 8),
                _buildReceiptRow('Amount Paid:', '₹ $amountFormatted'),
                const SizedBox(height: 8),
                _buildReceiptRow('Transaction ID:', txnId),
                const SizedBox(height: 8),
                _buildReceiptRow(
                  'Identity:',
                  _donateAnonymously ? 'Anonymous' : (lang.registeredName.isNotEmpty ? lang.registeredName : 'Sanjay Patel'),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // dismiss dialog
                      Navigator.of(context).pop(); // go back to list
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryNavy,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Back to Support',
                      style: TextStyle(fontWeight: FontWeight.bold),
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

  Widget _buildReceiptRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: primaryNavy,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);

    // Format numbers
    final String raisedFormatted = widget.raised.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
    final String goalFormatted = widget.goal.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
    final double percentage = (widget.raised / widget.goal * 100).clamp(0, 100);

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
          lang.getText('donation_details'),
          style: const TextStyle(
            color: primaryNavy,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image (large image representation)
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[100],
              child: widget.imageAsset != null
                  ? Image.asset(
                      widget.imageAsset!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Center(
                        child: Icon(Icons.apartment, color: primaryNavy, size: 64),
                      ),
                    )
                  : const Center(
                      child: Icon(Icons.volunteer_activism, color: primaryNavy, size: 64),
                    ),
            ),

            // Content Panel
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: primaryNavy,
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Description
                  Text(
                    widget.description,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Progress
                  Text(
                    lang.getText('progress') != 'progress' ? lang.getText('progress') : 'Progress',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹$raisedFormatted of ₹$goalFormatted',
                        style: const TextStyle(
                          color: primaryNavy,
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '${percentage.toStringAsFixed(0)}%',
                        style: const TextStyle(
                          color: accentGold,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: widget.raised / widget.goal,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: const AlwaysStoppedAnimation<Color>(progressColor),
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Predefined amount selection
                  Text(
                    lang.getText('select_donation_amount'),
                    style: const TextStyle(
                      color: primaryNavy,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2.8,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: _predefinedAmounts.length,
                    itemBuilder: (context, index) {
                      final amount = _predefinedAmounts[index];
                      final isSelected = _selectedPredefinedIndex == index;
                      return OutlinedButton(
                        onPressed: () => _selectAmount(index, amount),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: isSelected ? Colors.white : primaryNavy,
                          backgroundColor: isSelected ? primaryNavy : Colors.white,
                          side: BorderSide(
                            color: isSelected ? primaryNavy : Colors.grey.shade300,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          '₹$amount',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Custom Amount Textfield
                  Text(
                    lang.getText('custom_amount'),
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      onChanged: _onAmountChanged,
                      decoration: const InputDecoration(
                        icon: Text(
                          '₹',
                          style: TextStyle(
                            color: primaryNavy,
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),
                        hintText: 'Enter amount',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        color: primaryNavy,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Donate Anonymously Card
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: const Icon(
                            Icons.visibility_off_outlined,
                            color: primaryNavy,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lang.getText('donate_anonymously'),
                                style: const TextStyle(
                                  color: primaryNavy,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13.5,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                lang.getText('donate_anonymously_desc'),
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: _donateAnonymously,
                          activeThumbColor: primaryNavy,
                          onChanged: (val) {
                            setState(() {
                              _donateAnonymously = val;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Payment Methods
                  Text(
                    lang.getText('payment_method'),
                    style: const TextStyle(
                      color: primaryNavy,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Payment option 1: UPI
                  _buildPaymentMethodTile(
                    id: 'upi',
                    title: lang.getText('upi_gpay'),
                    subtitle: lang.getText('upi_gpay_desc'),
                    icon: Icons.account_balance_wallet_outlined,
                  ),
                  const SizedBox(height: 8),
                  // Payment option 2: Card
                  _buildPaymentMethodTile(
                    id: 'card',
                    title: lang.getText('card'),
                    subtitle: lang.getText('card_desc'),
                    icon: Icons.credit_card_outlined,
                  ),
                  const SizedBox(height: 8),
                  // Payment option 3: Net Banking
                  _buildPaymentMethodTile(
                    id: 'netbanking',
                    title: lang.getText('net_banking'),
                    subtitle: lang.getText('net_banking_desc'),
                    icon: Icons.account_balance_outlined,
                  ),
                  const SizedBox(height: 32),

                  // Confirm Donation Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        final val = double.tryParse(_amountController.text);
                        if (val == null || val <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter a valid donation amount'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        _showSuccessDialog(lang, val);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryNavy,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            lang.getText('confirm_donation'),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.chevron_right, size: 18),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodTile({
    required String id,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final isSelected = _selectedPaymentMethod == id;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = id;
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF0F2FF) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? primaryNavy : Colors.grey.shade200,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Icon(
                icon,
                color: isSelected ? primaryNavy : Colors.grey.shade600,
                size: 20,
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
                      fontWeight: FontWeight.bold,
                      fontSize: 13.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            Radio<String>(
              value: id,
              groupValue: _selectedPaymentMethod,
              activeColor: primaryNavy,
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _selectedPaymentMethod = val;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
