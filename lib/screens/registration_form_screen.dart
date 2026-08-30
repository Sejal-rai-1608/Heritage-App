import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'membership_request_screen.dart';

class RegistrationFormScreen extends StatefulWidget {
  const RegistrationFormScreen({super.key});

  @override
  State<RegistrationFormScreen> createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  int _currentStep = 1; // 1: Gender & Marital, 2: Basic Details, 3: Parent Details

  // Step 1 state
  String _selectedGender = 'Male';
  String _maritalStatus = 'Single';
  String? _profileImagePath;

  // Step 2 Basic Details state
  String _selectedOccupation = 'Select';
  String _selectedBloodGroup = 'B Positive (B+)';
  String _selectedCommunityWing = 'North Zone Senior Circle';

  // Basic Details controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _familySurnameController = TextEditingController();
  final TextEditingController _officialSurnameController = TextEditingController();
  final TextEditingController _nativePlaceController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _spouseNameController = TextEditingController();
  final TextEditingController _childrenNamesController = TextEditingController();

  Future<void> _pickProfileImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _profileImagePath = image.path;
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  // Area Selection state
  String _selectedCountry = 'India';
  String _selectedState = 'Gujarat';
  String _selectedDistrict = 'Ahmedabad';
  String _selectedArea = 'Borivali';

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

  // --- SELECT VILLAGE MODAL (Image 1) ---
  void _openSelectVillageModal({required Function(String) onVillageSelected}) {
    String stateVal = 'Select State';
    String districtVal = 'Select District';
    String talukaVal = 'Select Taluka';
    String villageVal = 'Select Village';
    String customVillage = '';
    bool villageNotFound = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                children: [
                  // Modal Header Bar (Black)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white, size: 22),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        const Text(
                          'Select Village',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.check, color: Colors.white, size: 22),
                          onPressed: () {
                            String chosen = customVillage.isNotEmpty
                                ? customVillage
                                : (villageVal != 'Select Village' ? villageVal : 'Thoriyari');
                            onVillageSelected(chosen);
                            Navigator.of(context).pop();
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
                          // 1. State Dropdown (Active Orange Border)
                          _buildDropdown(
                            value: stateVal,
                            items: ['Select State', 'Gujarat', 'Rajasthan', 'Maharashtra', 'Madhya Pradesh'],
                            onChanged: (val) => setModalState(() => stateVal = val!),
                            borderColor: Colors.orange,
                          ),
                          const SizedBox(height: 16),

                          // 2. District Dropdown
                          _buildDropdown(
                            value: districtVal,
                            items: ['Select District', 'Kutch', 'Ahmedabad', 'Surat', 'Rajkot', 'Patan'],
                            onChanged: (val) => setModalState(() => districtVal = val!),
                            borderColor: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 16),

                          // 3. Taluka Dropdown
                          _buildDropdown(
                            value: talukaVal,
                            items: ['Select Taluka', 'Bhuj', 'Mandvi', 'Anjar', 'Gandhidham', 'Nakhatrana'],
                            onChanged: (val) => setModalState(() => talukaVal = val!),
                            borderColor: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 16),

                          // 4. Village Dropdown
                          _buildDropdown(
                            value: villageVal,
                            items: ['Select Village', 'Thoriyari', 'Khedoi', 'Mothala', 'Kothara', 'Tera'],
                            onChanged: (val) => setModalState(() => villageVal = val!),
                            borderColor: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 16),

                          // 5. Type Village TextField
                          TextField(
                            onChanged: (val) => customVillage = val,
                            decoration: InputDecoration(
                              hintText: 'Type Village e.g. Thoriyari',
                              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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

                          // SELECT Button
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                String chosen = customVillage.isNotEmpty
                                    ? customVillage
                                    : (villageVal != 'Select Village' ? villageVal : 'Thoriyari');
                                onVillageSelected(chosen);
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text(
                                'SELECT',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Village Not Found Checkbox
                          Row(
                            children: [
                              Checkbox(
                                value: villageNotFound,
                                activeColor: Colors.black,
                                onChanged: (val) {
                                  setModalState(() {
                                    villageNotFound = val ?? false;
                                  });
                                },
                              ),
                              const Text(
                                'Village Not Found ?',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF2C3038),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Contact Us Right Aligned
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Contact Support: support@heritage.com')),
                                );
                              },
                              icon: const Icon(Icons.help, size: 16, color: Colors.black87),
                              label: const Text(
                                'Contact Us',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
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

  void _showRegistrationCompleteDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.green, size: 28),
              SizedBox(width: 10),
              Text(
                'Registration Complete',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E232D),
                ),
              ),
            ],
          ),
          content: const Text(
            'Your registration is complete! Your request has been submitted for admin verification.',
            style: TextStyle(fontSize: 14, color: Color(0xFF475569), height: 1.4),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                final String userFirstName = _firstNameController.text.trim();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => MembershipRequestScreen(
                      userName: userFirstName.isNotEmpty ? userFirstName : 'Riya Mehta',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              ),
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ],
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
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.82,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                children: [
                  // Modal Header
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white, size: 22),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        const Text(
                          'Select Area',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.check, color: Colors.white, size: 22),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),

