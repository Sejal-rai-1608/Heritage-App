import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'membership_request_screen.dart';

class RegistrationFormScreen extends StatefulWidget {
  const RegistrationFormScreen({super.key});

  @override
  State<RegistrationFormScreen> createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final lang = Provider.of<LanguageProvider>(context, listen: false);
      final details = lang.profileDetails;
      if (details.isNotEmpty) {
        setState(() {
          if (details['firstName'] != null) _firstNameController.text = details['firstName']!;
          if (details['familySurname'] != null) _familySurnameController.text = details['familySurname']!;
          if (details['officialSurname'] != null) _officialSurnameController.text = details['officialSurname']!;
          if (details['gender'] != null) _selectedGender = details['gender']!;
          if (details['maritalStatus'] != null) _maritalStatus = details['maritalStatus']!;
          if (details['bloodGroup'] != null) _selectedBloodGroup = details['bloodGroup']!;
          if (details['nativePlace'] != null) _nativePlaceController.text = details['nativePlace']!;
          if (details['birthDate'] != null) _birthDateController.text = details['birthDate']!;
          if (details['occupation'] != null) _selectedOccupation = details['occupation']!;
          if (details['spouseName'] != null) _spouseNameController.text = details['spouseName']!;
          if (details['childrenNames'] != null) _childrenNamesController.text = details['childrenNames']!;
          if (details['country'] != null) _selectedCountry = details['country']!;
          if (details['state'] != null) _selectedState = details['state']!;
          if (details['district'] != null) _selectedDistrict = details['district']!;
          if (details['area'] != null) _selectedArea = details['area']!;
          if (details['fatherName'] != null) _fatherNameController.text = details['fatherName']!;
          if (details['motherName'] != null) _motherNameController.text = details['motherName']!;
          if (details['fathersFatherName'] != null) _fathersFatherNameController.text = details['fathersFatherName']!;
          if (details['fathersMotherName'] != null) _fathersMotherNameController.text = details['fathersMotherName']!;
          if (details['mothersFatherName'] != null) _mothersFatherNameController.text = details['mothersFatherName']!;
          if (details['mothersMotherName'] != null) _mothersMotherNameController.text = details['mothersMotherName']!;
          if (details['mothersFatherSurname'] != null) _mothersFatherSurnameController.text = details['mothersFatherSurname']!;
          if (details['mothersFatherVillage'] != null) _mothersFatherVillageController.text = details['mothersFatherVillage']!;
        });
      }
    });
  }
  int _currentStep = 1; // 1: Gender & Marital, 2: Basic Details, 3: Parent Details

  // Step 1 state
  String _selectedGender = 'Male';
  String _maritalStatus = 'Single';
  String? _profileImagePath;

  // Step 2 Basic Details state
  String _selectedOccupation = 'Select';
  String _selectedBloodGroup = 'B Positive (B+)';

  // Basic Details controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _familySurnameController = TextEditingController();
  final TextEditingController _officialSurnameController = TextEditingController();
  final TextEditingController _nativePlaceController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _spouseNameController = TextEditingController();
  final TextEditingController _childrenNamesController = TextEditingController();

  // Area Selection state
  String _selectedCountry = 'India';
  String _selectedState = 'Gujarat';
  String _selectedDistrict = 'Ahmedabad';
  String _selectedArea = 'Satellite';

  // Step 3 / Parent Details controllers
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _fathersFatherNameController = TextEditingController();
  final TextEditingController _fathersMotherNameController = TextEditingController();
  final TextEditingController _mothersFatherNameController = TextEditingController();
  final TextEditingController _mothersMotherNameController = TextEditingController();
  final TextEditingController _mothersFatherSurnameController = TextEditingController();
  final TextEditingController _mothersFatherVillageController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _familySurnameController.dispose();
    _officialSurnameController.dispose();
    _nativePlaceController.dispose();
    _birthDateController.dispose();
    _spouseNameController.dispose();
    _childrenNamesController.dispose();
    _fatherNameController.dispose();
    _motherNameController.dispose();
    _fathersFatherNameController.dispose();
    _fathersMotherNameController.dispose();
    _mothersFatherNameController.dispose();
    _mothersMotherNameController.dispose();
    _mothersFatherSurnameController.dispose();
    _mothersFatherVillageController.dispose();
    super.dispose();
  }

  Future<void> _pickProfileImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      if (image != null) {
        setState(() {
          _profileImagePath = image.path;
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  // --- CALENDAR DATE PICKER ---
  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime initialDate = DateTime(now.year - 24, 1, 1);
    final DateTime firstDate = DateTime(1920);
    final DateTime lastDate = now;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      helpText: 'SELECT DATE OF BIRTH',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFE5A93C), // Amber Gold Header
              onPrimary: Color(0xFF191C21),
              onSurface: Color(0xFF191C21),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF191C21),
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _birthDateController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  // --- SELECT VILLAGE MODAL ---
  void _openSelectVillageModal({required Function(String) onVillageSelected}) {
    String stateVal = 'Gujarat';
    String districtVal = 'Ahmedabad';
    String talukaVal = 'Daskroi';
    String villageVal = 'Select Village';
    final TextEditingController customVillageCtrl = TextEditingController();
    bool villageNotFound = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalCtx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  // Modal Header Bar (Yellow Theme)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: const BoxDecoration(
                      color: Color(0xFF191C21),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white, size: 22),
                          onPressed: () => Navigator.of(modalCtx).pop(),
                        ),
                        const Text(
                          'Select Native Village',
                          style: TextStyle(
                            color: Color(0xFFE5A93C),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Serif',
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.check_circle_rounded, color: Color(0xFFE5A93C), size: 24),
                          onPressed: () {
                            String chosen = customVillageCtrl.text.trim().isNotEmpty
                                ? customVillageCtrl.text.trim()
                                : (villageVal != 'Select Village' ? villageVal : 'Thoriyari');
                            onVillageSelected(chosen);
                            Navigator.of(modalCtx).pop();
                          },
                        ),
                      ],
                    ),
                  ),

                  // Modal Body Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('State'),
                          _buildDropdown(
                            value: stateVal,
                            items: ['Gujarat', 'Rajasthan', 'Maharashtra', 'Madhya Pradesh'],
                            onChanged: (val) => setModalState(() => stateVal = val!),
                            borderColor: const Color(0xFFE5A93C),
                          ),
                          const SizedBox(height: 16),

                          _buildLabel('District'),
                          _buildDropdown(
                            value: districtVal,
                            items: ['Ahmedabad', 'Kutch', 'Surat', 'Rajkot', 'Patan', 'Vadodara'],
                            onChanged: (val) => setModalState(() => districtVal = val!),
                            borderColor: const Color(0xFFE5A93C),
                          ),
                          const SizedBox(height: 16),

                          _buildLabel('Taluka'),
                          _buildDropdown(
                            value: talukaVal,
                            items: ['Daskroi', 'Bhuj', 'Mandvi', 'Anjar', 'Gandhidham', 'Nakhatrana', 'Sanand'],
                            onChanged: (val) => setModalState(() => talukaVal = val!),
                            borderColor: const Color(0xFFE5A93C),
                          ),
                          const SizedBox(height: 16),

                          _buildLabel('Popular Villages'),
                          _buildDropdown(
                            value: villageVal,
                            items: ['Select Village', 'Thoriyari', 'Khedoi', 'Mothala', 'Kothara', 'Tera', 'Bhadreshwar', 'Mundra'],
                            onChanged: (val) => setModalState(() => villageVal = val!),
                            borderColor: const Color(0xFFE5A93C),
                          ),
                          const SizedBox(height: 16),

                          _buildLabel('Or Type Your Village Name'),
                          TextField(
                            controller: customVillageCtrl,
                            decoration: InputDecoration(
                              hintText: 'Type native village name e.g. Thoriyari',
                              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: Color(0xFFE5A93C)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: Color(0xFFE5A93C), width: 1.8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // SELECT Button
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                String chosen = customVillageCtrl.text.trim().isNotEmpty
                                    ? customVillageCtrl.text.trim()
                                    : (villageVal != 'Select Village' ? villageVal : 'Thoriyari');
                                onVillageSelected(chosen);
                                Navigator.of(modalCtx).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE5A93C),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                elevation: 0,
                              ),
                              child: const Text(
                                'CONFIRM VILLAGE',
                                style: TextStyle(
                                  color: Color(0xFF191C21),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          Row(
                            children: [
                              Checkbox(
                                value: villageNotFound,
                                activeColor: const Color(0xFFE5A93C),
                                checkColor: const Color(0xFF191C21),
                                onChanged: (val) {
                                  setModalState(() {
                                    villageNotFound = val ?? false;
                                  });
                                },
                              ),
                              const Text(
                                'Village Not Found in list?',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF2C3038),
                                  fontWeight: FontWeight.w600,
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
            );
          },
        );
      },
    );
  }

  // --- SELECT AREA MODAL ---
  void _openSelectAreaModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalCtx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.82,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: const BoxDecoration(
                      color: Color(0xFF191C21),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white, size: 22),
                          onPressed: () => Navigator.of(modalCtx).pop(),
                        ),
                        const Text(
                          'Select Current Location',
                          style: TextStyle(
                            color: Color(0xFFE5A93C),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Serif',
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.check_circle_rounded, color: Color(0xFFE5A93C), size: 24),
                          onPressed: () {
                            setState(() {});
                            Navigator.of(modalCtx).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('Country'),
                          _buildDropdown(
                            value: _selectedCountry,
                            items: ['India', 'USA', 'UK', 'Canada', 'UAE'],
                            onChanged: (val) => setModalState(() => _selectedCountry = val!),
                            borderColor: const Color(0xFFE5A93C),
                          ),
                          const SizedBox(height: 18),

                          _buildLabel('State'),
                          _buildDropdown(
                            value: _selectedState,
                            items: ['Gujarat', 'Maharashtra', 'Rajasthan', 'Delhi', 'Karnataka'],
                            onChanged: (val) => setModalState(() => _selectedState = val!),
                            borderColor: const Color(0xFFE5A93C),
                          ),
                          const SizedBox(height: 18),

                          _buildLabel('District / City'),
                          _buildDropdown(
                            value: _selectedDistrict,
                            items: ['Ahmedabad', 'Surat', 'Vadodara', 'Rajkot', 'Mumbai', 'Pune'],
                            onChanged: (val) => setModalState(() => _selectedDistrict = val!),
                            borderColor: const Color(0xFFE5A93C),
                          ),
                          const SizedBox(height: 18),

                          _buildLabel('Area / Locality'),
                          TextField(
                            onChanged: (val) => _selectedArea = val,
                            decoration: InputDecoration(
                              hintText: 'Type Area e.g. Satellite, Borivali',
                              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: Color(0xFFE5A93C)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: Color(0xFFE5A93C), width: 1.8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 28),

                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {});
                                Navigator.of(modalCtx).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE5A93C),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                elevation: 0,
                              ),
                              child: const Text(
                                'SAVE LOCATION',
                                style: TextStyle(
                                  color: Color(0xFF191C21),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // --- VALIDATION HELPERS ---
  void _validateAndProceedStep1() {
    if (_maritalStatus == 'Select') {
      _showWarningSnackBar('Please select your marital status.');
      return;
    }
    setState(() {
      _currentStep = 2;
    });
  }

  void _validateAndProceedStep2() {
    if (_firstNameController.text.trim().isEmpty) {
      _showWarningSnackBar('First Name is required.');
      return;
    }
    if (_familySurnameController.text.trim().isEmpty) {
      _showWarningSnackBar('Family Surname is required.');
      return;
    }
    if (_nativePlaceController.text.trim().isEmpty) {
      _showWarningSnackBar('Native Place / Village is required.');
      return;
    }
    if (_birthDateController.text.trim().isEmpty) {
      _showWarningSnackBar('Birth Date is required. Tap to pick from calendar.');
      return;
    }
    if (_selectedOccupation == 'Select') {
      _showWarningSnackBar('Please select your occupation.');
      return;
    }
    if (_maritalStatus == 'Married' && _spouseNameController.text.trim().isEmpty) {
      _showWarningSnackBar('Spouse Name is required for married status.');
      return;
    }

    setState(() {
      _currentStep = 3;
    });
  }

  void _validateAndSubmitStep3() {
    if (_fatherNameController.text.trim().isEmpty) {
      _showWarningSnackBar("Father's Name is required.");
      return;
    }
    if (_motherNameController.text.trim().isEmpty) {
      _showWarningSnackBar("Mother's Name is required.");
      return;
    }
    if (_fathersFatherNameController.text.trim().isEmpty) {
      _showWarningSnackBar("Father's Father Name (Grandfather) is required.");
      return;
    }
    if (_mothersFatherNameController.text.trim().isEmpty) {
      _showWarningSnackBar("Mother's Father Name is required.");
      return;
    }
    if (_mothersFatherVillageController.text.trim().isEmpty) {
      _showWarningSnackBar("Mother's Father Village is required.");
      return;
    }

    // Save All Data Globally to LanguageProvider
    final lang = Provider.of<LanguageProvider>(context, listen: false);
    final String fullName = '${_firstNameController.text.trim()} ${_familySurnameController.text.trim()}'.trim();

    lang.submitProfileDetails({
      'firstName': _firstNameController.text.trim(),
      'familySurname': _familySurnameController.text.trim(),
      'officialSurname': _officialSurnameController.text.trim(),
      'gender': _selectedGender,
      'maritalStatus': _maritalStatus,
      'bloodGroup': _selectedBloodGroup,
      'nativePlace': _nativePlaceController.text.trim(),
      'birthDate': _birthDateController.text.trim(),
      'occupation': _selectedOccupation,
      'spouseName': _spouseNameController.text.trim(),
      'childrenNames': _childrenNamesController.text.trim(),
      'country': _selectedCountry,
      'state': _selectedState,
      'district': _selectedDistrict,
      'area': _selectedArea,
      'fatherName': _fatherNameController.text.trim(),
      'motherName': _motherNameController.text.trim(),
      'fathersFatherName': _fathersFatherNameController.text.trim(),
      'fathersMotherName': _fathersMotherNameController.text.trim(),
      'mothersFatherName': _mothersFatherNameController.text.trim(),
      'mothersMotherName': _mothersMotherNameController.text.trim(),
      'mothersFatherSurname': _mothersFatherSurnameController.text.trim(),
      'mothersFatherVillage': _mothersFatherVillageController.text.trim(),
    });

    if (_profileImagePath != null) {
      lang.setProfileImageUrl(_profileImagePath);
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogCtx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: Row(
            children: const [
              Icon(Icons.check_circle_rounded, color: Color(0xFFE5A93C), size: 30),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Registration Submitted',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF191C21),
                    fontFamily: 'Serif',
                  ),
                ),
              ),
            ],
          ),
          content: const Text(
            'Your registration details have been submitted successfully! Your request is currently under review by community administrators.',
            style: TextStyle(fontSize: 14, color: Color(0xFF475569), height: 1.45),
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          actions: [
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(dialogCtx).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => MembershipRequestScreen(
                        userName: fullName.isNotEmpty ? fullName : 'User Profile',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE5A93C),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                ),
                child: const Text(
                  'VIEW MEMBERSHIP REQUEST',
                  style: TextStyle(
                    color: Color(0xFF191C21),
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showWarningSnackBar(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.info_outline, color: Color(0xFF191C21)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Color(0xFF191C21),
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFE5A93C),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 3),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF191C21)),
          onPressed: () {
            if (_currentStep > 1) {
              setState(() {
                _currentStep--;
              });
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        title: Text(
          'Registration Form (Step $_currentStep of 3)',
          style: const TextStyle(
            color: Color(0xFF191C21),
            fontWeight: FontWeight.bold,
            fontSize: 17,
            fontFamily: 'Serif',
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF7DB),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5A93C)),
              ),
              child: Center(
                child: Text(
                  'Step $_currentStep/3',
                  style: const TextStyle(
                    color: Color(0xFF8B6B00),
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              // Golden Step Progress Bar
              LinearProgressIndicator(
                value: _currentStep / 3,
                backgroundColor: Colors.grey.shade200,
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFE5A93C)),
                minHeight: 5,
              ),

              Padding(
                padding: const EdgeInsets.all(22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ==========================================
                    // STEP 1: GENDER & MARITAL STATUS
                    // ==========================================
                    if (_currentStep == 1) ...[
                      const Text(
                        'Select Gender *',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E232D),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _buildRadioOption('Male'),
                          const SizedBox(width: 32),
                          _buildRadioOption('Female'),
                        ],
                      ),
                      const SizedBox(height: 24),

                      const Text(
                        'Marital Status *',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E232D),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildDropdown(
                        value: _maritalStatus,
                        items: ['Single', 'Married', 'Divorced', 'Widowed'],
                        onChanged: (val) {
                          setState(() {
                            _maritalStatus = val!;
                          });
                        },
                        borderColor: const Color(0xFFE5A93C),
                      ),
                      const SizedBox(height: 32),

                      // STEP 1 ACTION BUTTONS (Yellow Theme)
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: ElevatedButton.icon(
                                onPressed: _validateAndProceedStep1,
                                icon: const Icon(Icons.arrow_forward_rounded, color: Color(0xFF191C21), size: 18),
                                label: const Text(
                                  'Next Step',
                                  style: TextStyle(
                                    color: Color(0xFF191C21),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFE5A93C),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  elevation: 0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: OutlinedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.grey.shade400),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Color(0xFF4A4E57),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],

                    // ==========================================
                    // STEP 2: BASIC DETAILS
                    // ==========================================
                    if (_currentStep == 2) ...[
                      // Yellow Section Banner
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF7DB),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE5A93C)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.person_pin_rounded, color: Color(0xFF8B6B00), size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Personal & Community Details',
                              style: TextStyle(
                                color: Color(0xFF8B6B00),
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Upload Photo Box
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Profile Photo (Optional)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Color(0xFF1E232D),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Choose from device gallery',
                                  style: TextStyle(fontSize: 11, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: _pickProfileImage,
                            child: Stack(
                              children: [
                                Container(
                                  width: 74,
                                  height: 74,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF7DB),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: const Color(0xFFE5A93C), width: 1.5),
                                    image: _profileImagePath != null
                                        ? DecorationImage(
                                            image: FileImage(File(_profileImagePath!)),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                  child: _profileImagePath == null
                                      ? const Icon(Icons.person_rounded, size: 40, color: Color(0xFF8B6B00))
                                      : null,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFE5A93C),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      _profileImagePath != null ? Icons.edit : Icons.add_a_photo,
                                      color: const Color(0xFF191C21),
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      _buildLabel('First Name *'),
                      _buildTextField(_firstNameController, 'Enter your first name'),
                      const SizedBox(height: 14),

                      _buildLabel('Family Surname *'),
                      _buildTextField(_familySurnameController, 'Enter family surname (e.g. Patel, Shah)'),
                      const SizedBox(height: 14),

                      _buildLabel('Official Surname if Different (Optional)'),
                      _buildTextField(_officialSurnameController, 'Enter official surname'),
                      const SizedBox(height: 14),

                      // BLOOD GROUP DROPDOWN
                      _buildLabel('Blood Group *'),
                      _buildDropdown(
                        value: _selectedBloodGroup,
                        items: [
                          'B Positive (B+)',
                          'A Positive (A+)',
                          'O Positive (O+)',
                          'AB Positive (AB+)',
                          'A Negative (A-)',
                          'B Negative (B-)',
                          'O Negative (O-)',
                          'AB Negative (AB-)',
                        ],
                        onChanged: (val) {
                          setState(() {
                            _selectedBloodGroup = val!;
                          });
                        },
                        borderColor: const Color(0xFFE5A93C),
                      ),
                      const SizedBox(height: 14),

                      // SPOUSE NAME FIELD (if Married)
                      if (_maritalStatus == 'Married') ...[
                        _buildLabel('Spouse Name *'),
                        _buildTextField(_spouseNameController, 'Enter spouse name e.g. Meena Patel'),
                        const SizedBox(height: 14),
                      ],

                      // CHILDREN NAMES FIELD
                      _buildLabel('Children Names (Optional)'),
                      _buildTextField(_childrenNamesController, 'e.g. Aarav, Ananya'),
                      const SizedBox(height: 14),

                      // NATIVE PLACE / VILLAGE (Tapping opens Select Village Modal)
                      _buildLabel('Native Place / Village *'),
                      InkWell(
                        onTap: () => _openSelectVillageModal(
                          onVillageSelected: (village) {
                            setState(() {
                              _nativePlaceController.text = village;
                            });
                          },
                        ),
                        child: IgnorePointer(
                          child: _buildTextField(
                            _nativePlaceController,
                            'Tap to select native place or village',
                            prefixIcon: const Icon(Icons.location_on, color: Color(0xFFE5A93C), size: 20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // BIRTH DATE WITH CALENDAR
                      _buildLabel('Date of Birth (DD/MM/YYYY) *'),
                      InkWell(
                        onTap: () => _selectBirthDate(context),
                        child: IgnorePointer(
                          child: _buildTextField(
                            _birthDateController,
                            'Tap to choose birth date from calendar',
                            prefixIcon: const Icon(Icons.calendar_month_rounded, color: Color(0xFFE5A93C), size: 20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // OCCUPATION DROPDOWN
                      _buildLabel('Occupation *'),
                      _buildDropdown(
                        value: _selectedOccupation,
                        items: [
                          'Select',
                          'Retail/Wholesale',
                          'Manufacturer',
                          'House Wife',
                          'Student',
                          'Retired',
                          'Business',
                          'Service / Corporate',
                          'Stock Market / Finance',
                          'Accountant / CA',
                          'Doctor / Medical',
                          'Engineer / IT',
                          'Teacher / Professor',
                          'Lawyer / Advocate',
                          'Farmer / Agriculture',
                          'Real Estate',
                          'Other',
                        ],
                        onChanged: (val) {
                          setState(() {
                            _selectedOccupation = val!;
                          });
                        },
                        borderColor: const Color(0xFFE5A93C),
                      ),
                      const SizedBox(height: 14),

                      // Current Location Selection
                      _buildLabel('Current Residence Location *'),
                      OutlinedButton.icon(
                        onPressed: _openSelectAreaModal,
                        icon: const Icon(Icons.pin_drop_rounded, color: Color(0xFF8B6B00)),
                        label: Expanded(
                          child: Text(
                            'Location: $_selectedArea, $_selectedDistrict, $_selectedState',
                            style: const TextStyle(color: Color(0xFF191C21), fontWeight: FontWeight.w600, fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                          side: const BorderSide(color: Color(0xFFE5A93C), width: 1.2),
                          backgroundColor: const Color(0xFFFFFDF7),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // STEP 2 CONTINUE BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _validateAndProceedStep2,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE5A93C),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 0,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Continue to Family Details',
                                style: TextStyle(
                                  color: Color(0xFF191C21),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward_rounded, color: Color(0xFF191C21), size: 18),
                            ],
                          ),
                        ),
                      ),
                    ],

                    // ==========================================
                    // STEP 3: PARENT DETAILS
                    // ==========================================
                    if (_currentStep == 3) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF7DB),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE5A93C)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.family_restroom_rounded, color: Color(0xFF8B6B00), size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Parents & Ancestral Heritage Details',
                              style: TextStyle(
                                color: Color(0xFF8B6B00),
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      _buildLabel("Father's Full Name *"),
                      _buildTextField(_fatherNameController, 'Enter father full name'),
                      const SizedBox(height: 14),

                      _buildLabel("Mother's Full Name *"),
                      _buildTextField(_motherNameController, 'Enter mother full name'),
                      const SizedBox(height: 14),

                      _buildLabel("Father's Father Name (Grandfather) *"),
                      _buildTextField(_fathersFatherNameController, "Enter grandfather's name"),
                      const SizedBox(height: 14),

                      _buildLabel("Father's Mother Name (Grandmother)"),
                      _buildTextField(_fathersMotherNameController, "Enter grandmother's name"),
                      const SizedBox(height: 20),

                      // Yellow Accent Divider
                      Container(
                        height: 1.5,
                        color: const Color(0xFFE5A93C).withValues(alpha: 0.3),
                      ),
                      const SizedBox(height: 20),

                      _buildLabel("Mother's Father Name (Maternal Grandfather) *"),
                      _buildTextField(_mothersFatherNameController, "Enter maternal grandfather's name"),
                      const SizedBox(height: 14),

                      _buildLabel("Mother's Mother Name (Maternal Grandmother)"),
                      _buildTextField(_mothersMotherNameController, "Enter maternal grandmother's name"),
                      const SizedBox(height: 14),

                      _buildLabel("Mother's Father Surname"),
                      _buildTextField(_mothersFatherSurnameController, "Enter maternal family surname"),
                      const SizedBox(height: 14),

                      // MOTHER'S FATHER VILLAGE
                      _buildLabel("Mother's Father Native Village *"),
                      InkWell(
                        onTap: () => _openSelectVillageModal(
                          onVillageSelected: (village) {
                            setState(() {
                              _mothersFatherVillageController.text = village;
                            });
                          },
                        ),
                        child: IgnorePointer(
                          child: _buildTextField(
                            _mothersFatherVillageController,
                            'Tap to select maternal village name',
                            prefixIcon: const Icon(Icons.location_on, color: Color(0xFFE5A93C), size: 20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Submit Details Button (Yellow Theme)
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _validateAndSubmitStep3,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE5A93C),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 0,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'SUBMIT REGISTRATION',
                                style: TextStyle(
                                  color: Color(0xFF191C21),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.check_circle_rounded, color: Color(0xFF191C21), size: 20),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Cancel Button
                      SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.grey.shade400),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Color(0xFF4A4E57),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioOption(String label) {
    bool isSelected = _selectedGender == label;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedGender = label;
        });
      },
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? const Color(0xFFE5A93C) : Colors.grey.shade400,
                width: 2,
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 11,
                      height: 11,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFE5A93C),
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF191C21),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    Color? borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor ?? const Color(0xFFE5A93C), width: 1.2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.contains(value) ? value : items.first,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF8B6B00)),
          onChanged: onChanged,
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(fontSize: 14, color: Color(0xFF191C21), fontWeight: FontWeight.w500),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
          color: Color(0xFF1E232D),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    Color? borderColor,
    Widget? prefixIcon,
  }) {
    return TextField(
      controller: controller,
      textInputAction: TextInputAction.next,
      style: const TextStyle(fontSize: 14, color: Color(0xFF191C21)),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor ?? Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor ?? Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE5A93C), width: 1.8),
        ),
      ),
    );
  }
}
