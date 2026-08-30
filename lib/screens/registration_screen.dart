import 'package:flutter/material.dart';
import 'otp_verification_screen.dart';
import 'detailed_registration_screen.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final Color primaryNavy = const Color(0xFF00005C);
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _onContinueMobile() {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty || phone.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 10-digit mobile number')),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => OTPVerificationScreen(phoneNumber: phone),
      ),
    );
  }

  void _onGoogleSignIn() {
    // Simulated Google Sign In -> direct to profile setup
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const DetailedRegistrationScreen(isGoogleSignIn: true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header Icon
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: primaryNavy,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.person_add_alt_1,
                  color: Colors.white,
                  size: 36,
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E232D),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Register with your mobile number or Google account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 32),

              // Form Container
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Mobile Number',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color(0xFF1E232D),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixText: '+91  ',
                        prefixStyle: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        hintText: 'Enter 10-digit mobile number',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Continue with Mobile Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _onContinueMobile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryNavy,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Get OTP & Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Divider with OR
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'OR',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Google Sign-In Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton.icon(
                        onPressed: _onGoogleSignIn,
                        icon: Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg',
                          height: 20,
                          width: 20,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.g_mobiledata, color: Colors.red, size: 28),
                        ),
                        label: const Text(
                          'Continue with Google',
                          style: TextStyle(
                            color: Color(0xFF1E232D),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade300, width: 1.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Already have an account? Login here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: Text(
                      'Login here',
                      style: TextStyle(
                        color: primaryNavy,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
