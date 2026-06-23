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
  static const Color primaryNavy = Color(0xFF00005C);
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
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            'Business',
            style: TextStyle(
              color: Color(0xFF00005C),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: const Text(
            'To add your business details please fill occupation section in your profile.',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'CANCEL',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Open Add Business Form Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddBusinessScreen()),
                );
              },
              child: const Text(
                'ADD',
                style: TextStyle(
                  color: primaryNavy,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

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
      // If category is Accountant, use actual list size or default.
      if (categoryName == 'Accountant') {
        return stateCount;
      }
      return base + stateCount;
    }

    // Filter categories based on search query
    final filteredCategories = _categoriesData.where((cat) {
      final String name = cat['name'] as String;
      return name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: primaryNavy,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Business Directory',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white, size: 28),
            onPressed: () => _showAddBusinessDialog(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar header section (replaces raw blue line)
            Container(
              color: primaryNavy,
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search business categories...',
                    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                _searchController.clear();
                                _searchQuery = '';
                              });
                            },
                            child: const Icon(Icons.clear, color: Colors.grey),
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                    });
                  },
                ),
              ),
            ),

            // Category list (Decent and Premium design)
            Expanded(
              child: filteredCategories.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Text(
                          'No categories matching "$_searchQuery"',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      itemCount: filteredCategories.length,
                      itemBuilder: (context, index) {
                        final catName =
                            filteredCategories[index]['name'] as String;
                        final count = getCategoryCount(catName);
                        final icon = _getCategoryIcon(catName);

                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade200),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.02),
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: primaryNavy.withValues(alpha: 0.06),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(icon, color: primaryNavy, size: 20),
                            ),
                            title: Text(
                              catName,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.5,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.teal.shade50,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '$count',
                                    style: TextStyle(
                                      color: Colors.teal.shade800,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.chevron_right_rounded,
                                  color: Colors.grey,
                                  size: 20,
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
            ),
          ],
        ),
      ),
    );
  }
}

// --- CATEGORY DETAIL LIST SCREEN (2nd Image) ---
class BusinessCategoryDetailScreen extends StatelessWidget {
  final String categoryName;
  const BusinessCategoryDetailScreen({super.key, required this.categoryName});

  static const Color primaryNavy = Color(0xFF00005C);

