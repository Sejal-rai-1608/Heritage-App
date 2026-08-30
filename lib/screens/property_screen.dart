import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../widgets/custom_bottom_navbar.dart';
import 'home_screen.dart';
import 'image_picker_dialog.dart';

class PropertyScreen extends StatefulWidget {
  final String? userName;
  const PropertyScreen({super.key, this.userName});

  @override
  State<PropertyScreen> createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _properties = [
    {
      'id': '1',
      'titleEn': 'Luxurious 3 BHK Premium Apartment',
      'titleGu': 'આલીશાન ૩ બીએચકે પ્રીમિયમ એપાર્ટમેન્ટ',
      'listingTypeEn': 'FOR SALE',
      'listingTypeGu': 'વેચાણ માટે',
      'priceEn': '₹85.00 Lakhs',
      'priceGu': '₹૮૫.૦૦ લાખ',
      'cityEn': 'C.G. Road, Ahmedabad',
      'cityGu': 'સી.જી. રોડ, અમદાવાદ',
      'sizeEn': '1,650 sq.ft',
      'sizeGu': '૧,૬૫૦ ચો.ફૂટ',
      'bedsEn': '3 BHK',
      'bedsGu': '૩ બીએચકે',
      'bathsEn': '3 Baths',
      'bathsGu': '૩ બાથરૂમ',
      'categoryEn': 'Residential',
      'categoryGu': 'રેસિડેન્શિયલ',
      'ownerNameEn': 'Jayeshbhai Patel',
      'ownerNameGu': 'જયેશભાઈ પટેલ',
      'ownerPhone': '+91 98250 12345',
      'descEn': 'Spacious 3 BHK apartment in prime gated community with covered parking, 24/7 security, club house, and modular kitchen.',
      'descGu': 'કવર્ડ પાર્કિંગ, ૨૪/૭ સુરક્ષા, ક્લબ હાઉસ અને મોડ્યુલર કિચન સાથે પ્રાઇમ લોકેશનમાં આલીશાન ૩ બીએચકે એપાર્ટમેન્ટ.',
      'image': 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=600',
      'isVerified': true,
    },
    {
      'id': '2',
      'titleEn': 'Prime Commercial Office Space',
      'titleGu': 'પ્રાઇમ કોમર્શિયલ ઓફિસ સ્પેસ',
      'listingTypeEn': 'FOR RENT',
      'listingTypeGu': 'ભાડા માટે',
      'priceEn': '₹35,000 / month',
      'priceGu': '₹૩૫,૦૦૦ / મહિનો',
      'cityEn': 'Alkapuri, Vadodara',
      'cityGu': 'અલકાપુરી, વડોદરા',
      'sizeEn': '950 sq.ft',
      'sizeGu': '૯૫૦ ચો.ફૂટ',
      'bedsEn': 'Office',
      'bedsGu': 'ઓફિસ',
      'bathsEn': '1 Bath',
      'bathsGu': '૧ બાથરૂમ',
      'categoryEn': 'Commercial',
      'categoryGu': 'કોમર્શિયલ',
      'ownerNameEn': 'Rameshchandra Joshi',
      'ownerNameGu': 'રમેશચંદ્ર જોશી',
      'ownerPhone': '+91 98765 43210',
      'descEn': 'Fully furnished corporate office with 12 workstations, manager cabin, conference room, and high-speed elevator access.',
      'descGu': '૧૨ વર્કસ્ટેશન, મેનેજર કેબિન અને કોન્ફરન્સ રૂમ સાથે સંપૂર્ણ ફર્નિશ્ડ કોર્પોરેટ ઓફિસ.',
      'image': 'https://images.unsplash.com/photo-1497366216548-37526070297c?w=600',
      'isVerified': true,
    },
    {
      'id': '3',
      'titleEn': 'NA Approved Residential Plot Land',
      'titleGu': 'એન.એ. મંજૂર રેસિડેન્શિયલ પ્લોટ જમીન',
      'listingTypeEn': 'FOR SALE',
      'listingTypeGu': 'વેચાણ માટે',
      'priceEn': '₹45.00 Lakhs',
      'priceGu': '₹૪૫.૦૦ લાખ',
      'cityEn': 'Satara Road, Maharashtra',
      'cityGu': 'સાતારા રોડ, મહારાષ્ટ્ર',
      'sizeEn': '2,400 sq.ft',
      'sizeGu': '૨,૪૦૦ ચો.ફૂટ',
      'bedsEn': 'Plot',
      'bedsGu': 'પ્લોટ',
      'bathsEn': 'N/A',
      'bathsGu': 'લાગુ નથી',
      'categoryEn': 'Plots',
      'categoryGu': 'પ્લોટ્સ / જમીન',
      'ownerNameEn': 'Aditya More',
      'ownerNameGu': 'આદિત્ય મોરે',
      'ownerPhone': '+91 94220 67890',
      'descEn': 'Clear title NA plot in rapidly developing residential zone near highway with water and electricity connectivity.',
      'descGu': 'હાઇવે નજીક ઝડપથી વિકસતા વિસ્તારમાં પાણી અને વીજળીની સુવિધા સાથે ક્લિયર ટાઇટલ એન.એ. પ્લોટ.',
      'image': 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=600',
      'isVerified': true,
    },
    {
      'id': '4',
      'titleEn': 'Modern 2 BHK Gated Society Flat',
      'titleGu': 'આધુનિક ૨ બીએચકે ગેટ સોસાયટી ફ્લેટ',
      'listingTypeEn': 'FOR RENT',
      'listingTypeGu': 'ભાડા માટે',
      'priceEn': '₹18,000 / month',
      'priceGu': '₹૧૮,૦૦૦ / મહિનો',
      'cityEn': 'Kharghar, Navi Mumbai',
      'cityGu': 'ખારઘર, નવી મુંબઈ',
      'sizeEn': '1,100 sq.ft',
      'sizeGu': '૧,૧૦૦ ચો.ફૂટ',
      'bedsEn': '2 BHK',
      'bedsGu': '૨ બીએચકે',
      'bathsEn': '2 Baths',
      'bathsGu': '૨ બાથરૂમ',
      'categoryEn': 'Residential',
      'categoryGu': 'રેસિડેન્શિયલ',
      'ownerNameEn': 'Sunil Parikh',
      'ownerNameGu': 'સુનિલ પરીખ',
      'ownerPhone': '+91 97123 45678',
      'descEn': 'Ready to move 2 BHK apartment with balcony, garden view, children play area, and close to metro station.',
      'descGu': 'બાલકની, ગાર્ડન વ્યૂ, ચિલ્ડ્રન પ્લે એરિયા અને મેટ્રો સ્ટેશન નજીક તૈયાર ૨ બીએચકે ફ્લેટ.',
      'image': 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=600',
      'isVerified': true,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showPropertyDetailsModal(BuildContext context, Map<String, dynamic> prop, bool isGu) {
    final title = isGu ? prop['titleGu'] : prop['titleEn'];
    final listingType = isGu ? prop['listingTypeGu'] : prop['listingTypeEn'];
    final price = isGu ? prop['priceGu'] : prop['priceEn'];
    final city = isGu ? prop['cityGu'] : prop['cityEn'];
    final size = isGu ? prop['sizeGu'] : prop['sizeEn'];
    final beds = isGu ? prop['bedsGu'] : prop['bedsEn'];
    final baths = isGu ? prop['bathsGu'] : prop['bathsEn'];
    final ownerName = isGu ? prop['ownerNameGu'] : prop['ownerNameEn'];
    final desc = isGu ? prop['descGu'] : prop['descEn'];
    final image = prop['image'] as String?;
    final isSale = prop['listingTypeEn'] == 'FOR SALE';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.88,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 32),
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Color(0xFF64748B)),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Property Image Card
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            (image != null && image.isNotEmpty)
                                ? (image.startsWith('http')
                                    ? Image.network(image, width: double.infinity, height: 220, fit: BoxFit.cover)
                                    : (File(image).existsSync()
                                        ? Image.file(File(image), width: double.infinity, height: 220, fit: BoxFit.cover)
                                        : Image.asset(image, width: double.infinity, height: 220, fit: BoxFit.cover)))
                                : Container(width: double.infinity, height: 220, color: const Color(0xFFF1F5F9), child: const Icon(Icons.apartment, size: 60, color: Color(0xFF94A3B8))),
                            Positioned(
                              top: 14,
                              left: 14,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: isSale ? const Color(0xFFDC2626) : const Color(0xFF2563EB),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  listingType,
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 0.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Title & Price
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Serif',
                                color: Color(0xFF0F172A),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            price,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF16A34A),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, color: Color(0xFF64748B), size: 16),
                          const SizedBox(width: 4),
                          Text(city, style: const TextStyle(fontSize: 13, color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
                        ],
                      ),
                      const SizedBox(height: 18),

