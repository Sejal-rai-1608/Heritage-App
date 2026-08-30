import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'image_picker_dialog.dart';

String _getCategoryNameLabel(String catName, bool isGu) {
  if (!isGu) return catName;
  switch (catName) {
    case 'Accountant':
      return 'અકાઉન્ટન્ટ';
    case 'Administration Professional':
      return 'એડમિનિસ્ટ્રેશન પ્રોફેશનલ';
    case 'Advertising Professional':
      return 'એડવર્ટાઇઝિંગ પ્રોફેશનલ';
    case 'Agriculture & Farming':
      return 'કૃષિ અને ખેતી';
    case 'Architectural & Civil Engineering':
      return 'આર્કિટેક્ચરલ અને સિવિલ એન્જિનિયરિંગ';
    case 'Ayurvedic & Herbal Products':
      return 'આયુર્વેદિક અને હર્બલ પ્રોડક્ટ્સ';
    case 'Baby / Pre School':
      return 'બેબી / પ્રી સ્કૂલ';
    case 'Banker':
      return 'બેંકર';
    case 'Battery & Storage Devices':
      return 'બેટરી અને સ્ટોરેજ સાધનો';
    case 'Beautician':
      return 'બ્યુટીશિયન';
    case 'Books & Stationery':
      return 'બુક્સ અને સ્ટેશનરી';
    case 'Building & Construction':
      return 'બિલ્ડિંગ અને કન્સ્ટ્રક્શન';
    case 'Business':
      return 'વ્યવસાય (બિઝનેસ)';
    case 'Chartered Accountant':
      return 'ચાર્ટર્ડ અકાઉન્ટન્ટ';
    case 'Civil Engineer':
      return 'સિવિલ એન્જિનિયર';
    case 'Computer & IT Solutions':
      return 'કોમ્પ્યુટર અને આઇટી સોલ્યુશન્સ';
    case 'Computer Hardware & System':
      return 'કોમ્પ્યુટર હાર્ડવેર અને સિસ્ટમ';
    case 'Computer Manufacturers & Assemblers':
      return 'કોમ્પ્યુટર મેન્યુફેક્ચરર્સ';
    case 'Computer/IT Professional':
      return 'કોમ્પ્યુટર/આઇટી પ્રોફેશનલ';
    case 'Contractor':
      return 'કોન્ટ્રાક્ટર';
    case 'Contractors & Freelancers':
      return 'કોન્ટ્રાક્ટર્સ અને ફ્રીલાન્સર્સ';
    case 'Cosmetics & Personal Care':
      return 'કોસ્મેટિક્સ અને પર્સનલ કેર';
    case 'Creative Person':
      return 'ક્રિએટિવ પર્સન';
    case 'Customer Support Professional':
      return 'કસ્ટમર સપોર્ટ પ્રોફેશનલ';
    case 'Designer':
      return 'ડિઝાઇનર';
    default:
      return catName;
  }
}

String _getSectorNameLabel(String sector, bool isGu) {
  if (!isGu) return sector;
  switch (sector) {
    case 'All Sectors':
      return 'બધા ક્ષેત્રો';
    case 'Tech':
      return 'ટેકનોલોજી';
    case 'Finance':
      return 'નાણાકીય';
    case 'Creative':
      return 'રચનાત્મક';
    case 'Healthcare':
      return 'આરોગ્ય';
    case 'Engineering':
      return 'એન્જિનિયરિંગ';
    default:
      return sector;
  }
}

String _getBusinessMemberNameLabel(String name, bool isGu) {
  if (!isGu) return name;
  switch (name) {
    case 'Deepak Jayesh Trivedi':
      return 'દીપક જયેશ ત્રિવેદી';
    case 'Nisha Rajesh Parikh':
      return 'નિશા રાજેશ પરીખ';
    case 'Bharat Gandhi':
      return 'ભરત ગાંધી';
    case 'Karan Desai':
      return 'કરણ દેસાઈ';
    case 'Ramesh H. Patel':
      return 'રમેશ એચ. પટેલ';
    case 'Sunita K. Joshi':
      return 'સુનિતા કે. જોશી';
    case 'Akshaykumar Rajkumar Kadam':
      return 'અક્ષયકુમાર રાજકુમાર કદમ';
    case 'Pravin Mahadeo Modak':
      return 'પ્રવિણ મહાદેવ મોડક';
    case 'Aparna Vidhyadhar Khamkar':
      return 'અપર્ણા વિદ્યાધર ખામકર';
    case 'Akshay Prakash Jadhav':
      return 'અક્ષય પ્રકાશ જાધવ';
    case 'Madhuri Santosh Mane':
      return 'માધુરી સંતોષ માને';
    case 'Swati Anil Satpute':
      return 'સ્વાતી અનિલ સાતપુતે';
    case 'Ajitbhai Vinayak Beloshe':
      return 'અજિતભાઈ વિનાયક બેલોશે';
    default:
      return name;
  }
}