                  // Modal Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Country',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          _buildDropdown(
                            value: _selectedCountry,
                            items: ['India', 'USA', 'UK', 'Canada', 'UAE'],
                            onChanged: (val) => setModalState(() => _selectedCountry = val!),
                          ),
                          const SizedBox(height: 20),

                          const Text(
                            'Pincode',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Postal Pin Code e.g. 400091',
                              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: Colors.orange, width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: Colors.orange, width: 1.5),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Divider Or
                          Row(
                            children: [
                              Expanded(child: Divider(color: Colors.grey.shade300)),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Text('Or', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                              ),
                              Expanded(child: Divider(color: Colors.grey.shade300)),
                            ],
                          ),
                          const SizedBox(height: 20),

                          const Text(
                            'State',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          _buildDropdown(
                            value: _selectedState,
                            items: ['Select State', 'Gujarat', 'Maharashtra', 'Rajasthan', 'Delhi'],
                            onChanged: (val) => setModalState(() => _selectedState = val!),
                          ),
                          const SizedBox(height: 20),

                          const Text(
                            'District',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          _buildDropdown(
                            value: _selectedDistrict,
                            items: ['Select District', 'Ahmedabad', 'Surat', 'Vadodara', 'Mumbai'],
                            onChanged: (val) => setModalState(() => _selectedDistrict = val!),
                          ),
                          const SizedBox(height: 20),

                          const Text(
                            'Area',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            onChanged: (val) => _selectedArea = val,
                            decoration: InputDecoration(
                              hintText: 'Type Area e.g. Borivali',
                              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey.shade300),
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
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text(
                                'Select',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: _currentStep > 1 ? Colors.black : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: _currentStep > 1 ? Colors.white : Colors.black87,
          ),
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
          'Registration Form',
          style: TextStyle(
            color: _currentStep > 1 ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: _currentStep > 1 ? Colors.white24 : Colors.grey.shade300,
              child: Icon(
                Icons.person,
                size: 20,
                color: _currentStep > 1 ? Colors.white : Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Progress Bar if Step 3
              if (_currentStep == 3)
                LinearProgressIndicator(
                  value: 0.75,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
                  minHeight: 4,
                ),

              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- SELECT GENDER ---
                    const Text(
                      'Select Gender',
                      style: TextStyle(
                        fontSize: 16,
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

                    // --- MARITAL STATUS ---
                    const Text(
                      'Marital Status',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E232D),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildDropdown(
                      value: _maritalStatus,
                      items: ['Select', 'Single', 'Married', 'Divorced', 'Widowed'],
                      onChanged: (val) {
                        setState(() {
                          _maritalStatus = val!;
                        });
                      },
                      borderColor: const Color(0xFF8B6B00),
                    ),
                    const SizedBox(height: 28),

                    // STEP 1 BUTTONS (Submit & Cancel) if Step == 1
                    if (_currentStep == 1)
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    _currentStep = 2;
                                  });
                                },
                                icon: const Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
                                label: const Text(
                                  'Submit',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: OutlinedButton.icon(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: const Icon(Icons.cancel_outlined, color: Colors.black87, size: 18),
                                label: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.black, width: 1.2),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                    // --- STEP 2: BASIC DETAILS ---
                    if (_currentStep >= 2) ...[
                      const SizedBox(height: 16),
                      // Gray Banner Header
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6E7480),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Basic Details',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Upload Photo Box (Interactive Gallery Picker)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Upload Photo',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Color(0xFF1E232D),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Tap to choose from local device storage',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: _pickProfileImage,
                            child: Stack(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.grey.shade400),
                                    image: _profileImagePath != null
                                        ? DecorationImage(
                                            image: FileImage(File(_profileImagePath!)),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                  child: _profileImagePath == null
                                      ? const Icon(Icons.person, size: 48, color: Colors.grey)
                                      : null,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      _profileImagePath != null ? Icons.edit : Icons.add,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      _buildLabel('First Name'),
                      _buildTextField(_firstNameController, 'Enter first name'),
                      const SizedBox(height: 16),

                      _buildLabel('Family Surname'),
                      _buildTextField(_familySurnameController, 'Enter family surname'),
                      const SizedBox(height: 16),

                      _buildLabel('Official Surname if Different'),
                      _buildTextField(_officialSurnameController, 'Enter official surname'),
                      const SizedBox(height: 16),

                      // BLOOD GROUP DROPDOWN
                      _buildLabel('Blood Group'),
                      _buildDropdown(
                        value: _selectedBloodGroup,
                        items: [
                          'Select',
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
                        borderColor: const Color(0xFF8B6B00),
                      ),
                      const SizedBox(height: 16),

                      // COMMUNITY WING DROPDOWN
                      _buildLabel('Community Wing'),
                      _buildDropdown(
                        value: _selectedCommunityWing,
                        items: [
                          'North Zone Senior Circle',
                          'Youth Wing',
                          'Women Circle',
                          'General Member',
                        ],
                        onChanged: (val) {
                          setState(() {
                            _selectedCommunityWing = val!;
                          });
                        },
                        borderColor: const Color(0xFF8B6B00),
                      ),
                      const SizedBox(height: 16),

                      // SPOUSE NAME FIELD (if Married)
                      if (_maritalStatus == 'Married') ...[
                        _buildLabel('Spouse Name'),
                        _buildTextField(_spouseNameController, 'Enter spouse name e.g. Meena Patel'),
                        const SizedBox(height: 16),
                      ],

                      // CHILDREN NAMES FIELD
                      _buildLabel('Children Names (Optional)'),
                      _buildTextField(_childrenNamesController, 'e.g. Rajesh, Anjali'),
                      const SizedBox(height: 16),

                      // NATIVE PLACE / VILLAGE (Tapping opens Select Village Modal)
                      _buildLabel('Native Place / Village'),
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
                            'Select native place or village',
                            prefixIcon: const Icon(Icons.location_on_outlined, color: Colors.grey, size: 20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      _buildLabel('Birth Date'),
                      _buildTextField(_birthDateController, 'mm/dd/yyyy'),
                      const SizedBox(height: 16),

                      // OCCUPATION DROPDOWN (Image 2 + Extra Options)
                      _buildLabel('Occupation'),
                      _buildDropdown(
                        value: _selectedOccupation,
                        items: [
                          'Select',
                          'Retail/Wholesale',
                          'Manufacturer',
                          'House Wife',
                          'Student',
                          'Retired',
                          'Diksha',
                          'Baby / Pre School',
                          'Business',
                          'Service',
                          'Stock Market',
                          'Accountant',
                          'Acting Professional',
                          'Doctor / Medical',
                          'Engineer',
                          'Teacher / Professor',
                          'Lawyer / Advocate',
                          'Farmer / Agriculture',
                          'Software / IT Professional',
                          'Architect / Interior Designer',
                          'Real Estate',
                          'Consultant',
                          'Other',
                        ],
                        onChanged: (val) {
                          setState(() {
                            _selectedOccupation = val!;
                          });
                        },
                        borderColor: const Color(0xFF8B6B00),
                      ),
                      const SizedBox(height: 16),

                      // Select Area Trigger Button
                      OutlinedButton.icon(
                        onPressed: _openSelectAreaModal,
                        icon: const Icon(Icons.location_on_outlined, color: Colors.black87),
                        label: Text(
                          _selectedArea.isNotEmpty
                              ? 'Selected Area: $_selectedArea, $_selectedDistrict'
                              : 'Select Area / Location',
                          style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
                        ),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                          side: BorderSide(color: Colors.grey.shade400),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      const SizedBox(height: 28),

                      if (_currentStep == 2)
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _currentStep = 3;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text(
                              'Continue Registration',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                    ],

                    // --- STEP 3: PARENT DETAILS ---
                    if (_currentStep == 3) ...[
                      const SizedBox(height: 24),

                      // Section Banner (PARENT DETAILS)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE2E4E8),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.account_tree_outlined, color: Color(0xFF4A505C), size: 20),
                            SizedBox(width: 10),
                            Text(
                              'PARENT DETAILS',
                              style: TextStyle(
                                color: Color(0xFF4A505C),
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      _buildLabel('Father Name'),
                      _buildTextField(_fatherNameController, 'Enter full name'),
                      const SizedBox(height: 16),

                      _buildLabel('Mother Name'),
                      _buildTextField(_motherNameController, 'Enter full name'),
                      const SizedBox(height: 16),

                      _buildLabel("Father's Father Name"),
                      _buildTextField(_fathersFatherNameController, "Enter grandfather's name"),
                      const SizedBox(height: 16),

                      _buildLabel("Father's Mother Name"),
                      _buildTextField(_fathersMotherNameController, "Enter grandmother's name"),
                      const SizedBox(height: 24),

                      // Dashed Divider
                      Row(
                        children: List.generate(
                          30,
                          (index) => Expanded(
                            child: Container(
                              height: 1,
                              color: index % 2 == 0 ? Colors.grey.shade400 : Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      _buildLabel("Mother's Father Name"),
                      _buildTextField(
                        _mothersFatherNameController,
                        "Enter maternal grandfather's name",
                        borderColor: Colors.orange,
                      ),
                      const SizedBox(height: 16),

                      _buildLabel("Mother's Mother Name"),
                      _buildTextField(_mothersMotherNameController, "Enter maternal grandmother's name"),
                      const SizedBox(height: 16),

                      _buildLabel("Mother's Father Surname"),
                      _buildTextField(_mothersFatherSurnameController, "Enter maternal family surname"),
                      const SizedBox(height: 16),

                      // MOTHER'S FATHER VILLAGE (Tapping opens Select Village Modal)
                      _buildLabel("Mother's Father Village"),
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
                            'Search village name',
                            prefixIcon: const Icon(Icons.location_on_outlined, color: Colors.grey, size: 20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Submit Details ➢ Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _showRegistrationCompleteDialog,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Submit Details',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.send_outlined, color: Colors.white, size: 18),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Cancel Button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.black, width: 1.2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 15),
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
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? const Color(0xFF8B6B00) : Colors.grey.shade500,
                width: 2,
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF8B6B00),
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
              color: Color(0xFF2C3038),
              fontWeight: FontWeight.w500,
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor ?? const Color(0xFF8B6B00), width: 1.2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.contains(value) ? value : items.first,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          onChanged: onChanged,
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(fontSize: 14, color: Color(0xFF2C3038)),
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
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
          borderSide: BorderSide(color: borderColor ?? Colors.black87, width: 1.5),
        ),
      ),
    );
  }
}
