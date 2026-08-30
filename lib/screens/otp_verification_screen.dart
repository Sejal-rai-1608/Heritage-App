import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'reset_password_screen.dart';
import 'home_screen.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final bool isForgotPassword;
  final String? expectedOtp;

  const OTPVerificationScreen({
    super.key,
    required this.phoneNumber,
    this.isForgotPassword = false,
    this.expectedOtp,
  });

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final Color primaryYellow = const Color(0xFFE5A93C);
  final Color darkYellow = const Color(0xFFC68A00);
  final Color primaryDark = const Color(0xFF191C21);

  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  int _resendTimer = 30;
  Timer? _timer;
  String? _currentExpectedOtp;

  @override
  void initState() {
    super.initState();
    _currentExpectedOtp = widget.expectedOtp;
    _startTimer();
  }

  void _startTimer() {
    _resendTimer = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer > 0) {
        setState(() {
          _resendTimer--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  void _resendNewOtp() {
    final newOtp = (1000 + Random().nextInt(9000)).toString();
    setState(() {
      _currentExpectedOtp = newOtp;
    });
    _startTimer();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.refresh, color: darkYellow, size: 24),
            const SizedBox(width: 8),
            const Text('New OTP Sent', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        content: Text('Your new verification OTP is: $newOtp'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('OK', style: TextStyle(color: darkYellow, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onVerifyOTP() {
    String enteredOtp = _otpControllers.map((c) => c.text).join();
    if (enteredOtp.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter 4-digit OTP'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    if (_currentExpectedOtp != null && enteredOtp != _currentExpectedOtp) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Incorrect OTP! Expected code is $_currentExpectedOtp'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // Success SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('OTP Verified Successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    if (widget.isForgotPassword) {
      // Redirect to Reset Password screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const ResetPasswordScreen(),
        ),
      );
    } else {
      // Redirect to Home screen
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 100,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Row(
            children: const [
              SizedBox(width: 16),
              Icon(Icons.arrow_back, color: Colors.black87, size: 20),
              SizedBox(width: 4),
              Text(
                'Back',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),

                // Lock Icon Header (Yellow Theme)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: primaryYellow,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: primaryYellow.withValues(alpha: 0.35),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.lock_outline,
                    color: Colors.black87,
                    size: 36,
                  ),
                ),
                const SizedBox(height: 28),

                // Title
                Text(
                  'Enter Verification Code',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: primaryDark,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Code sent to +91 ${widget.phoneNumber}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                if (_currentExpectedOtp != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8E7),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: primaryYellow, width: 1.5),
                    ),
                    child: Text(
                      'Demo Code: $_currentExpectedOtp',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: primaryDark,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 32),

                // 4 OTP Boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    bool isFocused = _focusNodes[index].hasFocus;
                    return Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isFocused ? primaryYellow : Colors.grey.shade300,
                          width: isFocused ? 2.2 : 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _otpControllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        decoration: const InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 3) {
                            _focusNodes[index + 1].requestFocus();
                          } else if (value.isEmpty && index > 0) {
                            _focusNodes[index - 1].requestFocus();
                          }
                          setState(() {});
                        },
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 36),

                // Verify OTP Button (Yellow Theme)
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _onVerifyOTP,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryYellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 1,
                      shadowColor: primaryYellow.withValues(alpha: 0.4),
                    ),
                    child: const Text(
                      'Verify & Continue',
                      style: TextStyle(
                        color: Color(0xFF191C21),
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // Request OTP again row with timer box
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: _resendTimer == 0 ? _resendNewOtp : null,
                      child: Row(
                        children: [
                          Icon(
                            Icons.refresh,
                            size: 18,
                            color: _resendTimer == 0 ? darkYellow : Colors.grey.shade600,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Resend OTP',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: _resendTimer == 0 ? darkYellow : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.access_time, size: 14, color: Colors.grey.shade700),
                          const SizedBox(width: 6),
                          Text(
                            '${_resendTimer}s',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