  void _showAddBusinessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: const Text(
            'Business',
            style: TextStyle(
              color: Color(0xFF00005C),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: const Text(
            'To add your business details please fill occupation section in your profile.',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'CANCEL',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddBusinessScreen()),
                );
              },
              child: const Text(
                'ADD',
                style: TextStyle(
                  color: primaryNavy,
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

    // Filter businesses by selected category
    final categoryList = lang.businesses
        .where((b) => b['category'] == categoryName)
        .toList();

    // Hindi translation helper to match the image subtitles
    String getHindiSubHeader(String englishName) {
      if (englishName == 'Accountant') return 'अकाउंटेंट';
      if (englishName == 'Civil Engineer') return 'सिविल इंजीनियर';
      return englishName;
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: primaryNavy,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Business',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white, size: 28),
            onPressed: () => _showAddBusinessDialog(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Category Hindi/Local subheader bar
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              child: Text(
                getHindiSubHeader(categoryName),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(height: 1, color: Color(0xFFEEEEEE)),

            // Business members list
            Expanded(
              child: categoryList.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Text(
                          'No registered business in $categoryName yet.',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      itemCount: categoryList.length,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1, color: Color(0xFFF2F2F2)),
                      itemBuilder: (context, index) {
                        final biz = categoryList[index];
                        final name = biz['name'] ?? '';
                        final city = biz['city'] ?? '';
                        final area = biz['area'] ?? '';
                        final category = biz['category'] ?? '';
                        final image = biz['image'];
                        final description = biz['description'] ?? '';
                        final phone = biz['phone'] ?? '';

                        return Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Avatar circle/square photo (supports both local files and network URLs)
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.grey[200],
                                  border: Border.all(color: Colors.grey[300]!),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child:
                                      image != null &&
                                          (image as String).isNotEmpty
                                      ? (image.startsWith('http')
                                            ? Image.network(
                                                image,
                                                fit: BoxFit.cover,
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) => const Icon(
                                                      Icons.business,
                                                      size: 40,
                                                      color: Colors.grey,
                                                    ),
                                              )
                                            : Image.file(
                                                File(image),
                                                fit: BoxFit.cover,
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) => const Icon(
                                                      Icons.business,
                                                      size: 40,
                                                      color: Colors.grey,
                                                    ),
                                              ))
                                      : const Icon(
                                          Icons.business,
                                          size: 40,
                                          color: Colors.grey,
                                        ),
                                ),
                              ),
                              const SizedBox(width: 16),

                              // Text details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: const TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '$city, $area',
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      category,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    if (description.isNotEmpty) ...[
                                      const SizedBox(height: 6),
                                      Text(
                                        description,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Calling $name (+91 $phone)...',
                                                ),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryNavy,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 8,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            elevation: 0,
                                          ),
                                          icon: const Icon(
                                            Icons.phone,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                          label: const Text(
                                            'Call Now',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
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
                        );
                      },
                    ),
            ),
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
  static const Color primaryNavy = Color(0xFF00005C);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  String _selectedCategory = 'Accountant';
  bool _isPublic = true; // true = public, false = private
  String? _selectedBusinessImagePath;

  // Matches categories in main directory list
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

    // Save business data
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

    // Show custom notification dialog for Public, or info toast for Private
    if (_isPublic) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(Icons.notifications_active, color: Colors.orange, size: 28),
              SizedBox(width: 8),
              Text(
                'Broadcast Active',
                style: TextStyle(
                  color: primaryNavy,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          content: Text(
            'Your business "${newBusiness['name']}" has been published to the Public Directory. A notification has been sent out to all Gujarati Heritage Core community members!',
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Pop dialog
                Navigator.pop(context); // Pop Add Screen
              },
              style: ElevatedButton.styleFrom(backgroundColor: primaryNavy),
              child: const Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Private Business "${newBusiness['name']}" created. Visible only to relatives.',
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryNavy,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Business Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildFormLabel('Business Name'),
                  _buildTextField(
                    controller: _nameController,
                    hint: 'e.g. Patel Textiles',
                    validator: (v) =>
                        v!.isEmpty ? 'Business name is required' : null,
                  ),
                  const SizedBox(height: 16),

                  _buildFormLabel('Business Category'),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedCategory,
                        isExpanded: true,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
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
                              hint: 'e.g. Kolhapur',
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
                              hint: 'e.g. Kharghar',
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
                    validator: (v) =>
                        v!.isEmpty ? 'Contact number is required' : null,
                  ),
                  const SizedBox(height: 16),

                  // Modern Local Business Image selector (removes URL text input field)
                  _buildFormLabel('Business Image'),
                  const SizedBox(height: 8),
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
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child:
                          _selectedBusinessImagePath != null &&
                              _selectedBusinessImagePath!.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child:
                                  _selectedBusinessImagePath!.startsWith('http')
                                  ? Image.network(
                                      _selectedBusinessImagePath!,
                                      width: double.infinity,
                                      height: 150,
                                      fit: BoxFit.cover,
                                      errorBuilder: (c, e, s) => const Icon(
                                        Icons.storefront,
                                        size: 48,
                                        color: Colors.grey,
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
                                        color: Colors.grey,
                                      ),
                                    ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_photo_alternate_outlined,
                                  size: 40,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Tap to choose/take business photo',
                                  style: TextStyle(
                                    color: Colors.grey[600],
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
                    hint: 'Explain what services you provide...',
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),

                  // Privacy Settings Section
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Privacy Configuration',
                          style: TextStyle(
                            color: primaryNavy,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Radio<bool>(
                              value: true,
                              groupValue: _isPublic,
                              activeColor: primaryNavy,
                              onChanged: (v) {
                                if (v != null) {
                                  setState(() => _isPublic = v);
                                }
                              },
                            ),
                            const Expanded(
                              child: Text(
                                'Public (Visible to all, triggers notification)',
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<bool>(
                              value: false,
                              groupValue: _isPublic,
                              activeColor: primaryNavy,
                              onChanged: (v) {
                                if (v != null) {
                                  setState(() => _isPublic = v);
                                }
                              },
                            ),
                            const Expanded(
                              child: Text(
                                'Private (Relatives & Family members only)',
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryNavy,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Save & Publish',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
          color: primaryNavy,
          fontWeight: FontWeight.bold,
          fontSize: 14,
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
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: primaryNavy, width: 1.5),
        ),
      ),
    );
  }
}