String _getBusinessLocationLabel(String city, String area, bool isGu) {
  if (!isGu) return '$city, $area';
  
  String translateCity(String c) {
    switch (c) {
      case 'Kolhapur': return 'કોલ્હાપુર';
      case 'Kharghar': return 'ખારઘર';
      case 'Modakwadi': return 'મોડકવાડી';
      case 'Ghansoli': return 'ઘનસોલી';
      case 'Vilavade': return 'વિલવડે';
      case 'Satara': return 'સાતારા';
      case 'Girewadi': return 'ગીરેવાડી';
      case 'Shive': return 'શિવે';
      case 'Vesava': return 'વેસવા';
      case 'Ruighar': return 'રૂઈઘર';
      case 'Ahmedabad': return 'અમદાવાદ';
      case 'Surat': return 'સુરત';
      case 'Rajkot': return 'રાજકોટ';
      case 'Vadodara': return 'વડોદરા';
      default: return c;
    }
  }

  String translateArea(String a) {
    switch (a) {
      case 'Kolhapur': return 'કોલ્હાપુર';
      case 'Kharghar': return 'ખારઘર';
      case 'J.M. Road': return 'જે.એમ. રોડ';
      case 'Panvel City': return 'પનવેલ સિટી';
      case 'Kopar Khairne': return 'કોપર ખેરણે';
      case 'C.G. Road': return 'સી.જી. રોડ';
      case 'Adajan': return 'અડાજણ';
      case 'Kalavad Road': return 'કાલાવડ રોડ';
      case 'Alkapuri': return 'અલકાપુરી';
      case 'Paldi': return 'પાલડી';
      case 'Gotri': return 'ગોત્રી';
      default: return a;
    }
  }

  return '${translateCity(city)}, ${translateArea(area)}';
}

String _getBusinessRoleLabel(String role, bool isGu) {
  if (!isGu) return role;
  final r = role.toUpperCase();
  if (r.contains('SENIOR ACCOUNTANT')) return 'વરિષ્ઠ અકાઉન્ટન્ટ';
  if (r.contains('CHARTERED ACCOUNTANT')) return 'ચાર્ટર્ડ અકાઉન્ટન્ટ';
  if (r.contains('ACCOUNTANT')) return 'અકાઉન્ટન્ટ';
  if (r.contains('SENIOR BANKER')) return 'વરિષ્ઠ બેંકર';
  if (r.contains('BRANCH MANAGER')) return 'બ્રાન્ચ મેનેજર';
  if (r.contains('BANKER')) return 'બેંકર';
  if (r.contains('STRUCTURAL ENGINEER')) return 'સ્ટ્રક્ચરલ એન્જિનિયર';
  if (r.contains('CIVIL ENGINEER')) return 'સિવિલ એન્જિનિયર';
  if (r.contains('ARCHITECTURAL')) return 'આર્કિટેક્ચરલ એન્જિનિયર';
  if (r.contains('SOFTWARE ENGINEER')) return 'સોફ્ટવેર એન્જિનિયર';
  if (r.contains('IT PROFESSIONAL') || r.contains('COMPUTER')) return 'આઇટી પ્રોફેશનલ';
  if (r.contains('CONTRACTOR')) return 'કોન્ટ્રાક્ટર';
  if (r.contains('DESIGNER')) return 'ડિઝાઇનર';
  if (r.contains('BEAUTICIAN')) return 'બ્યુટીશિયન';
  if (r.contains('ADMINISTRATION')) return 'એડમિનિસ્ટ્રેશન પ્રોફેશનલ';
  if (r.contains('ADVERTISING')) return 'એડવર્ટાઇઝિંગ પ્રોફેશનલ';
  if (r.contains('AGRICULTURE')) return 'કૃષિ નિષ્ણાત';
  if (r.contains('AYURVEDIC')) return 'આયુર્વેદિક નિષ્ણાત';
  if (r.contains('CUSTOMER SUPPORT')) return 'કસ્ટમર સપોર્ટ';
  if (r.contains('CREATIVE')) return 'ક્રિએટિવ પર્સન';
  if (r.contains('BUSINESS')) return 'વ્યવસાયિક';

  return role;
}

String _getGujaratiNumberString(String numStr, bool isGu) {
  if (!isGu) return numStr;
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const gujarati = ['૦', '૧', '૨', '૩', '૪', '૫', '૬', '૭', '૮', '૯'];
  String result = numStr;
  for (int i = 0; i < english.length; i++) {
    result = result.replaceAll(english[i], gujarati[i]);
  }
  return result;
}

class BusinessDirectoryScreen extends StatefulWidget {
  const BusinessDirectoryScreen({super.key});