                      // Specs Grid Box
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildSpecCol(Icons.square_foot, isGu ? 'વિસ્તાર' : 'Area Size', size),
                            Container(width: 1, height: 36, color: const Color(0xFFE2E8F0)),
                            _buildSpecCol(Icons.king_bed_outlined, isGu ? 'બીએચકે / કારપેટ' : 'Type', beds),
                            Container(width: 1, height: 36, color: const Color(0xFFE2E8F0)),
                            _buildSpecCol(Icons.bathtub_outlined, isGu ? 'બાથરૂમ' : 'Baths', baths),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Description Section
                      Text(
                        isGu ? 'મિલકતની વિગતો' : 'Property Description',
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        desc,
                        style: const TextStyle(fontSize: 13.5, color: Color(0xFF64748B), height: 1.45),
                      ),
                      const SizedBox(height: 20),

                      // Owner / Seller Info Box
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF9C3),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFFCD34D)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: const BoxDecoration(
                                color: Color(0xFF854D0E),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.person, color: Colors.white, size: 24),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isGu ? 'માલિક / એજન્ટ' : 'Owner / Listing Contact',
                                    style: const TextStyle(fontSize: 11, color: Color(0xFF854D0E), fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ownerName,
                                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Call & WhatsApp Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isGu
                                          ? '${prop['ownerPhone']} પર માલિકને કોલ કરી રહ્યા છીએ...'
                                          : 'Calling owner at ${prop['ownerPhone']}...',
                                    ),
                                    backgroundColor: const Color(0xFF0F172A),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.call, size: 18),
                              label: Text(
                                isGu ? 'માલિકને કોલ કરો' : 'Call Owner',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0F172A),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isGu
                                          ? '${prop['ownerPhone']} પર વોટ્સએપ મેસેજ કરી રહ્યા છીએ...'
                                          : 'Opening WhatsApp for ${prop['ownerPhone']}...',
                                    ),
                                    backgroundColor: const Color(0xFF15803D),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.chat_bubble_outline, size: 18),
                              label: Text(
                                isGu ? 'વોટ્સએપ' : 'WhatsApp',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFCD34D),
                                foregroundColor: const Color(0xFF0F172A),
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSpecCol(IconData icon, String title, String val) {
    return Column(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF854D0E)),
        const SizedBox(height: 4),
        Text(val, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
        Text(title, style: const TextStyle(fontSize: 10.5, color: Color(0xFF64748B))),
      ],
    );
  }

  void _showPostPropertyDialog(BuildContext context, bool isGu) {
    final titleController = TextEditingController();
    final priceController = TextEditingController();
    final cityController = TextEditingController();
    final sizeController = TextEditingController();
    final ownerController = TextEditingController();
    final phoneController = TextEditingController();
    final descController = TextEditingController();
    String selectedListingType = 'FOR SALE';
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
                          isGu ? 'મિલકતની જાહેરાત ઉમેરો' : 'Add Property Listing',
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

                    // Photo Picker Box
                    GestureDetector(
                      onTap: () async {
                        final result = await showDialog<String>(
                          context: context,
                          builder: (context) => const CustomImagePickerDialog(
                            isProfilePhoto: false,
                          ),
                        );
                        if (result != null) {
                          setModalState(() {
                            selectedImagePath = result;
                          });
                        }
                      },
                      child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: selectedImagePath != null && selectedImagePath!.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: File(selectedImagePath!).existsSync()
                                    ? Image.file(File(selectedImagePath!), fit: BoxFit.cover)
                                    : Image.asset('assets/images/sanjay_profile.png', fit: BoxFit.cover),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.add_a_photo_outlined, size: 28, color: Color(0xFF854D0E)),
                                  const SizedBox(height: 8),
                                  Text(
                                    isGu ? 'મિલકતનો ફોટો પસંદ કરવા ટેપ કરો' : 'Tap to add property photo',
                                    style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    _buildFieldLabel(isGu ? 'મિલકતનું શીર્ષક' : 'Property Title', isGu),
                    _buildInputField(titleController, isGu ? 'દા.ત. આલીશાન ૩ બીએચકે ફ્લેટ' : 'e.g. Luxurious 3 BHK Flat'),

                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFieldLabel(isGu ? 'કિંમત / ભાડું' : 'Price / Rent', isGu),
                              _buildInputField(priceController, isGu ? 'દા.ત. ₹૫૦ લાખ' : 'e.g. ₹50 Lakhs'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFieldLabel(isGu ? 'વિસ્તાર (ચો.ફૂટ)' : 'Area (sq.ft)', isGu),
                              _buildInputField(sizeController, isGu ? 'દા.ત. ૧,૫૦૦ ચો.ફૂટ' : 'e.g. 1,500 sq.ft'),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),
                    _buildFieldLabel(isGu ? 'શહેર / સરનામું' : 'Location / City', isGu),
                    _buildInputField(cityController, isGu ? 'દા.ત. સી.જી. રોડ, અમદાવાદ' : 'e.g. C.G. Road, Ahmedabad'),

                    const SizedBox(height: 14),
                    _buildFieldLabel(isGu ? 'માલિકનું નામ અને નંબર' : 'Owner Name & Phone', isGu),
                    Row(
                      children: [
                        Expanded(child: _buildInputField(ownerController, isGu ? 'નામ' : 'Name')),
                        const SizedBox(width: 10),
                        Expanded(child: _buildInputField(phoneController, isGu ? '૧૦-અંક નંબર' : 'Phone')),
                      ],
                    ),

                    const SizedBox(height: 14),
                    _buildFieldLabel(isGu ? 'મિલકત વર્ણન' : 'Description & Facilities', isGu),
                    _buildInputField(descController, isGu ? 'સુવિધાઓ અને વિગતો લખો...' : 'Describe features and amenities...'),

                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          if (titleController.text.trim().isEmpty) return;
                          setState(() {
                            _properties.insert(0, {
                              'id': DateTime.now().millisecondsSinceEpoch.toString(),
                              'titleEn': titleController.text.trim(),
                              'titleGu': titleController.text.trim(),
                              'listingTypeEn': selectedListingType,
                              'listingTypeGu': isGu ? 'વેચાણ માટે' : 'FOR SALE',
                              'priceEn': priceController.text.trim().isNotEmpty ? priceController.text.trim() : 'On Request',
                              'priceGu': priceController.text.trim().isNotEmpty ? priceController.text.trim() : 'પૂછપરછ પર',
                              'cityEn': cityController.text.trim().isNotEmpty ? cityController.text.trim() : 'Ahmedabad',
                              'cityGu': cityController.text.trim().isNotEmpty ? cityController.text.trim() : 'અમદાવાદ',
                              'sizeEn': sizeController.text.trim().isNotEmpty ? sizeController.text.trim() : '1,200 sq.ft',
                              'sizeGu': sizeController.text.trim().isNotEmpty ? sizeController.text.trim() : '૧,૨૦૦ ચો.ફૂટ',
                              'bedsEn': 'Property',
                              'bedsGu': 'મિલકત',
                              'bathsEn': 'N/A',
                              'bathsGu': 'લાગુ નથી',
                              'categoryEn': 'Residential',
                              'categoryGu': 'રેસિડેન્શિયલ',
                              'ownerNameEn': ownerController.text.trim().isNotEmpty ? ownerController.text.trim() : 'Property Owner',
                              'ownerNameGu': ownerController.text.trim().isNotEmpty ? ownerController.text.trim() : 'મિલકત માલિક',
                              'ownerPhone': phoneController.text.trim().isNotEmpty ? phoneController.text.trim() : '+91 98765 43210',
                              'descEn': descController.text.trim().isNotEmpty ? descController.text.trim() : 'Contact owner for complete site visit details.',
                              'descGu': descController.text.trim().isNotEmpty ? descController.text.trim() : 'સાઇટ વિઝિટ વિગતો માટે માલિકનો સંપર્ક કરો.',
                              'image': selectedImagePath ?? 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=600',
                              'isVerified': true,
                            });
                          });
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isGu
                                    ? 'મિલકતની જાહેરાત સફળતાપૂર્વક પોસ્ટ કરવામાં આવી છે!'
                                    : 'Property listing published successfully!',
                              ),
                              backgroundColor: const Color(0xFF0F172A),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFCD34D),
                          foregroundColor: const Color(0xFF0F172A),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: Text(
                          isGu ? 'જાહેરાત પોસ્ટ કરો' : 'PUBLISH PROPERTY',
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 14, color: Color(0xFF0F172A)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final bool isGu = lang.currentLanguage == 'gu';

    final filteredList = _properties.where((p) {
      final title = isGu ? p['titleGu'] : p['titleEn'];
      final city = isGu ? p['cityGu'] : p['cityEn'];
      final category = p['categoryEn'] as String;
      final listingType = p['listingTypeEn'] as String;

      final matchesSearch = _searchQuery.isEmpty ||
          title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          city.toLowerCase().contains(_searchQuery.toLowerCase());

      bool matchesFilter = true;
      if (_selectedFilter == 'For Sale') {
        matchesFilter = listingType == 'FOR SALE';
      } else if (_selectedFilter == 'For Rent') {
        matchesFilter = listingType == 'FOR RENT';
      } else if (_selectedFilter == 'Residential') {
        matchesFilter = category == 'Residential';
      } else if (_selectedFilter == 'Commercial') {
        matchesFilter = category == 'Commercial';
      } else if (_selectedFilter == 'Plots') {
        matchesFilter = category == 'Plots';
      }

      return matchesSearch && matchesFilter;
    }).toList();

    final filterList = [
      {'en': 'All', 'gu': 'બધા'},
      {'en': 'For Sale', 'gu': 'વેચાણ માટે'},
      {'en': 'For Rent', 'gu': 'ભાડા માટે'},
      {'en': 'Residential', 'gu': 'રેસિડેન્શિયલ'},
      {'en': 'Commercial', 'gu': 'કોમર્શિયલ'},
      {'en': 'Plots', 'gu': 'પ્લોટ્સ'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isGu ? 'મિલકત અને રિયલ એસ્ટેટ' : 'Real Estate & Property',
          style: const TextStyle(
            fontFamily: 'Serif',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home_outlined, color: Color(0xFF0F172A)),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => HomeScreen(userName: widget.userName),
                ),
                (route) => false,
              );
            },
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 14.0),
              child: GestureDetector(
                onTap: () => _showPostPropertyDialog(context, isGu),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFCD34D),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.add, size: 16, color: Color(0xFF0F172A)),
                      const SizedBox(width: 4),
                      Text(
                        isGu ? 'મિલકત ઉમેરો' : 'Post Property',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Hero Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1E293B),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.apartment_rounded, color: Color(0xFFFCD34D), size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isGu ? 'સમુદાય રિયલ એસ્ટેટ' : 'SWAJAN REAL ESTATE',
                          style: const TextStyle(
                            color: Color(0xFFFCD34D),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isGu
                              ? 'અમારા સમુદાયના સભ્યોની શ્રેષ્ઠ મિલકતો ખરીદો, વેચો અથવા ભાડે આપો.'
                              : 'Verified residential, commercial & plot listings from community members.',
                          style: const TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 12.5,
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
                  hintText: isGu ? 'મિલકત, સ્થળ અથવા શહેરથી શોધો...' : 'Search by title, location or city...',
                  hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF64748B), size: 20),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: filterList.map((f) {
                  final key = f['en']!;
                  final label = isGu ? f['gu']! : f['en']!;
                  final isSelected = _selectedFilter == key;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedFilter = key),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFFCD34D) : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          label,
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected ? const Color(0xFF0F172A) : const Color(0xFF475569),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            // Property List
            if (filteredList.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Text(
                    isGu ? 'કોઈ મિલકત મળેલ નથી.' : 'No property listings found.',
                    style: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final prop = filteredList[index];
                  final title = isGu ? prop['titleGu'] : prop['titleEn'];
                  final listingType = isGu ? prop['listingTypeGu'] : prop['listingTypeEn'];
                  final price = isGu ? prop['priceGu'] : prop['priceEn'];
                  final city = isGu ? prop['cityGu'] : prop['cityEn'];
                  final size = isGu ? prop['sizeGu'] : prop['sizeEn'];
                  final beds = isGu ? prop['bedsGu'] : prop['bedsEn'];
                  final image = prop['image'] as String?;
                  final isSale = prop['listingTypeEn'] == 'FOR SALE';

                  return Container(
                    margin: const EdgeInsets.only(bottom: 18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFF1F5F9)),
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
                        // Property Image
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                          child: Stack(
                            children: [
                              (image != null && image.isNotEmpty)
                                  ? (image.startsWith('http')
                                      ? Image.network(image, width: double.infinity, height: 180, fit: BoxFit.cover)
                                      : (File(image).existsSync()
                                          ? Image.file(File(image), width: double.infinity, height: 180, fit: BoxFit.cover)
                                          : Image.asset(image, width: double.infinity, height: 180, fit: BoxFit.cover)))
                                  : Container(width: double.infinity, height: 180, color: const Color(0xFFF1F5F9), child: const Icon(Icons.apartment, size: 50, color: Color(0xFF94A3B8))),
                              Positioned(
                                top: 12,
                                left: 12,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isSale ? const Color(0xFFDC2626) : const Color(0xFF2563EB),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    listingType,
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10.5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Serif',
                                        color: Color(0xFF0F172A),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    price,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF16A34A),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),

                              Row(
                                children: [
                                  const Icon(Icons.location_on_outlined, color: Color(0xFF64748B), size: 15),
                                  const SizedBox(width: 4),
                                  Text(city, style: const TextStyle(fontSize: 12.5, color: Color(0xFF64748B))),
                                ],
                              ),
                              const SizedBox(height: 12),

                              Row(
                                children: [
                                  _buildMiniTag(Icons.straighten, size),
                                  const SizedBox(width: 8),
                                  _buildMiniTag(Icons.king_bed_outlined, beds),
                                ],
                              ),
                              const SizedBox(height: 16),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () => _showPropertyDetailsModal(context, prop, isGu),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFCD34D),
                                    foregroundColor: const Color(0xFF0F172A),
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        isGu ? 'મિલકત વિગતો જુઓ' : 'View Property Details',
                                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 6),
                                      const Icon(Icons.arrow_forward, size: 16, color: Color(0xFF0F172A)),
                                    ],
                                  ),
                                ),
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

  Widget _buildMiniTag(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: const Color(0xFF475569)),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
        ],
      ),
    );
  }
}
