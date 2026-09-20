import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'home_screen.dart';

class PostJobVacancyScreen extends StatefulWidget {
  final String? userName;

  const PostJobVacancyScreen({super.key, this.userName});

  @override
  State<PostJobVacancyScreen> createState() => _PostJobVacancyScreenState();
}

class _PostJobVacancyScreenState extends State<PostJobVacancyScreen> {
  final _formKey = GlobalKey<FormState>();

  final _jobTitleController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _salaryController = TextEditingController();
  final _locationController = TextEditingController();
  final _experienceController = TextEditingController();
  final _contactPhoneController = TextEditingController();
  final _contactEmailController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedCategory = 'IT & Software';
  String _selectedEmploymentType = 'Full Time';
  final String _selectedImage = 'https://images.unsplash.com/photo-1497215728101-856f4ea42174?w=800&auto=format&fit=crop&q=80';
  final String _selectedAvatar = 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=150&auto=format&fit=crop&q=80';

  final List<String> _categories = [
    'IT & Software',
    'Finance & Accounting',
    'Sales & Marketing',
    'Healthcare & Medical',
    'Engineering & Construction',
    'Education & Teaching',
    'Retail & Hospitality',
  ];

  final List<String> _employmentTypes = [
    'Full Time',
    'Part Time',
    'Remote / Hybrid',
    'Contract / Freelance',
  ];

  @override
  void dispose() {
    _jobTitleController.dispose();
    _companyNameController.dispose();
    _salaryController.dispose();
    _locationController.dispose();
    _experienceController.dispose();
    _contactPhoneController.dispose();
    _contactEmailController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final lang = Provider.of<LanguageProvider>(context, listen: false);
    final isGu = lang.currentLanguage == 'gu';

    _showAdminApprovalModal(isGu);
  }

