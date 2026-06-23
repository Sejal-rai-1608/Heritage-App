import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class CoupleRegistrationScreen extends StatefulWidget {
  const CoupleRegistrationScreen({super.key});

  @override
  State<CoupleRegistrationScreen> createState() => _CoupleRegistrationScreenState();
}

class _CoupleRegistrationScreenState extends State<CoupleRegistrationScreen> {
  static const Color primaryNavy = Color(0xFF00005C);

  // Form Key for validation
  final _formKey = GlobalKey<FormState>();

  // Text Controllers - Groom
  final _groomNameCtrl = TextEditingController();
  final _groomDobCtrl = TextEditingController();
  final _groomOccCtrl = TextEditingController();
  final _groomVillageCtrl = TextEditingController();
  final _groomPhoneCtrl = TextEditingController();
  String? _selectedGroomEducation;

  // Text Controllers - Bride
  final _brideNameCtrl = TextEditingController();
  final _brideDobCtrl = TextEditingController();
  final _brideOccCtrl = TextEditingController();
  final _brideVillageCtrl = TextEditingController();
  final _bridePhoneCtrl = TextEditingController();
  String? _selectedBrideEducation;

  // Family Info
  final _groomFatherCtrl = TextEditingController();
  final _brideFatherCtrl = TextEditingController();

  // Document Upload Mock States
  String? _uploadedIdName;
  String? _uploadedAgeProofName;

  final List<String> _educationLevels = [
    'Primary School',
    'Secondary School (10th)',
    'Higher Secondary (12th)',
    'Graduate / Bachelor Degree',
    'Post Graduate / Master Degree',
    'Doctorate / PhD',
    'Other / Diploma',
  ];

