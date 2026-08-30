import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'image_picker_dialog.dart';

class BusinessDirectoryScreen extends StatefulWidget {
  const BusinessDirectoryScreen({super.key});

  @override
  State<BusinessDirectoryScreen> createState() =>
      _BusinessDirectoryScreenState();
}

class _BusinessDirectoryScreenState extends State<BusinessDirectoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // List of categories and default counts matching the 1st image
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

  void _showAddBusinessDialog(BuildContext context) {
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
                // Top Golden Accent Bar
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
                      // Briefcase Icon Badge
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
                      // Title
                      const Text(
                        'Business',
                        style: TextStyle(
                          color: Color(0xFF0F172A),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Serif',
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Body text
                      const Text(
                        'To add your business details please fill occupation section in your profile.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 13.5,
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Buttons Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            ),
                            child: const Text(
                              'CANCEL',
                              style: TextStyle(
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
                            child: const Text(
                              'ADD',
                              style: TextStyle(
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

    // Compute dynamic count based on businesses in state
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

    // Filter categories based on search query and selected sector
    final filteredCategories = _categoriesData.where((cat) {
      final String name = cat['name'] as String;
      final matchesSearch = _searchQuery.isEmpty ||
          name.toLowerCase().contains(_searchQuery.toLowerCase());

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
        title: const Text(
          'Business',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Serif',
          ),
        ),
        actions: [
          Center(
            child: GestureDetector(
              onTap: () => _showAddBusinessDialog(context),
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
            // 1. Header Section: Title & Subtitle
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Professional\nDirectory',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Serif',
                      color: Color(0xFF0F172A),
                      height: 1.15,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Connect with the elite network of heritage business leaders and community specialists within our curated professional ecosystem.',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 13.5,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),

            // 2. Search Input
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
                  decoration: const InputDecoration(
                    hintText: 'Search occupations...',
                    hintStyle: TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 14,
                    ),
                    prefixIcon: Icon(Icons.search, color: Color(0xFF64748B), size: 22),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 3. Horizontal Sector Filter Chips
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
                              ? const Color(0xFFFCD34D) // Bright warm yellow/gold
                              : const Color(0xFFF1F5F9), // Light grey
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          sector,
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

            // 4. Main White Card Container: A - Z INDUSTRY BREAKDOWN
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
                  const Text(
                    'A - Z INDUSTRY BREAKDOWN',
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 16),

                  if (filteredCategories.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.0),
                      child: Center(
                        child: Text(
                          'No occupations found.',
                          style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
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

                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                          leading: Container(
                            width: 44,
                            height: 44,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFEF9C3), // Soft yellow circular icon container
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              icon,
                              color: const Color(0xFF854D0E), // Olive gold icon
                              size: 20,
                            ),
                          ),
                          title: Text(
                            catName,
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
                                  color: const Color(0xFFEFF6FF), // Light soft blue pill
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Text(
                                  '$count',
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

// --- CATEGORY DETAIL LIST SCREEN (2nd Image) ---
// --- CATEGORY DETAIL LIST SCREEN (Matching attached screenshot) ---
class BusinessCategoryDetailScreen extends StatelessWidget {
  final String categoryName;
  const BusinessCategoryDetailScreen({super.key, required this.categoryName});

  static const Color primaryNavy = Color(0xFF00005C);

  static const Map<String, String> _gujaratiCategoryTitles = {
    'Accountant': 'અકાઉન્ટન્ટ',
    'Administration Professional': 'એડમિનિસ્ટ્રેશન પ્રોફેશનલ',
    'Advertising Professional': 'એડવર્ટાઇઝિંગ પ્રોફેશનલ',
    'Agriculture & Farming': 'કૃષિ અને ખેતી',
    'Architectural & Civil Engineering': 'આર્કિટેક્ચરલ અને સિવિલ એન્જિનિયરિંગ',
    'Ayurvedic & Herbal Products': 'આયુર્વેદિક અને હર્બલ પ્રોડક્ટ્સ',
    'Baby / Pre School': 'બેબી / પ્રી સ્કૂલ',
    'Banker': 'બેંકર',
    'Battery & Storage Devices': 'બેટરી અને સ્ટોરેજ',
    'Beautician': 'બ્યુટીશિયન',
    'Books & Stationery': 'બુક્સ અને સ્ટેશનરી',
    'Building & Construction': 'બિલ્ડિંગ અને કન્સ્ટ્રક્શન',
    'Business': 'બિઝનેસ',
    'Chartered Accountant': 'ચાર્ટર્ડ અકાઉન્ટન્ટ',
    'Civil Engineer': 'સિવિલ એન્જિનિયર',
    'Computer & IT Solutions': 'કોમ્પ્યુટર અને આઇટી સોલ્યુશન્સ',
    'Computer Hardware & System': 'કોમ્પ્યુટર હાર્ડવેર',
    'Computer Manufacturers & Assemblers': 'કોમ્પ્યુટર મેન્યુફેક્ચરર્સ',
    'Computer/IT Professional': 'આઇટી પ્રોફેશનલ',
    'Contractor': 'કોન્ટ્રાક્ટર',
    'Contractors & Freelancers': 'ફ્રીલાન્સર્સ',
    'Cosmetics & Personal Care': 'કોસ્મેટિક્સ',
    'Creative Person': 'ક્રિએટિવ પર્સન',
    'Customer Support Professional': 'કસ્ટમર સપોર્ટ',
    'Designer': 'ડિઝાઇનર',
  };

  void _showAddBusinessDialog(BuildContext context) {
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
                // Top Golden Accent Bar
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
                      // Briefcase Icon Badge
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
                      // Title
                      const Text(
                        'Business',
                        style: TextStyle(
                          color: Color(0xFF0F172A),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Serif',
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Body text
                      const Text(
                        'To add your business details please fill occupation section in your profile.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 13.5,
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Buttons Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            ),
                            child: const Text(
                              'CANCEL',
                              style: TextStyle(
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
                            child: const Text(
                              'ADD',
                              style: TextStyle(
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

    // Filter businesses by selected category
    List<Map<String, dynamic>> categoryList = lang.businesses
        .where((b) => b['category'] == categoryName)
        .toList();

    if (categoryList.isEmpty) {
      categoryList = _getFallbackMembers(categoryName);
    }

    final gujaratiTitle = _gujaratiCategoryTitles[categoryName] ?? categoryName;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0F172A), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Heritage App',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Serif',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Color(0xFF8B6B23), size: 24),
            onPressed: () => _showAddBusinessDialog(context),
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
            // 1. Hero Header Section
            Center(
              child: Column(
                children: [
                  const Text(
                    'PREMIUM DIRECTORY',
                    style: TextStyle(
                      color: Color(0xFF9A7B38),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    gujaratiTitle,
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
                      categoryName == 'Accountant'
                          ? 'Connect with our elite network of verified financial professionals specializing in heritage-scale asset management and corporate accounting.'
                          : 'Connect with our elite network of verified ${categoryName.toLowerCase()} professionals in our curated ecosystem.',
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

            // 2. Member Cards List
            ...categoryList.map((biz) {
              final name = biz['name'] ?? '';
              final city = biz['city'] ?? '';
              final area = biz['area'] ?? '';
              final role = (biz['role'] ?? (name.contains('Akshaykumar') ? 'SENIOR ACCOUNTANT' : 'ACCOUNTANT')).toString().toUpperCase();
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
                    // Top Row: Image & Name/Role
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

                    // Middle Row: Location
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: Color(0xFF64748B),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '$city, $area',
                          style: const TextStyle(
                            color: Color(0xFF475569),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Bottom Row: View Profile Golden Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Opening $name\'s profile...'),
                              backgroundColor: const Color(0xFF0F172A),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFCD34D), // Warm light gold
                          foregroundColor: const Color(0xFF0F172A),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'View Profile',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(
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

// --- ADD BUSINESS SCREEN ---
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
  bool _isPublic = true; // true = public, false = private
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
                      const Text(
                        'Broadcast Active',
                        style: TextStyle(
                          color: Color(0xFF0F172A),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Serif',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Your business "${newBusiness['name']}" has been published to the Public Directory. A notification has been broadcasted to all Heritage App community members!',
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
                            Navigator.pop(context); // Pop dialog
                            Navigator.pop(context); // Pop Add Screen
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
                          child: const Text(
                            'OK',
                            style: TextStyle(
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
            'Private Business "${newBusiness['name']}" created successfully.',
          ),
          backgroundColor: const Color(0xFF0F172A),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0F172A), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Business Details',
          style: TextStyle(
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
              // 1. Hero Title Section
              const Text(
                'BUSINESS ECOSYSTEM',
                style: TextStyle(
                  color: Color(0xFF9A7B38),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Register Your Business',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Serif',
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Share your professional expertise and expand your business reach within our elite heritage community network.',
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 13.5,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 20),

              // 2. Main Form Card Container
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
                    _buildFormLabel('Business Name'),
                    _buildTextField(
                      controller: _nameController,
                      hint: 'e.g. Patel Textiles',
                      validator: (v) => v!.isEmpty ? 'Business name is required' : null,
                    ),
                    const SizedBox(height: 16),

                    _buildFormLabel('Business Category'),
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
                            return DropdownMenuItem(value: c, child: Text(c));
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
                              _buildFormLabel('City'),
                              _buildTextField(
                                controller: _cityController,
                                hint: 'e.g. Ahmedabad',
                                validator: (v) => v!.isEmpty ? 'Required' : null,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFormLabel('Area / Street'),
                              _buildTextField(
                                controller: _areaController,
                                hint: 'e.g. C.G. Road',
                                validator: (v) => v!.isEmpty ? 'Required' : null,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    _buildFormLabel('Contact Phone / WhatsApp'),
                    _buildTextField(
                      controller: _phoneController,
                      hint: 'Enter 10-digit number',
                      keyboardType: TextInputType.phone,
                      validator: (v) => v!.isEmpty ? 'Contact number is required' : null,
                    ),
                    const SizedBox(height: 16),

                    // Photo Picker Section
                    _buildFormLabel('Business Image'),
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
                                  const Text(
                                    'Tap to choose or capture business photo',
                                    style: TextStyle(
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

                    _buildFormLabel('Description / Service Info'),
                    _buildTextField(
                      controller: _descController,
                      hint: 'Explain what services your business provides...',
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20),

                    // Privacy Settings
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
                          const Text(
                            'Privacy Configuration',
                            style: TextStyle(
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
                                    const Expanded(
                                      child: Text(
                                        'Public (Visible to all members, triggers notification)',
                                        style: TextStyle(fontSize: 13, color: Color(0xFF475569)),
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
                                    const Expanded(
                                      child: Text(
                                        'Private (Visible to family & relatives only)',
                                        style: TextStyle(fontSize: 13, color: Color(0xFF475569)),
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

                    // Golden Publish Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFCD34D), // Golden yellow pill
                          foregroundColor: const Color(0xFF0F172A),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Publish Business Details',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
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
