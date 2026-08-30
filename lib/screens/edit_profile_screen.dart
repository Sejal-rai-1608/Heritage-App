import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'image_picker_dialog.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _middleNameController;
  late TextEditingController _surnameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _birthDateController;
  late TextEditingController _nativePlaceController;
  late TextEditingController _cityController;
  late TextEditingController _areaController;
  late TextEditingController _pinCodeController;
  late TextEditingController _educationController;
  late TextEditingController _occupationController;
  late TextEditingController _incomeController;
  late TextEditingController _heightController;
  late TextEditingController _aboutController;

  String _selectedMaritalStatus = 'Single';
  String _selectedBloodGroup = 'O+';
  String? _selectedImagePath;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final lang = Provider.of<LanguageProvider>(context, listen: false);
      final details = lang.profileDetails;

      _firstNameController = TextEditingController(text: details['firstName'] ?? lang.registeredFirstName.ifEmpty('Soham'));
      _middleNameController = TextEditingController(text: details['middleName'] ?? 'Aaditya');
      _surnameController = TextEditingController(text: details['familySurname'] ?? 'More');
      _phoneController = TextEditingController(text: details['phone'] ?? '8010594617');
      _emailController = TextEditingController(text: details['email'] ?? 'soham.more@swajan.org');
      _birthDateController = TextEditingController(text: details['birthDate'] ?? lang.userBirthDate.ifEmpty('24 May 2005'));
      _nativePlaceController = TextEditingController(text: details['nativePlace'] ?? lang.userNativePlace.ifEmpty('Satara Road'));
      _cityController = TextEditingController(text: details['city'] ?? 'Thane');
      _areaController = TextEditingController(text: details['area'] ?? 'Nala Sopara East');
      _pinCodeController = TextEditingController(text: details['pinCode'] ?? '401209');
      _educationController = TextEditingController(text: details['education'] ?? 'B.E./B.Tech (Engineering)');
      _occupationController = TextEditingController(text: details['occupation'] ?? lang.userOccupation.ifEmpty('Student'));
      _incomeController = TextEditingController(text: details['annualIncome'] ?? '₹5-10 Lakhs');
      _heightController = TextEditingController(text: details['height'] ?? '5 ft 10 in');
      _aboutController = TextEditingController(text: details['aboutMe'] ?? '');

      _selectedMaritalStatus = details['maritalStatus'] ?? lang.userMaritalStatus;
      _selectedBloodGroup = details['bloodGroup'] ?? lang.userBloodGroup.ifEmpty('O+');
      _selectedImagePath = lang.profileImageUrl;

      _initialized = true;
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _surnameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    _nativePlaceController.dispose();
    _cityController.dispose();
    _areaController.dispose();
    _pinCodeController.dispose();
    _educationController.dispose();
    _occupationController.dispose();
    _incomeController.dispose();
    _heightController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    final lang = Provider.of<LanguageProvider>(context, listen: false);

    final Map<String, String> updatedMap = {
      'firstName': _firstNameController.text.trim(),
      'middleName': _middleNameController.text.trim(),
      'familySurname': _surnameController.text.trim(),
      'phone': _phoneController.text.trim(),
      'email': _emailController.text.trim(),
      'birthDate': _birthDateController.text.trim(),
      'nativePlace': _nativePlaceController.text.trim(),
      'city': _cityController.text.trim(),
      'area': _areaController.text.trim(),
      'pinCode': _pinCodeController.text.trim(),
      'education': _educationController.text.trim(),
      'occupation': _occupationController.text.trim(),
      'annualIncome': _incomeController.text.trim(),
      'height': _heightController.text.trim(),
      'maritalStatus': _selectedMaritalStatus,
      'bloodGroup': _selectedBloodGroup,
      'aboutMe': _aboutController.text.trim(),
    };

    if (_selectedImagePath != null && _selectedImagePath!.isNotEmpty) {
      updatedMap['profileImageUrl'] = _selectedImagePath!;
    }

    lang.updateFullProfileDetails(updatedMap);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          lang.currentLanguage == 'gu'
              ? 'પ્રોફાઇલ વિગતો સફળતાપૂર્વક સાચવવામાં આવી!'
              : 'Profile details updated successfully!',
        ),
        backgroundColor: const Color(0xFF161E2E),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final bool isGu = lang.currentLanguage == 'gu';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Color(0xFF161E2E)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isGu ? 'પ્રોફાઇલ સંપાદિત કરો' : 'Edit Profile',
          style: const TextStyle(
            fontFamily: 'Serif',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF161E2E),
          ),
        ),
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: Text(
              isGu ? 'સાચવો' : 'SAVE',
              style: const TextStyle(
                color: Color(0xFF856404),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Photo Picker Section
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFD9B854), width: 3),
                    ),
                    child: ClipOval(
                      child: _selectedImagePath != null && _selectedImagePath!.isNotEmpty
                          ? (_selectedImagePath!.startsWith('http')
                              ? Image.network(_selectedImagePath!, fit: BoxFit.cover)
                              : (File(_selectedImagePath!).existsSync()
                                  ? Image.file(File(_selectedImagePath!), fit: BoxFit.cover)
                                  : Image.asset(_selectedImagePath!, fit: BoxFit.cover)))
                          : Image.asset('assets/images/image1.jpeg', fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () async {
                        final result = await showDialog<String>(
                          context: context,
                          builder: (_) => const CustomImagePickerDialog(),
                        );
                        if (result != null && result.isNotEmpty) {
                          setState(() {
                            _selectedImagePath = result;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Color(0xFF161E2E),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Section 1: Basic Names
            _buildSectionTitle(isGu ? 'વ્યક્તિગત માહિતી' : 'Personal Details', isGu),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFieldLabel(isGu ? 'પ્રથમ નામ' : 'First Name', isGu),
                      _buildInputField(_firstNameController, isGu ? 'નામ' : 'First Name'),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFieldLabel(isGu ? 'પિતા/પતિનું નામ' : 'Middle Name', isGu),
                      _buildInputField(_middleNameController, isGu ? 'પિતાનું નામ' : 'Middle Name'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _buildFieldLabel(isGu ? 'અટક / સરનામું' : 'Family Surname', isGu),
            _buildInputField(_surnameController, isGu ? 'અટક' : 'Surname'),

            const SizedBox(height: 20),

            // Section 2: Contact Info
            _buildSectionTitle(isGu ? 'સંપર્ક માહિતી' : 'Contact Information', isGu),
            const SizedBox(height: 12),
            _buildFieldLabel(isGu ? 'મોબાઈલ નંબર' : 'Mobile Phone', isGu),
            _buildInputField(_phoneController, isGu ? 'મોબાઈલ' : 'Phone Number', keyboardType: TextInputType.phone),

            const SizedBox(height: 14),
            _buildFieldLabel(isGu ? 'ઈમેઈલ સરનામું' : 'Email Address', isGu),
            _buildInputField(_emailController, isGu ? 'ઈમેઈલ' : 'Email Address', keyboardType: TextInputType.emailAddress),

            const SizedBox(height: 20),

            // Section 3: Birth & Native Place
            _buildSectionTitle(isGu ? 'જન્મ અને વતન' : 'Birth & Native Place', isGu),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFieldLabel(isGu ? 'જન્મ તારીખ' : 'Date of Birth', isGu),
                      _buildInputField(_birthDateController, isGu ? 'તારીખ' : 'DOB'),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFieldLabel(isGu ? 'વતન' : 'Native Place', isGu),
                      _buildInputField(_nativePlaceController, isGu ? 'વતન' : 'Native Place'),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Section 4: Location & Address
            _buildSectionTitle(isGu ? 'સ્થાન અને સરનામું' : 'Location Details', isGu),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFieldLabel(isGu ? 'શહેર' : 'City', isGu),
                      _buildInputField(_cityController, isGu ? 'શહેર' : 'City'),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFieldLabel(isGu ? 'વિસ્તાર' : 'Area', isGu),
                      _buildInputField(_areaController, isGu ? 'વિસ્તાર' : 'Area'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _buildFieldLabel(isGu ? 'પિન કોડ' : 'Pin Code', isGu),
            _buildInputField(_pinCodeController, isGu ? 'પિન કોડ' : 'Pin Code', keyboardType: TextInputType.number),

            const SizedBox(height: 20),

            // Section 5: Education & Occupation
            _buildSectionTitle(isGu ? 'શિક્ષણ અને વ્યવસાય' : 'Education & Profession', isGu),
            const SizedBox(height: 12),
            _buildFieldLabel(isGu ? 'શિક્ષણ સ્તર' : 'Education Level', isGu),
            _buildInputField(_educationController, isGu ? 'શિક્ષણ' : 'Education'),

            const SizedBox(height: 14),
            _buildFieldLabel(isGu ? 'વ્યવસાય' : 'Occupation', isGu),
            _buildInputField(_occupationController, isGu ? 'વ્યવસાય' : 'Occupation'),

            const SizedBox(height: 14),
            _buildFieldLabel(isGu ? 'વાર્ષિક આવક' : 'Annual Income', isGu),
            _buildInputField(_incomeController, isGu ? 'આવક' : 'Annual Income'),

            const SizedBox(height: 20),

            // Section 6: Personal Attributes
            _buildSectionTitle(isGu ? 'અન્ય વિગતો' : 'Other Attributes', isGu),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFieldLabel(isGu ? 'ઊંચાઈ' : 'Height', isGu),
                      _buildInputField(_heightController, isGu ? 'ઊંચાઈ' : 'Height'),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFieldLabel(isGu ? 'બ્લડ ગ્રુપ' : 'Blood Group', isGu),
                      _buildInputField(TextEditingController(text: _selectedBloodGroup)..selection = TextSelection.collapsed(offset: _selectedBloodGroup.length), isGu ? 'બ્લડ ગ્રુપ' : 'Blood Group', onChanged: (v) => _selectedBloodGroup = v),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),
            _buildFieldLabel(isGu ? 'મારા વિશે' : 'About Me Bio', isGu),
            TextField(
              controller: _aboutController,
              maxLines: 3,
              style: const TextStyle(fontSize: 14, color: Color(0xFF161E2E)),
              decoration: InputDecoration(
                hintText: isGu ? 'તમારા વિશે સંક્ષિપ્તમાં લખો...' : 'Write brief bio about yourself...',
                hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
              ),
            ),

            const SizedBox(height: 30),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF161E2E),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: Text(
                  isGu ? 'સુધારાઓ સાચવો' : 'SAVE CHANGES',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isGu) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontFamily: 'Serif',
        color: Color(0xFF161E2E),
      ),
    );
  }

  Widget _buildFieldLabel(String label, bool isGu) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: Color(0xFF475569)),
      ),
    );
  }

  Widget _buildInputField(
    TextEditingController controller,
    String hint, {
    TextInputType keyboardType = TextInputType.text,
    ValueChanged<String>? onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: const TextStyle(fontSize: 14, color: Color(0xFF161E2E)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
      ),
    );
  }
}

extension StringExtension on String {
  String ifEmpty(String fallback) {
    return trim().isEmpty ? fallback : this;
  }
}