  @override
  void dispose() {
    _groomNameCtrl.dispose();
    _groomDobCtrl.dispose();
    _groomOccCtrl.dispose();
    _groomVillageCtrl.dispose();
    _groomPhoneCtrl.dispose();
    _brideNameCtrl.dispose();
    _brideDobCtrl.dispose();
    _brideOccCtrl.dispose();
    _brideVillageCtrl.dispose();
    _bridePhoneCtrl.dispose();
    _groomFatherCtrl.dispose();
    _brideFatherCtrl.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime(2010),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryNavy,
              onPrimary: Colors.white,
              onSurface: primaryNavy,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  void _simulateUpload(String docType) {
    setState(() {
      if (docType == 'id') {
        _uploadedIdName = 'aadhaar_card_scan.pdf';
      } else {
        _uploadedAgeProofName = 'birth_certificate_scan.jpg';
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${docType == 'id' ? "Identity Proof" : "Age Proof"} uploaded successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_uploadedIdName == null || _uploadedAgeProofName == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please upload all required scanned documents.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Show success dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Row(
              children: const [
                Icon(Icons.check_circle, color: Colors.green, size: 28),
                SizedBox(width: 8),
                Text(
                  'Registration Submitted',
                  style: TextStyle(color: primaryNavy, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your registration request has been submitted for Community Verification.',
                  style: TextStyle(fontSize: 13, height: 1.4),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 12),
                _buildConfirmRow('Groom:', _groomNameCtrl.text),
                const SizedBox(height: 6),
                _buildConfirmRow('Bride:', _brideNameCtrl.text),
                const SizedBox(height: 6),
                _buildConfirmRow('Reference No:', 'REG-${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}'),
                const SizedBox(height: 16),
                const Text(
                  'The Heritage Core Community Council will verify the documents and contact you within 3 business days.',
                  style: TextStyle(fontSize: 11, color: Colors.grey, fontStyle: FontStyle.italic),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // dismiss dialog
                  Navigator.of(context).pop(); // pop registration screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryNavy,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Back to Events'),
              ),
            ],
          );
        },
      );
    }
  }

  Widget _buildConfirmRow(String label, String val) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 13),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            val,
            style: const TextStyle(fontWeight: FontWeight.bold, color: primaryNavy, fontSize: 13),
          ),
        ),
      ],
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
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          lang.getText('samuhik_vivah_title'),
          style: const TextStyle(
            color: primaryNavy,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Top Header Heart Icon Box
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: primaryNavy.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: primaryNavy,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Register as Couple',
                        style: TextStyle(
                          color: primaryNavy,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Join the community mass marriage ceremony. Please fill in the details accurately.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // CARD 1: Groom's Details
                _buildFormSectionCard(
                  title: "Groom's Details",
                  icon: Icons.person_outline,
                  children: [
                    _buildLabel('Full Name'),
                    _buildTextField(_groomNameCtrl, 'Enter groom\'s full name'),
                    const SizedBox(height: 16),
                    _buildLabel('Date of Birth'),
                    _buildDateField(_groomDobCtrl),
                    const SizedBox(height: 16),
                    _buildLabel('Education Level'),
                    _buildDropdownField(
                      _selectedGroomEducation,
                      (val) => setState(() => _selectedGroomEducation = val),
                    ),
                    const SizedBox(height: 16),
                    _buildLabel('Occupation'),
                    _buildTextField(_groomOccCtrl, 'e.g. Software Engineer, Farmer, Business'),
                    const SizedBox(height: 16),
                    _buildLabel('Native Village'),
                    _buildTextField(_groomVillageCtrl, 'Enter village name'),
                    const SizedBox(height: 16),
                    _buildLabel('Mobile Number'),
                    _buildPhoneField(_groomPhoneCtrl),
                  ],
                ),
                const SizedBox(height: 16),

                // CARD 2: Bride's Details
                _buildFormSectionCard(
                  title: "Bride's Details",
                  icon: Icons.person_outline,
                  children: [
                    _buildLabel('Full Name'),
                    _buildTextField(_brideNameCtrl, 'Enter bride\'s full name'),
                    const SizedBox(height: 16),
                    _buildLabel('Date of Birth'),
                    _buildDateField(_brideDobCtrl),
                    const SizedBox(height: 16),
                    _buildLabel('Education Level'),
                    _buildDropdownField(
                      _selectedBrideEducation,
                      (val) => setState(() => _selectedBrideEducation = val),
                    ),
                    const SizedBox(height: 16),
                    _buildLabel('Occupation'),
                    _buildTextField(_brideOccCtrl, 'e.g. Teacher, Nurse, Business'),
                    const SizedBox(height: 16),
                    _buildLabel('Native Village'),
                    _buildTextField(_brideVillageCtrl, 'Enter village name'),
                    const SizedBox(height: 16),
                    _buildLabel('Mobile Number'),
                    _buildPhoneField(_bridePhoneCtrl),
                  ],
                ),
                const SizedBox(height: 16),

                // CARD 3: Family & Documents
                _buildFormSectionCard(
                  title: "Family & Documents",
                  icon: Icons.account_tree_outlined,
                  children: [
                    _buildLabel('Groom\'s Father\'s Name'),
                    _buildTextField(_groomFatherCtrl, 'Father\'s full name'),
                    const SizedBox(height: 16),
                    _buildLabel('Bride\'s Father\'s Name'),
                    _buildTextField(_brideFatherCtrl, 'Father\'s full name'),
                    const SizedBox(height: 24),
                    const Text(
                      'Required Documents (Scanned Copies)',
                      style: TextStyle(
                        color: primaryNavy,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildLabel('Identity Proof (Aadhaar/ID)'),
                    const SizedBox(height: 8),
                    _buildUploadBox(
                      isUploaded: _uploadedIdName != null,
                      fileName: _uploadedIdName,
                      buttonText: 'Upload ID',
                      onTap: () => _simulateUpload('id'),
                    ),
                    const SizedBox(height: 16),
                    _buildLabel('Age Proof (Birth Certificate)'),
                    const SizedBox(height: 8),
                    _buildUploadBox(
                      isUploaded: _uploadedAgeProofName != null,
                      fileName: _uploadedAgeProofName,
                      buttonText: 'Upload Age Proof',
                      onTap: () => _simulateUpload('age'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Community Verification Banner
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: primaryNavy,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.verified_outlined,
                          color: Colors.amber,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Community Verification',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'All registrations are reviewed by the Heritage Core Community Council to ensure validity and support for the couples.',
                              style: TextStyle(
                                color: Color(0xFFFFF0F5),
                                fontSize: 11.5,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryNavy,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Submit Registration',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.send, size: 16),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: primaryNavy, size: 18),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: primaryNavy,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey.shade800,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController ctrl, String hint) {
    return TextFormField(
      controller: ctrl,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      style: const TextStyle(fontSize: 14, color: Colors.black87),
      validator: (val) {
        if (val == null || val.trim().isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }

  Widget _buildDateField(TextEditingController ctrl) {
    return TextFormField(
      controller: ctrl,
      readOnly: true,
      onTap: () => _selectDate(context, ctrl),
      decoration: InputDecoration(
        hintText: 'mm/dd/yyyy',
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        suffixIcon: const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
      ),
      style: const TextStyle(fontSize: 14, color: Colors.black87),
      validator: (val) {
        if (val == null || val.trim().isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }

  Widget _buildDropdownField(String? selectedVal, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: selectedVal,
      onChanged: onChanged,
      hint: Text(
        'Select Education',
        style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      items: _educationLevels.map((lvl) {
        return DropdownMenuItem<String>(
          value: lvl,
          child: Text(lvl, style: const TextStyle(fontSize: 14, color: Colors.black87)),
        );
      }).toList(),
      validator: (val) {
        if (val == null) {
          return 'Please select an education level';
        }
        return null;
      },
    );
  }

  Widget _buildPhoneField(TextEditingController ctrl) {
    return TextFormField(
      controller: ctrl,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: '+91 00000 00000',
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      style: const TextStyle(fontSize: 14, color: Colors.black87),
      validator: (val) {
        if (val == null || val.trim().isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }

  Widget _buildUploadBox({
    required bool isUploaded,
    required String? fileName,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: isUploaded ? Colors.green.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isUploaded ? Colors.green.shade400 : Colors.grey.shade300,
            style: isUploaded ? BorderStyle.solid : BorderStyle.solid,
          ),
        ),
        child: isUploaded
            ? Row(
                children: [
                  const SizedBox(width: 16),
                  const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      fileName ?? '',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.refresh, color: Colors.grey),
                  const SizedBox(width: 16),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.upload_file_outlined, color: primaryNavy, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    buttonText,
                    style: const TextStyle(
                      color: primaryNavy,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