  @override
  State<BusinessDirectoryScreen> createState() =>
      _BusinessDirectoryScreenState();
}

class _BusinessDirectoryScreenState extends State<BusinessDirectoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  static const List<Map<String, dynamic>> _categoriesData = [
    {'name': 'Accountant', 'defaultCount': 7},
    {'name': 'Administration Professional', 'defaultCount': 2},
    {'name': 'Advertising Professional', 'defaultCount': 2},
    {'name': 'Agriculture & Farming', 'defaultCount': 2},
    {'name': 'Architectural & Civil Engineering', 'defaultCount': 1},
    {'name': 'Ayurvedic & Herbal Products', 'defaultCount': 1},
    {'name': 'Baby / Pre School', 'defaultCount': 1},
    {'name': 'Banker', 'defaultCount': 5},
    {'name': 'Battery & Storage Devices', 'defaultCount': 1},
    {'name': 'Beautician', 'defaultCount': 1},
    {'name': 'Books & Stationery', 'defaultCount': 1},
    {'name': 'Building & Construction', 'defaultCount': 2},
    {'name': 'Business', 'defaultCount': 54},
    {'name': 'Chartered Accountant', 'defaultCount': 1},
    {'name': 'Civil Engineer', 'defaultCount': 1},
    {'name': 'Computer & IT Solutions', 'defaultCount': 2},
    {'name': 'Computer Hardware & System', 'defaultCount': 1},
    {'name': 'Computer Manufacturers & Assemblers', 'defaultCount': 1},
    {'name': 'Computer/IT Professional', 'defaultCount': 10},
    {'name': 'Contractor', 'defaultCount': 4},
    {'name': 'Contractors & Freelancers', 'defaultCount': 1},
    {'name': 'Cosmetics & Personal Care', 'defaultCount': 1},
    {'name': 'Creative Person', 'defaultCount': 1},
    {'name': 'Customer Support Professional', 'defaultCount': 1},
    {'name': 'Designer', 'defaultCount': 3},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showAddBusinessDialog(BuildContext context, bool isGu) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 32),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 4,
                  decoration: const BoxDecoration(
                    color: Color(0xFF9A7B38),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 26, 24, 26),
                  child: Column(
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFEF9C3),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.work,
                          color: Color(0xFF854D0E),
                          size: 26,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        isGu ? 'વ્યવસાય' : 'Business',
                        style: const TextStyle(
                          color: Color(0xFF0F172A),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Serif',
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        isGu
                            ? 'તમારો વ્યવસાય ઉમેરવા માટે કૃપા કરીને તમારી પ્રોફાઇલમાં વ્યવસાય વિભાગ ભરો.'
                            : 'To add your business details please fill occupation section in your profile.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 13.5,
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            ),
                            child: Text(
                              isGu ? 'રદ કરો' : 'CANCEL',
                              style: const TextStyle(
                                color: Color(0xFF64748B),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const AddBusinessScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFCD34D),
                              foregroundColor: const Color(0xFF0F172A),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              isGu ? 'ઉમેરો' : 'ADD',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _selectedSector = 'All Sectors';
  final List<String> _sectors = [
    'All Sectors',
    'Tech',
    'Finance',
    'Creative',
    'Healthcare',
    'Engineering',
  ];

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Accountant':
      case 'Chartered Accountant':
        return Icons.calculate_outlined;
      case 'Administration Professional':
      case 'Customer Support Professional':
        return Icons.support_agent;
      case 'Advertising Professional':
      case 'Creative Person':
        return Icons.campaign_outlined;
      case 'Agriculture & Farming':
        return Icons.agriculture_outlined;
      case 'Architectural & Civil Engineering':
      case 'Civil Engineer':
      case 'Contractor':
      case 'Building & Construction':
      case 'Contractors & Freelancers':
        return Icons.engineering_outlined;
      case 'Ayurvedic & Herbal Products':
      case 'Cosmetics & Personal Care':
        return Icons.spa_outlined;
      case 'Baby / Pre School':
        return Icons.child_care_outlined;
      case 'Banker':
        return Icons.account_balance_outlined;
      case 'Battery & Storage Devices':
        return Icons.battery_charging_full_outlined;
      case 'Beautician':
        return Icons.brush_outlined;
      case 'Books & Stationery':
        return Icons.menu_book_outlined;
      case 'Computer & IT Solutions':
      case 'Computer Hardware & System':
      case 'Computer Manufacturers & Assemblers':
      case 'Computer/IT Professional':
        return Icons.computer_outlined;
      case 'Designer':
        return Icons.design_services_outlined;
      default:
        return Icons.work_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final bool isGu = lang.currentLanguage == 'gu';

    int getCategoryCount(String categoryName) {
      final stateCount = lang.businesses
          .where((b) => b['category'] == categoryName)
          .length;
      final defaultData = _categoriesData.firstWhere(
        (c) => c['name'] == categoryName,
        orElse: () => {'defaultCount': 0},
      );
      final int base = defaultData['defaultCount'];
      if (categoryName == 'Accountant') {
        return stateCount;
      }
      return base + stateCount;
    }

    final filteredCategories = _categoriesData.where((cat) {
      final String name = cat['name'] as String;
      final matchesSearch = _searchQuery.isEmpty ||
          name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          _getCategoryNameLabel(name, isGu).toLowerCase().contains(_searchQuery.toLowerCase());

      bool matchesSector = true;
      if (_selectedSector == 'Tech') {
        matchesSector = name.contains('Computer') || name.contains('IT') || name.contains('Hardware');
      } else if (_selectedSector == 'Finance') {
        matchesSector = name.contains('Accountant') || name.contains('Banker') || name.contains('Finance');
      } else if (_selectedSector == 'Creative') {
        matchesSector = name.contains('Advertising') || name.contains('Creative') || name.contains('Designer') || name.contains('Beautician');
      } else if (_selectedSector == 'Healthcare') {
        matchesSector = name.contains('Ayurvedic') || name.contains('Cosmetics') || name.contains('Herbal');
      } else if (_selectedSector == 'Engineering') {
        matchesSector = name.contains('Architectural') || name.contains('Engineering') || name.contains('Civil') || name.contains('Building') || name.contains('Contractor');
      }

      return matchesSearch && matchesSector;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0F172A), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isGu ? 'વ્યવસાય ડિરેક્ટરી' : 'Business',
          style: const TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Serif',
          ),
        ),
        actions: [
          Center(
            child: GestureDetector(
              onTap: () => _showAddBusinessDialog(context, isGu),
              child: Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: Color(0xFF8B6B23),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 10.0),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey[200],
              backgroundImage: const AssetImage('assets/images/sanjay_profile.png'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isGu ? 'વ્યાવસાયિક\nડિરેક્ટરી' : 'Professional\nDirectory',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Serif',
                      color: Color(0xFF0F172A),
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isGu
                        ? 'અમારા સમુદાયના વિશિષ્ટ વ્યાવસાયિકો અને વ્યવસાયિક નેતાઓ સાથે જોડાઓ.'
                        : 'Connect with the elite network of Swajan business leaders and community specialists within our curated professional ecosystem.',
                    style: const TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 13.5,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: InputDecoration(
                    hintText: isGu ? 'વ્યવસાયો શોધો...' : 'Search occupations...',
                    hintStyle: const TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 14,
                    ),
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF64748B), size: 22),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: _sectors.map((sector) {
                  final isSelected = sector == _selectedSector;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedSector = sector),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFFCD34D)
                              : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          _getSectorNameLabel(sector, isGu),
                          style: TextStyle(
                            color: isSelected ? const Color(0xFF0F172A) : const Color(0xFF475569),
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isGu ? 'A - Z ઉદ્યોગ યાદી' : 'A - Z INDUSTRY BREAKDOWN',
                    style: const TextStyle(
                      fontSize: 11,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 16),

                  if (filteredCategories.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: Center(
                        child: Text(
                          isGu ? 'કોઈ વ્યવસાય મળ્યા નથી.' : 'No occupations found.',
                          style: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
                        ),
                      ),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredCategories.length,
                      separatorBuilder: (context, index) => const Divider(
                        height: 1,
                        color: Color(0xFFF1F5F9),
                      ),
                      itemBuilder: (context, index) {
                        final catName = filteredCategories[index]['name'] as String;
                        final count = getCategoryCount(catName);
                        final icon = _getCategoryIcon(catName);

                        return Material(
                          color: Colors.transparent,
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                            leading: Container(
                              width: 44,
                              height: 44,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFEF9C3),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                icon,
                                color: const Color(0xFF854D0E),
                                size: 20,
                              ),
                            ),
                            title: Text(
                              _getCategoryNameLabel(catName, isGu),
                              style: const TextStyle(
                                color: Color(0xFF0F172A),
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEFF6FF),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Text(
                                    _getGujaratiNumberString('$count', isGu),
                                    style: const TextStyle(
                                      color: Color(0xFF1E40AF),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.chevron_right,
                                  color: Color(0xFF94A3B8),
                                  size: 18,
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BusinessCategoryDetailScreen(
                                    categoryName: catName,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BusinessCategoryDetailScreen extends StatelessWidget {
  final String categoryName;
  const BusinessCategoryDetailScreen({super.key, required this.categoryName});

  void _showAddBusinessDialog(BuildContext context, bool isGu) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 32),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 4,
                  decoration: const BoxDecoration(
                    color: Color(0xFF9A7B38),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 26, 24, 26),
                  child: Column(
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFEF9C3),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.work,
                          color: Color(0xFF854D0E),
                          size: 26,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        isGu ? 'વ્યવસાય' : 'Business',
                        style: const TextStyle(
                          color: Color(0xFF0F172A),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Serif',
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        isGu
                            ? 'તમારો વ્યવસાય ઉમેરવા માટે કૃપા કરીને તમારી પ્રોફાઇલમાં વ્યવસાય વિભાગ ભરો.'
                            : 'To add your business details please fill occupation section in your profile.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 13.5,
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            ),
                            child: Text(
                              isGu ? 'રદ કરો' : 'CANCEL',
                              style: const TextStyle(
                                color: Color(0xFF64748B),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const AddBusinessScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFCD34D),
                              foregroundColor: const Color(0xFF0F172A),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              isGu ? 'ઉમેરો' : 'ADD',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showMemberDetailsModal(BuildContext context, Map<String, dynamic> biz, bool isGu) {
    final rawName = biz['name'] ?? 'Professional';
    final displayName = _getBusinessMemberNameLabel(rawName, isGu);
    final city = biz['city'] ?? 'Location';
    final area = biz['area'] ?? '';
    final location = _getBusinessLocationLabel(city, area, isGu);
    final rawRole = (biz['role'] ?? (rawName.contains('Akshaykumar') ? 'SENIOR ACCOUNTANT' : 'ACCOUNTANT')).toString().toUpperCase();
    final role = _getBusinessRoleLabel(rawRole, isGu);
    final category = _getCategoryNameLabel(biz['category'] ?? categoryName, isGu);
    final image = biz['image'] as String?;
    final phone = (biz['phone'] != null && biz['phone'].toString().isNotEmpty)
        ? _getGujaratiNumberString(biz['phone'].toString(), isGu)
        : _getGujaratiNumberString('+91 98765 43210', isGu);
    final email = '${rawName.toLowerCase().replaceAll(' ', '.')}@heritage.org';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            children: [
              // Top Drag Handle & Close Button
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 32), // Spacer
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
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Column(
                    children: [
                      // Avatar with Golden Ring
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFFCD34D), width: 3.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: (image != null && image.isNotEmpty)
                              ? Image.network(
                                  image,
                                  fit: BoxFit.cover,
                                  errorBuilder: (c, e, s) => Container(
                                    color: const Color(0xFFF1F5F9),
                                    child: const Icon(Icons.person, size: 50, color: Color(0xFF94A3B8)),
                                  ),
                                )
                              : Container(
                                  color: const Color(0xFFF1F5F9),
                                  child: const Icon(Icons.person, size: 50, color: Color(0xFF94A3B8)),
                                ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Name & Role
                      Text(
                        displayName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Serif',
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        role,
                        style: const TextStyle(
                          color: Color(0xFF9A7B38),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Verified Heritage Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF9C3),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFFCD34D)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.verified_rounded, size: 16, color: Color(0xFF854D0E)),
                            const SizedBox(width: 6),
                            Text(
                              isGu ? 'ચકાસાયેલ સ્વજન પ્રોફેશનલ' : 'VERIFIED SWAJAN PROFESSIONAL',
                              style: const TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF854D0E),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Details Cards Section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          children: [
                            _buildModalInfoRow(
                              icon: Icons.work_outline,
                              title: isGu ? 'વ્યવસાય શ્રેણી' : 'Category',
                              value: category,
                            ),
                            const Divider(height: 24, color: Color(0xFFE2E8F0)),
                            _buildModalInfoRow(
                              icon: Icons.location_on_outlined,
                              title: isGu ? 'સ્થળ / સરનામું' : 'Location / City',
                              value: location,
                            ),
                            const Divider(height: 24, color: Color(0xFFE2E8F0)),
                            _buildModalInfoRow(
                              icon: Icons.phone_outlined,
                              title: isGu ? 'સંપર્ક નંબર' : 'Phone / WhatsApp',
                              value: phone,
                            ),
                            const Divider(height: 24, color: Color(0xFFE2E8F0)),
                            _buildModalInfoRow(
                              icon: Icons.email_outlined,
                              title: isGu ? 'ઈમેલ આઈડી' : 'Email Address',
                              value: email,
                            ),
                            const Divider(height: 24, color: Color(0xFFE2E8F0)),
                            _buildModalInfoRow(
                              icon: Icons.stars_outlined,
                              title: isGu ? 'અનુભવ' : 'Experience',
                              value: isGu ? '૧૨+ વર્ષનો પ્રોફેશનલ અનુભવ' : '12+ Years Professional Experience',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Service Description Box
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFF1F5F9)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.02),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isGu ? 'સેવાઓની વિગતો' : 'Services & Expertise',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              isGu
                                  ? 'ઉચ્ચ ગુણવત્તાયુક્ત વ્યાવસાયિક સેવાઓ, કોર્પોરેટ સલાહકાર અને સમુદાયના સભ્યો માટે વિશેષ સહાય.'
                                  : 'Top tier Swajan verified professional providing corporate consulting, auditing, legal advice, and business support for community members.',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF64748B),
                                height: 1.45,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Call & WhatsApp Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isGu ? '$phone પર કોલ કરી રહ્યા છીએ...' : 'Calling $phone...',
                                    ),
                                    backgroundColor: const Color(0xFF0F172A),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.call, size: 18),
                              label: Text(
                                isGu ? 'કોલ કરો' : 'Call Now',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0F172A),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
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
                                      isGu ? '$phone પર વોટ્સએપ મોકલી રહ્યા છીએ...' : 'Opening WhatsApp for $phone...',
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
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
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

  Widget _buildModalInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Icon(icon, size: 18, color: const Color(0xFF854D0E)),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getFallbackMembers(String cat) {
    if (cat == 'Banker') {
      return [
        {
          'name': 'Deepak Jayesh Trivedi',
          'role': 'SENIOR BANKER',
          'city': 'Ahmedabad',
          'area': 'C.G. Road',
          'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
        },
        {
          'name': 'Nisha Rajesh Parikh',
          'role': 'BRANCH MANAGER',
          'city': 'Surat',
          'area': 'Adajan',
          'image': 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=200',
        },
      ];
    } else if (cat == 'Civil Engineer') {
      return [
        {
          'name': 'Bharat Gandhi',
          'role': 'CIVIL ENGINEER',
          'city': 'Rajkot',
          'area': 'Kalavad Road',
          'image': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200',
        },
        {
          'name': 'Karan Desai',
          'role': 'STRUCTURAL ENGINEER',
          'city': 'Vadodara',
          'area': 'Alkapuri',
          'image': 'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=200',
        },
      ];
    }

    return [
      {
        'name': 'Ramesh H. Patel',
        'role': cat.toUpperCase(),
        'city': 'Ahmedabad',
        'area': 'Paldi',
        'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
      },
      {
        'name': 'Sunita K. Joshi',
        'role': cat.toUpperCase(),
        'city': 'Vadodara',
        'area': 'Gotri',
        'image': 'https://images.unsplash.com/photo-1580489944761-15a19d654956?w=200',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final bool isGu = lang.currentLanguage == 'gu';

    List<Map<String, dynamic>> categoryList = lang.businesses
        .where((b) => b['category'] == categoryName)
        .toList();

    if (categoryList.isEmpty) {
      categoryList = _getFallbackMembers(categoryName);
    }

    final displayTitle = _getCategoryNameLabel(categoryName, isGu);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0F172A), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isGu ? 'સ્વજન એપ' : 'SWAJAN',
          style: const TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Serif',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Color(0xFF8B6B23), size: 24),
            onPressed: () => _showAddBusinessDialog(context, isGu),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 4.0),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey[200],
              backgroundImage: const AssetImage('assets/images/sanjay_profile.png'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    isGu ? 'પ્રીમિયમ ડિરેક્ટરી' : 'PREMIUM DIRECTORY',
                    style: const TextStyle(
                      color: Color(0xFF9A7B38),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    displayTitle,
                    style: const TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Serif',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      isGu
                          ? 'અમારા વિશ્વસનીય વ્યાવસાયિકોના નેટવર્ક સાથે જોડાઓ.'
                          : (categoryName == 'Accountant'
                              ? 'Connect with our elite network of verified financial professionals specializing in Swajan-scale asset management and corporate accounting.'
                              : 'Connect with our elite network of verified ${categoryName.toLowerCase()} professionals in our curated ecosystem.'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 13.5,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            ...categoryList.map((biz) {
              final rawName = biz['name'] ?? '';
              final name = _getBusinessMemberNameLabel(rawName, isGu);
              final city = biz['city'] ?? '';
              final area = biz['area'] ?? '';
              final location = _getBusinessLocationLabel(city, area, isGu);
              final rawRole = (biz['role'] ?? (rawName.contains('Akshaykumar') ? 'SENIOR ACCOUNTANT' : 'ACCOUNTANT')).toString().toUpperCase();
              final role = _getBusinessRoleLabel(rawRole, isGu);
              final image = biz['image'] as String?;

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFF1F5F9), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 12,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: (image != null && image.isNotEmpty)
                              ? Image.network(
                                  image,
                                  width: 72,
                                  height: 72,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    width: 72,
                                    height: 72,
                                    color: const Color(0xFFF1F5F9),
                                    child: const Icon(Icons.person, color: Color(0xFF94A3B8), size: 36),
                                  ),
                                )
                              : Container(
                                  width: 72,
                                  height: 72,
                                  color: const Color(0xFFF1F5F9),
                                  child: const Icon(Icons.person, color: Color(0xFF94A3B8), size: 36),
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
                                  color: Color(0xFF0F172A),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Serif',
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                role,
                                style: const TextStyle(
                                  color: Color(0xFF9A7B38),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: Color(0xFF64748B),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          location,
                          style: const TextStyle(
                            color: Color(0xFF475569),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _showMemberDetailsModal(context, biz, isGu),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFCD34D),
                          foregroundColor: const Color(0xFF0F172A),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isGu ? 'પ્રોફાઇલ જુઓ' : 'View Profile',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: Color(0xFF0F172A),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class AddBusinessScreen extends StatefulWidget {
  const AddBusinessScreen({super.key});

  @override
  State<AddBusinessScreen> createState() => _AddBusinessScreenState();
}

class _AddBusinessScreenState extends State<AddBusinessScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  String _selectedCategory = 'Accountant';
  bool _isPublic = true;
  String? _selectedBusinessImagePath;

  final List<String> _categories = [
    'Accountant',
    'Administration Professional',
    'Advertising Professional',
    'Agriculture & Farming',
    'Architectural & Civil Engineering',
    'Ayurvedic & Herbal Products',
    'Baby / Pre School',
    'Banker',
    'Building & Construction',
    'Chartered Accountant',
    'Civil Engineer',
    'Computer & IT Solutions',
    'Computer/IT Professional',
    'Contractor',
    'Designer',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    _areaController.dispose();
    _phoneController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final lang = Provider.of<LanguageProvider>(context, listen: false);
    final bool isGu = lang.currentLanguage == 'gu';

    final newBusiness = {
      'name': _nameController.text.trim(),
      'city': _cityController.text.trim(),
      'area': _areaController.text.trim(),
      'category': _selectedCategory,
      'image': _selectedBusinessImagePath ?? '',
      'description': _descController.text.trim(),
      'phone': _phoneController.text.trim(),
      'isPublic': _isPublic,
    };

    lang.addBusiness(newBusiness);

    if (_isPublic) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 32),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 4,
                  decoration: const BoxDecoration(
                    color: Color(0xFF9A7B38),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFEF9C3),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.campaign_outlined,
                          color: Color(0xFF854D0E),
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        isGu ? 'પ્રસારણ સક્રિય' : 'Broadcast Active',
                        style: const TextStyle(
                          color: Color(0xFF0F172A),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Serif',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        isGu
                            ? 'તમારો વ્યવસાય "${newBusiness['name']}" જાહેર ડિરેક્ટરીમાં પ્રકાશિત કરવામાં આવ્યો છે.'
                            : 'Your business "${newBusiness['name']}" has been published to the Public Directory. A notification has been broadcasted to all Swajan App community members!',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13.5,
                          color: Color(0xFF64748B),
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFCD34D),
                            foregroundColor: const Color(0xFF0F172A),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            isGu ? 'બરાબર' : 'OK',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isGu
                ? 'ખાનગી વ્યવસાય "${newBusiness['name']}" સફળતાપૂર્વક બનાવવામાં આવ્યો.'
                : 'Private Business "${newBusiness['name']}" created successfully.',
          ),
          backgroundColor: const Color(0xFF0F172A),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final bool isGu = lang.currentLanguage == 'gu';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0F172A), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isGu ? 'વ્યવસાયની વિગતો ઉમેરો' : 'Add Business Details',
          style: const TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Serif',
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/images/sanjay_profile.png'),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isGu ? 'વ્યવસાયિક ઇકોસિસ્ટમ' : 'BUSINESS ECOSYSTEM',
                style: const TextStyle(
                  color: Color(0xFF9A7B38),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                isGu ? 'તમારો વ્યવસાય નોંધાવો' : 'Register Your Business',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Serif',
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isGu
                    ? 'તમારા વ્યવસાયની માહિતી શેર કરો અને નેટવર્ક વિસ્તારો.'
                    : 'Share your professional expertise and expand your business reach within our elite Swajan community network.',
                style: const TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 13.5,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFF1F5F9), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFormLabel(isGu ? 'વ્યવસાયનું નામ' : 'Business Name'),
                    _buildTextField(
                      controller: _nameController,
                      hint: isGu ? 'દા.ત. પટેલ ટેક્સટાઇલ' : 'e.g. Patel Textiles',
                      validator: (v) => v!.isEmpty ? (isGu ? 'વ્યવસાયનું નામ જરૂરી છે' : 'Business name is required') : null,
                    ),
                    const SizedBox(height: 16),

                    _buildFormLabel(isGu ? 'વ્યવસાયની શ્રેણી' : 'Business Category'),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedCategory,
                          isExpanded: true,
                          icon: const Icon(Icons.unfold_more, color: Color(0xFF475569)),
                          style: const TextStyle(
                            color: Color(0xFF0F172A),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          items: _categories.map((c) {
                            return DropdownMenuItem(value: c, child: Text(_getCategoryNameLabel(c, isGu)));
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _selectedCategory = val;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFormLabel(isGu ? 'શહેર' : 'City'),
                              _buildTextField(
                                controller: _cityController,
                                hint: isGu ? 'દા.ત. અમદાવાદ' : 'e.g. Ahmedabad',
                                validator: (v) => v!.isEmpty ? (isGu ? 'જરૂરી છે' : 'Required') : null,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFormLabel(isGu ? 'વિસ્તાર / રસ્તો' : 'Area / Street'),
                              _buildTextField(
                                controller: _areaController,
                                hint: isGu ? 'દા.ત. સી.જી. રોડ' : 'e.g. C.G. Road',
                                validator: (v) => v!.isEmpty ? (isGu ? 'જરૂરી છે' : 'Required') : null,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    _buildFormLabel(isGu ? 'સંપર્ક ફોન / વોટ્સએપ' : 'Contact Phone / WhatsApp'),
                    _buildTextField(
                      controller: _phoneController,
                      hint: isGu ? '૧૦-અંકનો નંબર લખો' : 'Enter 10-digit number',
                      keyboardType: TextInputType.phone,
                      validator: (v) => v!.isEmpty ? (isGu ? 'સંપર્ક નંબર જરૂરી છે' : 'Contact number is required') : null,
                    ),
                    const SizedBox(height: 16),

                    _buildFormLabel(isGu ? 'વ્યવસાય ચિત્ર' : 'Business Image'),
                    const SizedBox(height: 6),
                    GestureDetector(
                      onTap: () async {
                        final result = await showDialog<String>(
                          context: context,
                          builder: (context) => const CustomImagePickerDialog(
                            isProfilePhoto: false,
                          ),
                        );
                        if (result != null) {
                          setState(() {
                            _selectedBusinessImagePath = result;
                          });
                        }
                      },
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: _selectedBusinessImagePath != null && _selectedBusinessImagePath!.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: _selectedBusinessImagePath!.startsWith('http')
                                    ? Image.network(
                                        _selectedBusinessImagePath!,
                                        width: double.infinity,
                                        height: 150,
                                        fit: BoxFit.cover,
                                        errorBuilder: (c, e, s) => const Icon(
                                          Icons.storefront,
                                          size: 48,
                                          color: Color(0xFF94A3B8),
                                        ),
                                      )
                                    : Image.file(
                                        File(_selectedBusinessImagePath!),
                                        width: double.infinity,
                                        height: 150,
                                        fit: BoxFit.cover,
                                        errorBuilder: (c, e, s) => const Icon(
                                          Icons.storefront,
                                          size: 48,
                                          color: Color(0xFF94A3B8),
                                        ),
                                      ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFEF9C3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 24,
                                      color: Color(0xFF854D0E),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    isGu
                                        ? 'વ્યવસાય ફોટો પસંદ કરવા માટે ટેપ કરો'
                                        : 'Tap to choose or capture business photo',
                                    style: const TextStyle(
                                      color: Color(0xFF64748B),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    _buildFormLabel(isGu ? 'વર્ણન / સેવા વિગતો' : 'Description / Service Info'),
                    _buildTextField(
                      controller: _descController,
                      hint: isGu
                          ? 'તમારો વ્યવસાય શું સેવાઓ પૂરી પાડે છે તે વર્ણવો...'
                          : 'Explain what services your business provides...',
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isGu ? 'ગોપનીયતા ગોઠવણી' : 'Privacy Configuration',
                            style: const TextStyle(
                              color: Color(0xFF0F172A),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          RadioGroup<bool>(
                            groupValue: _isPublic,
                            onChanged: (v) {
                              if (v != null) setState(() => _isPublic = v);
                            },
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Radio<bool>(
                                      value: true,
                                      activeColor: const Color(0xFF8B6B23),
                                    ),
                                    Expanded(
                                      child: Text(
                                        isGu
                                            ? 'જાહેર (બધા સભ્યોને દૃશ્યમાન)'
                                            : 'Public (Visible to all members, triggers notification)',
                                        style: const TextStyle(fontSize: 13, color: Color(0xFF475569)),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio<bool>(
                                      value: false,
                                      activeColor: const Color(0xFF8B6B23),
                                    ),
                                    Expanded(
                                      child: Text(
                                        isGu
                                            ? 'ખાનગી (ફક્ત પરિવાર અને સગાંસંબંધીઓ)'
                                            : 'Private (Visible to family & relatives only)',
                                        style: const TextStyle(fontSize: 13, color: Color(0xFF475569)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFCD34D),
                          foregroundColor: const Color(0xFF0F172A),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isGu ? 'વ્યવસાય વિગતો પ્રકાશિત કરો' : 'Publish Business Details',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward,
                              size: 18,
                              color: Color(0xFF0F172A),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF0F172A),
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 13,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF9A7B38), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
      ),
    );
  }
}
