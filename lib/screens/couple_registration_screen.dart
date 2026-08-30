import 'package:flutter/material.dart';
import 'home_screen.dart';

class CoupleRegistrationScreen extends StatefulWidget {
  final String? userName;

  const CoupleRegistrationScreen({super.key, this.userName});

  @override
  State<CoupleRegistrationScreen> createState() => _CoupleRegistrationScreenState();
}

class _CoupleRegistrationScreenState extends State<CoupleRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Groom Controllers
  final _groomNameController = TextEditingController();
  final _groomDobController = TextEditingController();
  final _groomMobileController = TextEditingController();
  String? _groomEducation;
  final _groomOccupationController = TextEditingController();
  final _groomVillageController = TextEditingController();

  // Bride Controllers
  final _brideNameController = TextEditingController();
  final _brideDobController = TextEditingController();
  final _brideMobileController = TextEditingController();
  String? _brideEducation;
  final _brideOccupationController = TextEditingController();
  final _brideVillageController = TextEditingController();

  // Family Controllers
  final _groomFatherController = TextEditingController();
  final _brideFatherController = TextEditingController();

  // Document Upload States
  bool _identityProofUploaded = false;
  bool _ageProofUploaded = false;

  final List<String> _educationOptions = [
    'શિક્ષણ પસંદ કરો',
    'હાઇસ્કૂલ / ૧૦મું-૧૨મું',
    'સ્નાતક (B.A. / B.Sc / B.Com)',
    'એન્જિનિયરિંગ (B.E. / B.Tech)',
    'મેડિકલ (M.B.B.S.)',
    'અનુસ્નાતક (M.A. / M.Sc / MBA)',
    'અન્ય',
  ];

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1998, 1, 1),
      firstDate: DateTime(1960),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  void _handleSubmit() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: Color(0xFFDCFCE7),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_rounded,
                    color: Color(0xFF16A34A),
                    size: 40,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'અરજી સફળતાપૂર્વક સબમિટ થઈ!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Serif',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E232D),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'સમૂહ લગ્ન ૨૦૨૪ માટે તમારી દંપતી નોંધણી મળી છે. અમારી હેરિટેજ સમિતિ તમારા દસ્તાવેજોની સમીક્ષા કરશે અને ટૂંક સમયમાં સંપર્ક કરશે.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (_) => HomeScreen(userName: widget.userName),
                        ),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F172A),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      'હોમ પેજ પર પાછા જાઓ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Color(0xFF1E232D)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'સમૂહ લગ્ન',
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E232D),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFD9B854), width: 1.5),
                image: const DecorationImage(
                  image: AssetImage('assets/images/sanjay_profile.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Header Icon & Title
              Center(
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFEF9C3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Color(0xFF856404),
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'દંપતી તરીકે નોંધણી કરો',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E232D),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'સમુદાયના સમૂહ લગ્ન સમારોહમાં જોડાઓ. તમારી પવિત્ર યાત્રા શરૂ કરવા માટે કૃપા કરીને ચોક્કસ વિગતો ભરો.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 28),

              // SECTION 1: GROOM'S DETAILS
              _buildSectionHeader(
                icon: Icons.person_outlined,
                title: "વરરાજાની વિગતો",
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'પૂરું નામ',
                hint: "વરરાજાનું પૂરું નામ દાખલ કરો",
                controller: _groomNameController,
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: _buildDateField(
                      label: 'જન્મ તારીખ',
                      controller: _groomDobController,
                      onTap: () => _selectDate(context, _groomDobController),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTextField(
                      label: 'મોબાઈલ નંબર',
                      hint: '૦૦૦૦૦ ૦૦૦૦૦',
                      controller: _groomMobileController,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _buildDropdownField(
                label: 'શિક્ષણનું સ્તર',
                value: _groomEducation,
                onChanged: (val) => setState(() => _groomEducation = val),
              ),
              const SizedBox(height: 14),
              _buildTextField(
                label: 'વ્યવસાય',
                hint: 'દા.ત. સોફ્ટવેર એન્જિનિયર, ખેડૂત',
                controller: _groomOccupationController,
              ),
              const SizedBox(height: 14),
              _buildTextField(
                label: 'વતન ગામ',
                hint: 'ગામનું નામ',
                controller: _groomVillageController,
              ),
              const SizedBox(height: 32),

              // SECTION 2: BRIDE'S DETAILS
              _buildSectionHeader(
                icon: Icons.person_outlined,
                title: "કન્યાની વિગતો",
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'પૂરું નામ',
                hint: "કન્યાનું પૂરું નામ દાખલ કરો",
                controller: _brideNameController,
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: _buildDateField(
                      label: 'જન્મ તારીખ',
                      controller: _brideDobController,
                      onTap: () => _selectDate(context, _brideDobController),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTextField(
                      label: 'મોબાઈલ નંબર',
                      hint: '૦૦૦૦૦ ૦૦૦૦૦',
                      controller: _brideMobileController,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _buildDropdownField(
                label: 'શિક્ષણનું સ્તર',
                value: _brideEducation,
                onChanged: (val) => setState(() => _brideEducation = val),
              ),
              const SizedBox(height: 14),
              _buildTextField(
                label: 'વ્યવસાય',
                hint: 'દા.ત. શિક્ષક, ડિઝાઈનર',
                controller: _brideOccupationController,
              ),
              const SizedBox(height: 14),
              _buildTextField(
                label: 'વતન ગામ',
                hint: 'ગામનું નામ',
                controller: _brideVillageController,
              ),
              const SizedBox(height: 32),

              // SECTION 3: FAMILY DETAILS
              _buildSectionHeader(
                icon: Icons.groups_outlined,
                title: 'કુટુંબની વિગતો',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: "વરરાજાના પિતાનું નામ",
                hint: 'પૂરું નામ',
                controller: _groomFatherController,
              ),
              const SizedBox(height: 14),
              _buildTextField(
                label: "કન્યાના પિતાનું નામ",
                hint: 'પૂરું નામ',
                controller: _brideFatherController,
              ),
              const SizedBox(height: 32),

              // SECTION 4: DOCUMENT UPLOADS
              _buildSectionHeader(
                icon: Icons.article_outlined,
                title: 'દસ્તાવેજ અપલોડ',
              ),
              const SizedBox(height: 16),
              _buildUploadBox(
                title: 'ઓળખનો પુરાવો',
                subtitle: 'આધાર, વોટર આઈડી, અથવા ડીએલ',
                isUploaded: _identityProofUploaded,
                onTap: () {
                  setState(() => _identityProofUploaded = true);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('ઓળખનો પુરાવો સફળતાપૂર્વક અપલોડ થયો')),
                  );
                },
              ),
              const SizedBox(height: 14),
              _buildUploadBox(
                title: 'ઉંમરનો પુરાવો',
                subtitle: 'જન્મ પ્રમાણપત્ર અથવા ૧૦મી માર્કશીટ',
                isUploaded: _ageProofUploaded,
                onTap: () {
                  setState(() => _ageProofUploaded = true);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('ઉંમરનો પુરાવો સફળતાપૂર્વક અપલોડ થયો')),
                  );
                },
              ),
              const SizedBox(height: 8),
              const Text(
                'મહત્તમ ફાઇલ કદ ૫MB. ફોર્મેટ: PDF, JPEG, અથવા PNG.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF94A3B8),
                ),
              ),
              const SizedBox(height: 32),

              // SECTION 5: VERIFICATION PROTOCOL BOX
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF111827),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.verified, color: Color(0xFFFDE047), size: 20),
                        SizedBox(width: 10),
                        Text(
                          'ચકાસણી પ્રોટોકોલ',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFDE047),
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'તમારી અરજીની હેરિટેજ સમિતિ દ્વારા ઔપચારિક સમીક્ષા કરવામાં આવશે. કૃપા કરીને ખાતરી કરો કે બધા અપલોડ કરેલા દસ્તાવેજો વાંચી શકાય તેવા છે. નોંધણી સમારોહ સ્પોન્સરશિપ, કાનૂની સુવિધા અને લગ્ન પછીના સામુદાયિક સમર્થનની ઍક્સેસ પ્રદાન કરે છે.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF94A3B8),
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // SUBMIT BUTTON
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F172A),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'નોંધણી સબમિટ કરો',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader({required IconData icon, required String title}) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF856404), size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Serif',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E232D),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E232D),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            filled: true,
            fillColor: const Color(0xFFEFF6FF),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E232D),
          ),
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: onTap,
          child: IgnorePointer(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'દિ/મહિના/વર્ષ',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                filled: true,
                fillColor: const Color(0xFFEFF6FF),
                suffixIcon: const Icon(Icons.calendar_today_outlined, size: 18, color: Color(0xFF64748B)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E232D),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(14),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value ?? _educationOptions[0],
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF64748B)),
              items: _educationOptions.map((opt) {
                return DropdownMenuItem<String>(
                  value: opt,
                  child: Text(
                    opt,
                    style: TextStyle(
                      fontSize: 13,
                      color: opt == 'શિક્ષણ પસંદ કરો' ? Colors.grey.shade400 : const Color(0xFF1E232D),
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadBox({
    required String title,
    required String subtitle,
    required bool isUploaded,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isUploaded ? const Color(0xFFF0FDF4) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isUploaded ? const Color(0xFF86EFAC) : const Color(0xFFE2E8F0),
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isUploaded ? const Color(0xFFDCFCE7) : const Color(0xFFDBEAFE),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isUploaded ? Icons.check : Icons.upload_outlined,
              color: isUploaded ? const Color(0xFF16A34A) : const Color(0xFF2563EB),
              size: 22,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            isUploaded ? '$title અપલોડ થયો' : title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E232D),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: isUploaded ? const Color(0xFF16A34A) : const Color(0xFF1E232D)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              isUploaded ? 'ફાઈલ બદલો' : 'ફાઈલ અપલોડ કરો',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isUploaded ? const Color(0xFF16A34A) : const Color(0xFF1E232D),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
