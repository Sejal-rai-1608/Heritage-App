import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'select_area_modal.dart';
import 'membership_request_screen.dart';
import 'image_picker_dialog.dart';

class DetailedRegistrationScreen extends StatefulWidget {
  const DetailedRegistrationScreen({super.key});

  @override
  State<DetailedRegistrationScreen> createState() =>
      _DetailedRegistrationScreenState();
}

class _DetailedRegistrationScreenState
    extends State<DetailedRegistrationScreen> {
  static const Color primaryNavy = Color(0xFF00005C);

  final _formKey = GlobalKey<FormState>();
  String? _selectedProfileImageUrl;

  // Controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _familySurnameController =
      TextEditingController();
  final TextEditingController _officialSurnameController =
      TextEditingController();
  final TextEditingController _nativePlaceController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _spouseNameController = TextEditingController();
  final TextEditingController _childrenController = TextEditingController();

  // Occupation controllers
  final TextEditingController _educationDegreeController =
      TextEditingController();
  final TextEditingController _workDetailController = TextEditingController();

  // Parents controllers
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _fathersFatherNameController =
      TextEditingController();
  final TextEditingController _fathersMotherNameController =
      TextEditingController();
  final TextEditingController _mothersFatherNameController =
      TextEditingController();
  final TextEditingController _mothersMotherNameController =
      TextEditingController();
  final TextEditingController _mothersFatherSurnameController =
      TextEditingController();
  final TextEditingController _mothersFatherVillageController =
      TextEditingController();

  // Step state
  String _selectedGender = 'Male';
  String _selectedMaritalStatus = 'Select';
  String _selectedBloodGroup = 'Select';
  String _selectedCommunityWing = 'Select';
  bool _step1Submitted = false;

  // Occupation selection
  String _selectedOccupationType = 'Study'; // 'Study' or 'Work'
  String _selectedWorkCategory = 'Job'; // 'Job', 'Business', 'Professional'

  @override
  void initState() {
    super.initState();
    // Prefill data if already exists in LanguageProvider (e.g. from Edit flow)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final lang = Provider.of<LanguageProvider>(context, listen: false);
      setState(() {
        _selectedProfileImageUrl = lang.profileImageUrl;
      });
      if (lang.isProfileCompleted) {
        final details = lang.profileDetails;
        setState(() {
          _selectedGender = details['gender'] ?? 'Male';
          _selectedMaritalStatus = details['maritalStatus'] ?? 'Select';
          _selectedBloodGroup = details['bloodGroup'] ?? 'Select';
          _selectedCommunityWing = details['communityWing'] ?? 'Select';
          _step1Submitted = true;

          _firstNameController.text = details['firstName'] ?? '';
          _familySurnameController.text = details['familySurname'] ?? '';
          _officialSurnameController.text = details['officialSurname'] ?? '';
          _nativePlaceController.text = details['nativePlace'] ?? '';
          _birthDateController.text = details['birthDate'] ?? '';
          _spouseNameController.text = details['spouseName'] ?? '';
          _childrenController.text = details['children'] ?? '';

          _selectedOccupationType = details['occupationType'] ?? 'Study';
          if (_selectedOccupationType == 'Study') {
            _educationDegreeController.text = details['occupationDetail'] ?? '';
          } else {
            _selectedWorkCategory = details['workCategory'] ?? 'Job';
            _workDetailController.text = details['occupationDetail'] ?? '';
          }

          _fatherNameController.text = details['fatherName'] ?? '';
          _motherNameController.text = details['motherName'] ?? '';
          _fathersFatherNameController.text =
              details['fathersFatherName'] ?? '';
          _fathersMotherNameController.text =
              details['fathersMotherName'] ?? '';
          _mothersFatherNameController.text =
              details['mothersFatherName'] ?? '';
          _mothersMotherNameController.text =
              details['mothersMotherName'] ?? '';
          _mothersFatherSurnameController.text =
              details['mothersFatherSurname'] ?? '';
          _mothersFatherVillageController.text =
              details['mothersFatherVillage'] ?? '';
        });
      }
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _familySurnameController.dispose();
    _officialSurnameController.dispose();
    _nativePlaceController.dispose();
    _birthDateController.dispose();
    _spouseNameController.dispose();
    _childrenController.dispose();
    _educationDegreeController.dispose();
    _workDetailController.dispose();
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

  Future<void> _openAreaSelector() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const SelectAreaModal()),
    );
    if (result != null) {
      setState(() {
        _nativePlaceController.text = result;
      });
    }
  }

  void _onSubmitStep1() {
    if (_selectedMaritalStatus == 'Select') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a Marital Status')),
      );
      return;
    }
    setState(() {
      _step1Submitted = true;
    });
  }

  void _onSubmitAllDetails() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final lang = Provider.of<LanguageProvider>(context, listen: false);
    lang.setProfileImageUrl(_selectedProfileImageUrl);
    final details = {
      'gender': _selectedGender,
      'maritalStatus': _selectedMaritalStatus,
      'bloodGroup': _selectedBloodGroup,
      'communityWing': _selectedCommunityWing,
      'spouseName': _spouseNameController.text.trim(),
      'children': _childrenController.text.trim(),
      'firstName': _firstNameController.text.trim(),
      'familySurname': _familySurnameController.text.trim(),
      'officialSurname': _officialSurnameController.text.trim(),
      'nativePlace': _nativePlaceController.text.trim(),
      'birthDate': _birthDateController.text.trim(),
      'occupationType': _selectedOccupationType,
      'workCategory': _selectedWorkCategory,
      'occupationDetail': _selectedOccupationType == 'Study'
          ? _educationDegreeController.text.trim()
          : _workDetailController.text.trim(),
      'fatherName': _fatherNameController.text.trim(),
      'motherName': _motherNameController.text.trim(),
      'fathersFatherName': _fathersFatherNameController.text.trim(),
      'fathersMotherName': _fathersMotherNameController.text.trim(),
      'mothersFatherName': _mothersFatherNameController.text.trim(),
      'mothersMotherName': _mothersMotherNameController.text.trim(),
      'mothersFatherSurname': _mothersFatherSurnameController.text.trim(),
      'mothersFatherVillage': _mothersFatherVillageController.text.trim(),
    };

    lang.submitProfileDetails(details);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(Icons.check_circle_outline, color: Colors.green, size: 28),
              SizedBox(width: 8),
              Text(
                'Registration Successful',
                style: TextStyle(
                  color: primaryNavy,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          content: const Text(
            'new registration success',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Pop dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MembershipRequestScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryNavy,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryNavy),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Registration Form',
          style: TextStyle(
            color: primaryNavy,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.teal.shade50,
              backgroundImage:
                  lang.profileImageUrl != null &&
                      lang.profileImageUrl!.isNotEmpty
                  ? (lang.profileImageUrl!.startsWith('http')
                        ? NetworkImage(lang.profileImageUrl!) as ImageProvider
                        : FileImage(File(lang.profileImageUrl!))
                              as ImageProvider)
                  : null,
              child:
                  lang.profileImageUrl != null &&
                      lang.profileImageUrl!.isNotEmpty
                  ? null
                  : const Icon(Icons.person, color: Colors.teal, size: 20),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // --- STEP 1: GENDER & MARITAL ---
                Card(
                  color: Colors.white,
                  elevation: 0.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select Gender',
                          style: TextStyle(
                            color: primaryNavy,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Male',
                              groupValue: _selectedGender,
                              activeColor: primaryNavy,
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() => _selectedGender = val);
                                }
                              },
                            ),
                            const Text(
                              'Male',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 24),
                            Radio<String>(
                              value: 'Female',
                              groupValue: _selectedGender,
                              activeColor: primaryNavy,
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() => _selectedGender = val);
                                }
                              },
                            ),
                            const Text(
                              'Female',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Marital Status',
                          style: TextStyle(
                            color: primaryNavy,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedMaritalStatus,
                              isExpanded: true,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.grey,
                              ),
                              items:
                                  [
                                    'Select',
                                    'Single',
                                    'Married',
                                    'Divorced',
                                    'Widowed',
                                  ].map((m) {
                                    return DropdownMenuItem(
                                      value: m,
                                      child: Text(m),
                                    );
                                  }).toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() => _selectedMaritalStatus = val);
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        if (!_step1Submitted)
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: _onSubmitStep1,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryNavy,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        'Submit',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: primaryNavy),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.cancel_outlined,
                                        color: primaryNavy,
                                        size: 18,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color: primaryNavy,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),

                if (_step1Submitted) ...[
                  const SizedBox(height: 16),

                  // --- STEP 2: BASIC DETAILS ---
                  Container(
                    width: double.infinity,
                    color: Colors.grey.shade600,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    child: const Text(
                      'Basic Details',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Upload Photo Placeholder
                  const Text(
                    'Upload Photo',
                    style: TextStyle(
                      color: primaryNavy,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () async {
                        final result = await showDialog<String>(
                          context: context,
                          builder: (context) => const CustomImagePickerDialog(
                            isProfilePhoto: true,
                          ),
                        );
                        if (result != null) {
                          setState(() {
                            _selectedProfileImageUrl = result;
                          });
                        }
                      },
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child:
                                  _selectedProfileImageUrl != null &&
                                      _selectedProfileImageUrl!.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child:
                                          _selectedProfileImageUrl!.startsWith(
                                            'http',
                                          )
                                          ? Image.network(
                                              _selectedProfileImageUrl!,
                                              width: 90,
                                              height: 90,
                                              fit: BoxFit.cover,
                                              errorBuilder: (c, e, s) =>
                                                  const Icon(
                                                    Icons.person,
                                                    size: 48,
                                                    color: Colors.grey,
                                                  ),
                                            )
                                          : Image.file(
                                              File(_selectedProfileImageUrl!),
                                              width: 90,
                                              height: 90,
                                              fit: BoxFit.cover,
                                              errorBuilder: (c, e, s) =>
                                                  const Icon(
                                                    Icons.person,
                                                    size: 48,
                                                    color: Colors.grey,
                                                  ),
                                            ),
                                    )
                                  : const Icon(
                                      Icons.person,
                                      size: 48,
                                      color: Colors.grey,
                                    ),
                            ),
                            Positioned(
                              bottom: 4,
                              right: 4,
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: primaryNavy,
                                child: Icon(
                                  _selectedProfileImageUrl != null &&
                                          _selectedProfileImageUrl!.isNotEmpty
                                      ? Icons.edit
                                      : Icons.add,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildFormLabel('First Name'),
                  _buildFormTextField(
                    controller: _firstNameController,
                    hint: 'Enter your first name',
                    validator: (v) =>
                        v!.isEmpty ? 'First name is required' : null,
                  ),
                  const SizedBox(height: 16),

                  _buildFormLabel('Family Surname'),
                  _buildFormTextField(
                    controller: _familySurnameController,
                    hint: 'Enter your family surname',
                    validator: (v) =>
                        v!.isEmpty ? 'Family surname is required' : null,
                  ),
                  const SizedBox(height: 16),

                  _buildFormLabel('Official Surname if Different'),
                  _buildFormTextField(
                    controller: _officialSurnameController,
                    hint: 'Enter official surname if different',
                  ),
                  const SizedBox(height: 16),

                  _buildFormLabel('Native Place / Village'),
                  GestureDetector(
                    onTap: _openAreaSelector,
                    child: AbsorbPointer(
                      child: _buildFormTextField(
                        controller: _nativePlaceController,
                        hint: 'Click to select Native Place / Village',
                        suffixIcon: const Icon(
                          Icons.location_on,
                          color: primaryNavy,
                        ),
                        validator: (v) =>
                            v!.isEmpty ? 'Native place is required' : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildFormLabel('Birth Date'),
                  _buildFormTextField(
                    controller: _birthDateController,
                    hint: 'mm/dd/yyyy',
                    keyboardType: TextInputType.datetime,
                    validator: (v) =>
                        v!.isEmpty ? 'Birth date is required' : null,
                  ),
                  const SizedBox(height: 16),

                  _buildFormLabel('Blood Group'),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                      color: Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedBloodGroup,
                        isExpanded: true,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        items: [
                          'Select',
                          'A Positive (A+)',
                          'A Negative (A-)',
                          'B Positive (B+)',
                          'B Negative (B-)',
                          'O Positive (O+)',
                          'O Negative (O-)',
                          'AB Positive (AB+)',
                          'AB Negative (AB-)',
                        ].map((bg) {
                          return DropdownMenuItem(value: bg, child: Text(bg));
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() => _selectedBloodGroup = val);
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildFormLabel('Community Wing'),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                      color: Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedCommunityWing,
                        isExpanded: true,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        items: [
                          'Select',
                          'North Zone Senior Circle',
                          'Youth Wing',
                          'Women Wing',
                          'General Member',
                        ].map((wing) {
                          return DropdownMenuItem(value: wing, child: Text(wing));
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() => _selectedCommunityWing = val);
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildFormLabel('Spouse Name (Optional)'),
                  _buildFormTextField(
                    controller: _spouseNameController,
                    hint: 'Enter spouse name',
                  ),
                  const SizedBox(height: 16),

                  _buildFormLabel('Children Details (Optional)'),
                  _buildFormTextField(
                    controller: _childrenController,
                    hint: 'e.g. 2 (Rajesh, Anjali)',
                  ),
                  const SizedBox(height: 24),

                  // --- STEP 3: OCCUPATION ---
                  Container(
                    width: double.infinity,
                    color: Colors.grey.shade600,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    child: const Text(
                      'Occupation Details',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildFormLabel('Occupation Type'),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                      color: Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedOccupationType,
                        isExpanded: true,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        items: ['Study', 'Work'].map((o) {
                          return DropdownMenuItem(value: o, child: Text(o));
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() => _selectedOccupationType = val);
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  if (_selectedOccupationType == 'Study') ...[
                    _buildFormLabel('Education / Degree'),
                    _buildFormTextField(
                      controller: _educationDegreeController,
                      hint: 'e.g. B.E, B.Com, MBBS',
                      validator: (v) =>
                          v!.isEmpty ? 'Education degree is required' : null,
                    ),
                  ] else ...[
                    _buildFormLabel('Work Category'),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                        color: Colors.white,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedWorkCategory,
                          isExpanded: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          items:
                              [
                                'Job',
                                'Business',
                                'Professional',
                                'Unemployed',
                              ].map((w) {
                                return DropdownMenuItem(
                                  value: w,
                                  child: Text(w),
                                );
                              }).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => _selectedWorkCategory = val);
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFormLabel('Job Title / Business Details'),
                    _buildFormTextField(
                      controller: _workDetailController,
                      hint: 'e.g. Software Engineer at Google, Shop Owner',
                      validator: (v) =>
                          v!.isEmpty ? 'Work detail is required' : null,
                    ),
                  ],
                  const SizedBox(height: 24),

                  // --- STEP 4: PARENT DETAILS ---
                  Container(
                    width: double.infinity,
                    color: Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.account_tree_outlined,
                          color: primaryNavy,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'PARENT DETAILS',
                          style: TextStyle(
                            color: primaryNavy,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildFormLabel('Father Name'),
                  _buildFormTextField(
                    controller: _fatherNameController,
                    hint: 'Enter full name',
                    validator: (v) =>
                        v!.isEmpty ? 'Father\'s name is required' : null,
                  ),
                  const SizedBox(height: 16),

                  _buildFormLabel('Mother Name'),
                  _buildFormTextField(
                    controller: _motherNameController,
                    hint: 'Enter full name',
                    validator: (v) =>
                        v!.isEmpty ? 'Mother\'s name is required' : null,
                  ),
                  const SizedBox(height: 16),

                  _buildFormLabel('Father\'s Father Name'),
                  _buildFormTextField(
                    controller: _fathersFatherNameController,
                    hint: 'Enter grandfather\'s name',
                  ),
                  const SizedBox(height: 16),

                  _buildFormLabel('Father\'s Mother Name'),
                  _buildFormTextField(
                    controller: _fathersMotherNameController,
                    hint: 'Enter grandmother\'s name',
                  ),
                  const SizedBox(height: 16),

                  _buildFormLabel('Mother\'s Father Name'),
                  _buildFormTextField(
                    controller: _mothersFatherNameController,
                    hint: 'Enter maternal grandfather\'s name',
                  ),
                  const SizedBox(height: 16),

                  _buildFormLabel('Mother\'s Mother Name'),
                  _buildFormTextField(
                    controller: _mothersMotherNameController,
                    hint: 'Enter maternal grandmother\'s name',
                  ),
                  const SizedBox(height: 16),

                  _buildFormLabel('Mother\'s Father Surname'),
                  _buildFormTextField(
                    controller: _mothersFatherSurnameController,
                    hint: 'Enter maternal family surname',
                  ),
                  const SizedBox(height: 16),

                  _buildFormLabel('Mother\'s Father Village'),
                  _buildFormTextField(
                    controller: _mothersFatherVillageController,
                    hint: 'Search village name',
                    prefixIcon: const Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Footer buttons
                  ElevatedButton(
                    onPressed: _onSubmitAllDetails,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryNavy,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Submit Details ▻',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: primaryNavy),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: primaryNavy,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: const TextStyle(
          color: primaryNavy,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildFormTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(fontSize: 15, color: Colors.black87),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.orange, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }
}
