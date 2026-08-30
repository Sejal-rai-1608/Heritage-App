import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../widgets/custom_bottom_navbar.dart';
import 'home_screen.dart';
import 'image_picker_dialog.dart';

class ObituaryScreen extends StatefulWidget {
  final String? userName;
  const ObituaryScreen({super.key, this.userName});

  @override
  State<ObituaryScreen> createState() => _ObituaryScreenState();
}

class _ObituaryScreenState extends State<ObituaryScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _obituaries = [
    {
      'id': '1',
      'nameEn': 'Late Shantaram Govind More',
      'nameGu': 'સ્વ. શાંતારામ ગોવિંદ મોરે',
      'passedDateEn': '28 August 2026',
      'passedDateGu': '૨૮ ઓગસ્ટ ૨૦૨૬',
      'ageEn': 'Age: 78 Years',
      'ageGu': 'ઉંમર: ૭૮ વર્ષ',
      'cityEn': 'Satara Road, Maharashtra',
      'cityGu': 'સાતારા રોડ, મહારાષ્ટ્ર',
      'prarthnaDateEn': '31 August 2026',
      'prarthnaDateGu': '૩૧ ઓગસ્ટ ૨૦૨૬',
      'prarthnaTimeEn': '4:00 PM to 6:00 PM',
      'prarthnaTimeGu': 'સાંજે ૪:૦૦ થી ૬:૦૦',
      'venueEn': 'Maheshwari Bhavan, Hall No. 2, Satara Road',
      'venueGu': 'મહેશ્વરી ભવન, હોલ નં. ૨, સાતારા રોડ',
      'familyEn': 'Soham More, Aditya More & More Family',
      'familyGu': 'સોહમ મોરે, આદિત્ય મોરે અને મોરે પરિવાર',
      'image': 'assets/images/sanjay_profile.png',
      'tributes': 24,
    },
    {
      'id': '2',
      'nameEn': 'Late Sunanda Ramesh Parikh',
      'nameGu': 'સ્વ. સુનંદા રમેશ પરીખ',
      'passedDateEn': '25 August 2026',
      'passedDateGu': '૨૫ ઓગસ્ટ ૨૦૨૬',
      'ageEn': 'Age: 72 Years',
      'ageGu': 'ઉંમર: ૭૨ વર્ષ',
      'cityEn': 'Ahmedabad, Gujarat',
      'cityGu': 'અમદાવાદ, ગુજરાત',
      'prarthnaDateEn': '29 August 2026',
      'prarthnaDateGu': '૨૯ ઓગસ્ટ ૨૦૨૬',
      'prarthnaTimeEn': '5:00 PM to 7:00 PM',
      'prarthnaTimeGu': 'સાંજે ૫:૦૦ થી ૭:૦૦',
      'venueEn': 'Community Cultural Hall, C.G. Road',
      'venueGu': 'સમુદાય સાંસ્કૃતિક હોલ, સી.જી. રોડ',
      'familyEn': 'Ramesh Parikh, Nisha Parikh & Parikh Family',
      'familyGu': 'રમેશ પરીખ, નિશા પરીખ અને પરીખ પરિવાર',
      'image': 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=200',
      'tributes': 45,
    },
    {
      'id': '3',
      'nameEn': 'Late Dattatray Bhaurao Kadam',
      'nameGu': 'સ્વ. દત્તાત્રય ભાઉરાવ કદમ',
      'passedDateEn': '20 August 2026',
      'passedDateGu': '૨૦ ઓગસ્ટ ૨૦૨૬',
      'ageEn': 'Age: 84 Years',
      'ageGu': 'ઉંમર: ૮૪ વર્ષ',
      'cityEn': 'Kolhapur, Maharashtra',
      'cityGu': 'કોલ્હાપુર, મહારાષ્ટ્ર',
      'prarthnaDateEn': '23 August 2026',
      'prarthnaDateGu': '૨૩ ઓગસ્ટ ૨૦૨૬',
      'prarthnaTimeEn': '10:00 AM to 12:00 PM',
      'prarthnaTimeGu': 'સવારે ૧૦:૦૦ થી ૧૨:૦૦',
      'venueEn': 'Swajan Hall, Main Road, Kolhapur',
      'venueGu': 'સ્વજન હોલ, મુખ્ય રોડ, કોલ્હાપુર',
      'familyEn': 'Akshaykumar Kadam & Kadam Family',
      'familyGu': 'અક્ષયકુમાર કદમ અને કદમ પરિવાર',
      'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
      'tributes': 18,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showAddObituaryDialog(BuildContext context, bool isGu) {
    final nameController = TextEditingController();
    final ageController = TextEditingController();
    final cityController = TextEditingController();
    final venueController = TextEditingController();
    final familyController = TextEditingController();
    String? selectedImagePath;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.88,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isGu ? 'શ્રદ્ધાંજલિ સંદેશ ઉમેરો' : 'Add Obituary Notice',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Serif',
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(ctx),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Deceased Person Image Picker
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          final result = await showDialog<String>(
                            context: context,
                            builder: (context) => const CustomImagePickerDialog(
                              isProfilePhoto: true,
                            ),
                          );
                          if (result != null) {
                            setModalState(() {
                              selectedImagePath = result;
                            });
                          }
                        },
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFF1F5F9),
                            border: Border.all(color: const Color(0xFFD9B854), width: 2),
                          ),
                          child: selectedImagePath != null && File(selectedImagePath!).existsSync()
                              ? ClipOval(child: Image.file(File(selectedImagePath!), fit: BoxFit.cover))
                              : const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_a_photo, size: 26, color: Color(0xFF856404)),
                                    SizedBox(height: 4),
                                    Text('Photo', style: TextStyle(fontSize: 10, color: Color(0xFF856404))),
                                  ],
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    _buildFieldLabel(isGu ? 'સ્વર્ગસ્થનું પૂર્ણ નામ' : 'Full Name of Deceased', isGu),
                    _buildInputField(nameController, isGu ? 'દા.ત. સ્વ. રમણલાલ જોશી' : 'e.g. Late Ramanlal Joshi'),

                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFieldLabel(isGu ? 'ઉંમર' : 'Age', isGu),
                              _buildInputField(ageController, isGu ? 'દા.ત. ૭૫' : 'e.g. 75'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFieldLabel(isGu ? 'ગામ / શહેર' : 'City / Native Place', isGu),
                              _buildInputField(cityController, isGu ? 'દા.ત. સાતારા' : 'e.g. Satara'),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),
                    _buildFieldLabel(isGu ? 'પ્રાર્થના સભા / બેસણું સ્થળ' : 'Prarthna Sabha / Besna Venue', isGu),
                    _buildInputField(venueController, isGu ? 'દા.ત. સમુદાય હોલ, સાંજે ૪ થી ૬' : 'e.g. Community Hall, 4 PM to 6 PM'),

                    const SizedBox(height: 14),
                    _buildFieldLabel(isGu ? 'શોકગ્રસ્ત પરિવાર' : 'Grief Stricken Family Members', isGu),
                    _buildInputField(familyController, isGu ? 'દા.ત. જોશી પરિવાર' : 'e.g. Joshi Family'),

                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          if (nameController.text.trim().isEmpty) return;
                          setState(() {
                            _obituaries.insert(0, {
                              'id': DateTime.now().millisecondsSinceEpoch.toString(),
                              'nameEn': nameController.text.trim(),
                              'nameGu': nameController.text.trim(),
                              'passedDateEn': 'Recently Passed',
                              'passedDateGu': 'તાજેતરમાં અવસાન',
                              'ageEn': ageController.text.trim().isNotEmpty ? 'Age: ${ageController.text.trim()}' : 'Age: --',
                              'ageGu': ageController.text.trim().isNotEmpty ? 'ઉંમર: ${ageController.text.trim()}' : 'ઉંમર: --',
                              'cityEn': cityController.text.trim().isNotEmpty ? cityController.text.trim() : 'Swajan Community',
                              'cityGu': cityController.text.trim().isNotEmpty ? cityController.text.trim() : 'સ્વજન સમુદાય',
                              'prarthnaDateEn': 'Upcoming',
                              'prarthnaDateGu': 'આવનારી તારીખ',
                              'prarthnaTimeEn': 'Evening',
                              'prarthnaTimeGu': 'સાંજના સમયે',
                              'venueEn': venueController.text.trim().isNotEmpty ? venueController.text.trim() : 'Community Bhavan',
                              'venueGu': venueController.text.trim().isNotEmpty ? venueController.text.trim() : 'સમુદાય ભવન',
                              'familyEn': familyController.text.trim().isNotEmpty ? familyController.text.trim() : 'Family & Relatives',
                              'familyGu': familyController.text.trim().isNotEmpty ? familyController.text.trim() : 'પરિવાર અને સગાંઓ',
                              'image': selectedImagePath ?? 'assets/images/sanjay_profile.png',
                              'tributes': 1,
                            });
                          });
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isGu
                                    ? 'શ્રદ્ધાંજલિ સંદેશ સફળતાપૂર્વક ઉમેરાયો'
                                    : 'Obituary notice published successfully',
                              ),
                              backgroundColor: const Color(0xFF1E232D),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E232D),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: Text(
                          isGu ? 'પ્રકાશિત કરો' : 'PUBLISH NOTICE',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFieldLabel(String label, bool isGu) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1E232D),
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 14, color: Color(0xFF1E232D)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
      ),
    );
  }

  void _showCondolenceDialog(BuildContext context, Map<String, dynamic> item, bool isGu) {
    final name = isGu ? item['nameGu'] : item['nameEn'];
    final messageController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.local_florist, color: Color(0xFF856404), size: 24),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                isGu ? 'શ્રદ્ધાંજલિ અર્પણ કરો' : 'Pay Condolence',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Serif',
                  color: Color(0xFF1E232D),
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isGu ? '$name માટે આપનો સાંત્વના સંદેશ લખો:' : 'Write your condolence message for $name:',
              style: const TextStyle(fontSize: 13, color: Color(0xFF475569)),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: messageController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: isGu ? 'ભગવાન આત્માને શાંતિ આપે...' : 'May their soul rest in eternal peace...',
                hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              isGu ? 'રદ કરો' : 'CANCEL',
              style: const TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                item['tributes'] = (item['tributes'] as int) + 1;
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isGu
                        ? 'આપનો શ્રદ્ધાંજલિ સંદેશ પરિવાર સુધી પહોંચાડવામાં આવ્યો છે'
                        : 'Your condolence tribute has been sent to the family',
                  ),
                  backgroundColor: const Color(0xFF1E232D),
                ),
              );
            },
            icon: const Icon(Icons.local_florist, size: 16),
            label: Text(isGu ? 'અર્પણ કરો' : 'SEND TRIBUTE'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF856404),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final bool isGu = lang.currentLanguage == 'gu';

    final filteredList = _obituaries.where((item) {
      final name = isGu ? item['nameGu'] : item['nameEn'];
      final city = isGu ? item['cityGu'] : item['cityEn'];
      return _searchQuery.isEmpty ||
          name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          city.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

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
          isGu ? 'શ્રદ્ધાંજલિ' : 'Obituary / Shradhanjali',
          style: const TextStyle(
            fontFamily: 'Serif',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E232D),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home_outlined, color: Color(0xFF1E232D)),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => HomeScreen(userName: widget.userName),
                ),
                (route) => false,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Color(0xFF856404)),
            onPressed: () => _showAddObituaryDialog(context, isGu),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Dark Memorial Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF161E2E),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2D3748),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.local_florist, color: Color(0xFFD9B854), size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isGu ? 'ભાવપૂર્ણ શ્રદ્ધાંજલિ' : 'Heartfelt Condolences',
                          style: const TextStyle(
                            color: Color(0xFFD9B854),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: 'Serif',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isGu
                              ? 'સમુદાયના સ્વર્ગસ્થ આત્માઓને આપણી નમ્ર શ્રદ્ધાંજલિ.'
                              : 'Honoring and remembering our departed Swajan community members.',
                          style: const TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 12,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _searchQuery = v),
                decoration: InputDecoration(
                  hintText: isGu ? 'નામ અથવા શહેરથી શોધો...' : 'Search by name or city...',
                  hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF64748B), size: 20),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Obituaries List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final item = filteredList[index];
                final name = isGu ? item['nameGu'] : item['nameEn'];
                final passedDate = isGu ? item['passedDateGu'] : item['passedDateEn'];
                final age = isGu ? item['ageGu'] : item['ageEn'];
                final city = isGu ? item['cityGu'] : item['cityEn'];
                final prarthnaDate = isGu ? item['prarthnaDateGu'] : item['prarthnaDateEn'];
                final prarthnaTime = isGu ? item['prarthnaTimeGu'] : item['prarthnaTimeEn'];
                final venue = isGu ? item['venueGu'] : item['venueEn'];
                final family = isGu ? item['familyGu'] : item['familyEn'];
                final tributes = item['tributes'] as int;

                return Container(
                  margin: const EdgeInsets.only(bottom: 18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Card Top Header
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Color(0xFFFAFAFC),
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
                        ),
                        child: Row(
                          children: [
                            // Member Photo with Gold Ring
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: const Color(0xFFD9B854), width: 2.5),
                              ),
                              child: ClipOval(
                                child: (item['image'] as String).startsWith('http')
                                    ? Image.network(item['image'], fit: BoxFit.cover)
                                    : (File(item['image']).existsSync()
                                        ? Image.file(File(item['image']), fit: BoxFit.cover)
                                        : Image.asset(item['image'], fit: BoxFit.cover)),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: const TextStyle(
                                      fontFamily: 'Serif',
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E232D),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        passedDate,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFFDC2626),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '• $age',
                                        style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    city,
                                    style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Prarthna Sabha / Besna Details Box
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFBEB),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: const Color(0xFFFDE68A)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.access_time_filled, size: 16, color: Color(0xFF856404)),
                                      const SizedBox(width: 6),
                                      Text(
                                        isGu ? 'બેસણું / પ્રાર્થના સભા' : 'BESNA / PRAYER MEET',
                                        style: const TextStyle(
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF856404),
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '$prarthnaDate ($prarthnaTime)',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E232D),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    venue,
                                    style: const TextStyle(fontSize: 12.5, color: Color(0xFF475569)),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Grief Stricken Family
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.people_outline, size: 16, color: Color(0xFF64748B)),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style: const TextStyle(fontSize: 12.5, color: Color(0xFF475569)),
                                      children: [
                                        TextSpan(
                                          text: isGu ? 'શોકગ્રસ્ત: ' : 'Grief Stricken: ',
                                          style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E232D)),
                                        ),
                                        TextSpan(text: family),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Card Actions Row
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () => _showCondolenceDialog(context, item, isGu),
                                    icon: const Icon(Icons.local_florist, size: 16),
                                    label: Text(
                                      isGu ? 'શ્રદ્ધાંજલિ ($tributes)' : 'Pay Tribute ($tributes)',
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF856404),
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                OutlinedButton.icon(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          isGu ? 'શ્રદ્ધાંજલિ સંદેશ શેર થઈ રહ્યો છે...' : 'Sharing obituary notice...',
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.share_outlined, size: 16, color: Color(0xFF1E232D)),
                                  label: Text(
                                    isGu ? 'શેર' : 'Share',
                                    style: const TextStyle(color: Color(0xFF1E232D), fontSize: 12),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        userName: widget.userName,
      ),
    );
  }
}