  void _showAdminApprovalModal(bool isGu) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFFFEF3C7),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.admin_panel_settings_outlined,
                  color: Color(0xFFB45309),
                  size: 38,
                ),
              ),
              const SizedBox(height: 16),

              Text(
                isGu ? 'એડમિન મંજૂરી માટે પેન્ડિંગ' : 'Pending Admin Approval',
                style: const TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E232D),
                ),
              ),
              const SizedBox(height: 8),

              Text(
                isGu
                    ? 'તમારી નોકરીની વિગત "${_jobTitleController.text}" મંજૂરી માટે રજૂ કરવામાં આવી છે. એડમિન ચકાસણી પછી તે હોમ પેજ પર લાઇવ થશે.'
                    : 'Your job posting for "${_jobTitleController.text}" at "${_companyNameController.text}" has been submitted. It will be verified by community admins before going live.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 20),

              // TEST/DEMO BYPASS BUTTON
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(ctx);
                    _publishJobDirectly(isGu);
                  },
                  icon: const Icon(Icons.bolt_rounded, color: Color(0xFF1E232D), size: 20),
                  label: Text(
                    isGu ? '⚡ બાયપાસ એડમિન મંજૂરી & લાઇવ પ્રદર્શિત કરો (ડેમો)' : '⚡ Bypass Admin Approval (Publish Live Now)',
                    style: const TextStyle(
                      color: Color(0xFF1E232D),
                      fontWeight: FontWeight.w900,
                      fontSize: 12.5,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFDE047),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Standard Submit for Review Button
              SizedBox(
                width: double.infinity,
                height: 44,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isGu
                              ? 'નોકરીની જગ્યા સફળતાપૂર્વક સબમિટ થઈ. એડમિન સમીક્ષા હેઠળ છે.'
                              : 'Job Vacancy submitted for admin review.',
                        ),
                        backgroundColor: const Color(0xFF191C21),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(
                    isGu ? 'સમયસર સમીક્ષા માટે છોડો' : 'Submit for Standard Review',
                    style: const TextStyle(
                      color: Color(0xFF475569),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _publishJobDirectly(bool isGu) {
    final newJob = {
      'id': 'job_${DateTime.now().millisecondsSinceEpoch}',
      'type': 'Jobs',
      'badge': 'JOB VACANCY • ${_selectedEmploymentType.toUpperCase()}',
      'badgeColor': const Color(0xFF1E40AF),
      'badgeBg': const Color(0xFFDBEAFE),
      'author': _companyNameController.text.trim(),
      'authorAvatar': _selectedAvatar,
      'timeEn': 'Just Now',
      'timeGu': 'હમણાં જ',
      'location': _locationController.text.trim(),
      'titleEn': _jobTitleController.text.trim(),
      'titleGu': _jobTitleController.text.trim(),
      'descEn': '${_descriptionController.text.trim()}\n\nExperience: ${_experienceController.text.trim()} | Package: ${_salaryController.text.trim()}',
      'descGu': '${_descriptionController.text.trim()}\n\nઅનુભવ: ${_experienceController.text.trim()} | પગાર: ${_salaryController.text.trim()}',
      'image': _selectedImage,
      'actionEn': 'Apply Now / Contact',
      'actionGu': 'અરજી કરો / સંપર્ક',
      'likes': 1,
      'comments': 0,
      'isLiked': false,
      'contact': 'Phone: ${_contactPhoneController.text.trim()} | Email: ${_contactEmailController.text.trim()}',
    };

    HomeScreen.addJobVacancy(newJob);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isGu
              ? '🎉 નોકરીની જગ્યા મંજૂર થઈ અને સ્વજન ફીડ પર લાઈવ થઈ!'
              : '🎉 Job Vacancy Approved & Published Live on Swajan Feed!',
        ),
        backgroundColor: const Color(0xFF16A34A),
      ),
    );

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => HomeScreen(userName: widget.userName),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final isGu = lang.currentLanguage == 'gu';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Color(0xFF1E232D)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isGu ? 'નોકરીની નવી જગ્યા મુકો' : 'Post Job Vacancy',
          style: const TextStyle(
            fontFamily: 'Serif',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E232D),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF191C21),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFDE047),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.work_outline_rounded, color: Color(0xFF191C21), size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isGu ? 'કંપની નોકરી જાહેરાત' : 'Company Job Opening',
                            style: const TextStyle(
                              color: Color(0xFFFDE047),
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.8,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            isGu
                                ? 'સ્વજન સમુદાયના સભ્યો માટે નોકરીની વિગતો શેર કરો'
                                : 'Hire top talent directly from our trusted Gujarati community network',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12.5,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 1. Job Title
              _buildFieldLabel(isGu ? 'નોકરીનું શીર્ષક / હોદ્દો *' : 'Job Title / Position *'),
              const SizedBox(height: 6),
              TextFormField(
                controller: _jobTitleController,
                validator: (val) => val == null || val.trim().isEmpty ? 'Please enter job title' : null,
                decoration: _buildInputDecoration(isGu ? 'દા.ત. સિનિયર સોફ્ટવેર એન્જિનિયર, એકાઉન્ટન્ટ' : 'e.g. Senior Software Engineer, Accountant'),
              ),
              const SizedBox(height: 18),

              // 2. Company / Firm Name
              _buildFieldLabel(isGu ? 'કંપની / પેઢીનું નામ *' : 'Company / Firm Name *'),
              const SizedBox(height: 6),
              TextFormField(
                controller: _companyNameController,
                validator: (val) => val == null || val.trim().isEmpty ? 'Please enter company name' : null,
                decoration: _buildInputDecoration(isGu ? 'દા.ત. પટેલ એન્ડ કંપની સી.એ. ફર્મ' : 'e.g. Patel & Co. Chartered Accountants'),
              ),
              const SizedBox(height: 18),

              // 3. Job Category Dropdown
              _buildFieldLabel(isGu ? 'નોકરીની શ્રેણી / ક્ષેત્ર *' : 'Job Category / Industry *'),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                items: _categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
                onChanged: (val) => setState(() => _selectedCategory = val!),
                decoration: _buildInputDecoration('Select category'),
              ),
              const SizedBox(height: 18),

              // 4. Employment Type Pills
              _buildFieldLabel(isGu ? 'રોજગાર પ્રકાર *' : 'Employment Type *'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _employmentTypes.map((type) {
                  final isSelected = _selectedEmploymentType == type;
                  return ChoiceChip(
                    label: Text(type),
                    selected: isSelected,
                    onSelected: (val) {
                      if (val) setState(() => _selectedEmploymentType = type);
                    },
                    selectedColor: const Color(0xFFF3D276),
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      color: isSelected ? const Color(0xFFE5A93C) : const Color(0xFFE2E8F0),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 18),

              // 5. Salary & Experience Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFieldLabel(isGu ? 'પગાર પેકેજ *' : 'Salary Package *'),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _salaryController,
                          validator: (val) => val == null || val.trim().isEmpty ? 'Enter salary' : null,
                          decoration: _buildInputDecoration(isGu ? '₹૪૦,૦૦૦/મહિનો' : '₹4.5 - ₹6 LPA'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFieldLabel(isGu ? 'જરૂરી અનુભવ *' : 'Experience *'),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _experienceController,
                          validator: (val) => val == null || val.trim().isEmpty ? 'Enter experience' : null,
                          decoration: _buildInputDecoration(isGu ? '૨-૪ વર્ષ' : '2-4 Years'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // 6. Location
              _buildFieldLabel(isGu ? 'નોકરીનું સ્થળ / શહેર *' : 'Job Location / City *'),
              const SizedBox(height: 6),
              TextFormField(
                controller: _locationController,
                validator: (val) => val == null || val.trim().isEmpty ? 'Please enter location' : null,
                decoration: _buildInputDecoration(isGu ? 'અમદાવાદ, ગુજરાત' : 'Ahmedabad, Gujarat / Remote'),
              ),
              const SizedBox(height: 18),

              // 7. Contact Info Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFieldLabel(isGu ? 'સંપર્ક ફોન નંબર *' : 'Contact Phone *'),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _contactPhoneController,
                          keyboardType: TextInputType.phone,
                          validator: (val) => val == null || val.trim().isEmpty ? 'Enter phone' : null,
                          decoration: _buildInputDecoration('+91 98250 11223'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFieldLabel(isGu ? 'ઈમેઈલ સરનામું' : 'Contact Email'),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _contactEmailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: _buildInputDecoration('careers@company.com'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // 8. Description & Requirements
              _buildFieldLabel(isGu ? 'નોકરીની સંપૂર્ણ વિગત & શરતો *' : 'Job Description & Requirements *'),
              const SizedBox(height: 6),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                validator: (val) => val == null || val.trim().isEmpty ? 'Please enter description' : null,
                decoration: _buildInputDecoration(
                  isGu
                      ? 'જરૂરી કૌશલ્યો, કામના કલાકો અને અન્ય શરતો દાખલ કરો...'
                      : 'Describe key responsibilities, qualifications, and benefits...',
                ),
              ),
              const SizedBox(height: 28),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF191C21),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.send_rounded, color: Color(0xFFFDE047), size: 20),
                      const SizedBox(width: 10),
                      Text(
                        isGu ? 'નોકરીની જગ્યા સબમિટ કરો' : 'Submit Job Vacancy',
                        style: const TextStyle(
                          color: Color(0xFFFDE047),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E232D),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF191C21), width: 1.5),
      ),
    );
  }
}
