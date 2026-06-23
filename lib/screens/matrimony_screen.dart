import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'detailed_registration_screen.dart';

class MatrimonyScreen extends StatefulWidget {
  final TabController tabController;

  const MatrimonyScreen({super.key, required this.tabController});

  @override
  State<MatrimonyScreen> createState() => _MatrimonyScreenState();
}

class _MatrimonyScreenState extends State<MatrimonyScreen> {
  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);

    return TabBarView(
      controller: widget.tabController,
      children: [
        MatrimonySearchView(lang: lang),
        MatrimonyPremiumView(lang: lang),
        PersonalMatchesView(tabController: widget.tabController),
      ],
    );
  }
}

// ==========================================
// 1. MATRIMONY SEARCH VIEW (TAB 1)
// ==========================================
class MatrimonySearchView extends StatefulWidget {
  final LanguageProvider lang;

  const MatrimonySearchView({super.key, required this.lang});

  @override
  State<MatrimonySearchView> createState() => _MatrimonySearchViewState();
}

class _MatrimonySearchViewState extends State<MatrimonySearchView> {
  static const Color primaryNavy = Color(0xFF00005C);

  String _selectedAgeRange = '25 - 30';
  String _selectedGender = 'Groom';
  String _selectedEducation = 'Post Graduate';
  bool _isLoading = false;
  bool _hasSearched = false;

  // More Filters state variables
  String _selectedCityFilter = 'All Cities';
  String _selectedDietFilter = 'All Diet';
  String _selectedMaritalStatus = 'All';

  final List<String> _ageRanges = ['20 - 25', '25 - 30', '30 - 35', '35 - 40'];
  final List<String> _genders = ['Groom', 'Bride'];
  final List<String> _educationOptions = [
    'All Education',
    'Post Graduate',
    'Graduate',
    'Doctorate',
    'Undergraduate'
  ];

  final List<String> _cities = ['All Cities', 'Ahmedabad', 'Surat', 'Vadodara', 'Rajkot'];
  final List<String> _diets = ['All Diet', 'Vegetarian', 'Jain', 'Non-Vegetarian'];
  final List<String> _maritalStatuses = ['All', 'Never Married', 'Divorced', 'Widowed'];

  // List of mock profiles
  final List<Map<String, dynamic>> _allProfiles = [
    {
      'id': 'p1',
      'name': 'Rajesh V. Patel',
      'age': 32,
      'height': "5'11\"",
      'education': 'Post Graduate',
      'degree': 'MBA (Finance)',
      'profession': 'Chartered Accountant',
      'city': 'Ahmedabad',
      'state': 'Gujarat',
      'diet': 'Vegetarian',
      'maritalStatus': 'Never Married',
      'verifiedType': 'green_tag', // Green banner "VERIFIED" on top-left of image
      'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300',
      'isFavorite': false,
      'about': 'I am a focused, family-oriented individual who balances traditional values with a modern outlook. Currently working as a senior CA in an MNC.',
      'familyBackground': 'Father is a retired businessman, Mother is a homemaker. Well-settled family in Ahmedabad.',
    },
    {
      'id': 'p2',
      'name': 'Meera S. Shah',
      'age': 29,
      'height': "5'4\"",
      'education': 'Post Graduate',
      'degree': 'M.D. Pediatrics',
      'profession': 'Pediatrician (M.D.)',
      'city': 'Surat',
      'state': 'Gujarat',
      'diet': 'Vegetarian',
      'maritalStatus': 'Never Married',
      'verifiedType': 'blue_tick', // Blue verified checkmark inside image bottom-right
      'image': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=300',
      'isFavorite': true,
      'about': 'Compassionate and dedicated pediatrician. I love working with children and believe in leading a balanced lifestyle, giving equal importance to family and profession.',
      'familyBackground': 'Father is a reputed Cardiologist, Mother is a professor of Gujarati literature. Respectable family in Surat.',
    },
    {
      'id': 'p3',
      'name': 'Suresh K. Mehta',
      'age': 35,
      'height': "5'9\"",
      'education': 'Post Graduate',
      'degree': 'M.Tech Computer Science',
      'profession': 'Software Architect',
      'city': 'Vadodara',
      'state': 'Gujarat',
      'diet': 'Jain',
      'maritalStatus': 'Never Married',
      'verifiedType': 'none',
      'image': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=300',
      'isFavorite': false,
      'about': 'Tech enthusiast, avid reader, and outdoor lover. Working as a software solutions architect at a leading technology firm. Values integrity and simple living.',
      'familyBackground': 'Father is a high court lawyer, Mother is a school principal. Cultured and educated family background.',
    },
  ];

  List<Map<String, dynamic>> _filteredProfiles = [];

  @override
  void initState() {
    super.initState();
    _filteredProfiles = List.from(_allProfiles);
    _hasSearched = true;
  }

  void _performSearch() {
    setState(() {
      _isLoading = true;
      _hasSearched = true;
    });

    // Simulate network delay
    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _filteredProfiles = _allProfiles.where((p) {
          // Filter by gender if matches or other criteria
          final matchesGender = (_selectedGender == 'Groom' && p['verifiedType'] != 'blue_tick') ||
              (_selectedGender == 'Bride' && p['verifiedType'] == 'blue_tick');
          // For dummy data, if 'All Education' is selected we show all, else filter
          final matchesEducation = _selectedEducation == 'All Education' || p['education'] == _selectedEducation;
          
          // Additional filters
          final matchesCity = _selectedCityFilter == 'All Cities' || p['city'] == _selectedCityFilter;
          final matchesDiet = _selectedDietFilter == 'All Diet' || p['diet'] == _selectedDietFilter;
          final matchesMarital = _selectedMaritalStatus == 'All' || p['maritalStatus'] == _selectedMaritalStatus;

          return matchesGender && matchesEducation && matchesCity && matchesDiet && matchesMarital;
        }).toList();
      });
    });
  }

  void _showMoreFiltersSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'More Search Filters',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: primaryNavy,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // City Filter
                  const Text('City / Location', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black54)),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedCityFilter,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: _cities.map((city) {
                          return DropdownMenuItem(value: city, child: Text(city));
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setModalState(() => _selectedCityFilter = val);
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Diet Filter
                  const Text('Diet Preference', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black54)),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedDietFilter,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: _diets.map((diet) {
                          return DropdownMenuItem(value: diet, child: Text(diet));
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setModalState(() => _selectedDietFilter = val);
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Marital Status
                  const Text('Marital Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black54)),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedMaritalStatus,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: _maritalStatuses.map((status) {
                          return DropdownMenuItem(value: status, child: Text(status));
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setModalState(() => _selectedMaritalStatus = val);
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Actions row
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setModalState(() {
                              _selectedCityFilter = 'All Cities';
                              _selectedDietFilter = 'All Diet';
                              _selectedMaritalStatus = 'All';
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: const BorderSide(color: primaryNavy),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Reset All', style: TextStyle(color: primaryNavy, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _performSearch();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryNavy,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            elevation: 0,
                          ),
                          child: const Text('Apply Filters', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Age wise and Gender row
                Row(
                  children: [
                    // Age dropdown
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Age Range',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedAgeRange,
                                isExpanded: true,
                                icon: const Icon(Icons.keyboard_arrow_down, size: 20),
                                items: _ageRanges.map((val) {
                                  return DropdownMenuItem(value: val, child: Text(val));
                                }).toList(),
                                onChanged: (val) {
                                  if (val != null) setState(() => _selectedAgeRange = val);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Gender dropdown
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Looking For',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedGender,
                                isExpanded: true,
                                icon: const Icon(Icons.keyboard_arrow_down, size: 20),
                                items: _genders.map((val) {
                                  return DropdownMenuItem(value: val, child: Text(val));
                                }).toList(),
                                onChanged: (val) {
                                  if (val != null) setState(() => _selectedGender = val);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Education Filter (Replaces static Post Graduate)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Education Filter',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedEducation,
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down, size: 20),
                          items: _educationOptions.map((val) {
                            return DropdownMenuItem(value: val, child: Text(val));
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) setState(() => _selectedEducation = val);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Buttons row
                Row(
                  children: [
                    // More filters
                    OutlinedButton.icon(
                      onPressed: _showMoreFiltersSheet,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        side: const BorderSide(color: primaryNavy),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      icon: const Icon(Icons.tune, color: primaryNavy, size: 18),
                      label: const Text(
                        'More Filters',
                        style: TextStyle(color: primaryNavy, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Search button
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _performSearch,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryNavy,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          elevation: 0,
                        ),
                        icon: const Icon(Icons.search, size: 18),
                        label: const Text(
                          'Search',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Found X Profiles Header
          if (widget.lang.isProfileCompleted && _hasSearched) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _isLoading ? 'Searching...' : 'Found ${_filteredProfiles.length} Profiles',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: primaryNavy,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.sort, size: 16, color: primaryNavy),
                  label: const Text(
                    'Sort: Newest',
                    style: TextStyle(fontSize: 12, color: primaryNavy, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],

          // Profiles display
          if (!widget.lang.isProfileCompleted)
            _buildLockedStateCard()
          else if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: CircularProgressIndicator(color: primaryNavy),
              ),
            )
          else if (!_hasSearched)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Column(
                  children: [
                    Icon(Icons.favorite_outline, size: 48, color: Colors.grey[300]),
                    const SizedBox(height: 8),
                    const Text(
                      'Use the filters above and click Search\nto find matrimony profiles.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            )
          else if (_filteredProfiles.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: Text(
                  'No profiles found matching criteria',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _filteredProfiles.length,
              itemBuilder: (context, index) {
                final p = _filteredProfiles[index];
                return _buildProfileCard(p);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildLockedStateCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.lock_outline,
              color: Colors.orange,
              size: 40,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Profiles Locked',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: primaryNavy,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Please complete your profile registration details to view community matrimony matches and access direct contact details.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 13.5,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const DetailedRegistrationScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryNavy,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              child: const Text(
                'Complete Registration',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(Map<String, dynamic> p) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side Image with badges
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                child: Image.network(
                  p['image'],
                  width: 110,
                  height: 155,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 110,
                    height: 155,
                    color: Colors.grey[200],
                    child: const Icon(Icons.person, size: 48, color: Colors.grey),
                  ),
                ),
              ),
              // Verified badge on Top Left (if green_tag)
              if (p['verifiedType'] == 'green_tag')
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.green[700],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'VERIFIED',
                      style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              // Blue tick badge on Bottom Right (if blue_tick)
              if (p['verifiedType'] == 'blue_tick')
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.verified,
                      color: Color(0xFF00005C),
                      size: 16,
                    ),
                  ),
                ),
            ],
          ),

          // Right side details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Favorite row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          p['name'],
                          style: const TextStyle(
                            color: primaryNavy,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      IconButton(
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          p['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                          color: p['isFavorite'] ? Colors.red : Colors.grey,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            p['isFavorite'] = !p['isFavorite'];
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Age and height
                  Text(
                    '${p['age']} Years  •  ${p['height']}',
                    style: const TextStyle(color: Colors.black54, fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),

                  // Profession
                  Text(
                    p['profession'],
                    style: const TextStyle(color: Colors.black87, fontSize: 13.5, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),

                  // City/State
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, color: Colors.grey, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        '${p['city']}, ${p['state']}',
                        style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // View Profile button
                  SizedBox(
                    width: double.infinity,
                    height: 34,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MatrimonyProfileDetailScreen(profile: p),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryNavy,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        elevation: 0,
                        padding: EdgeInsets.zero,
                      ),
                      child: const Text(
                        'View Profile',
                        style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
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
  }
}

// ==========================================
// 2. MATRIMONY PROFILE DETAIL SCREEN
// ==========================================
class MatrimonyProfileDetailScreen extends StatelessWidget {
  final Map<String, dynamic> profile;
  static const Color primaryNavy = Color(0xFF00005C);
  static const Color accentGold = Color(0xFFE67E22);

  const MatrimonyProfileDetailScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryNavy),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          profile['name'],
          style: const TextStyle(color: primaryNavy, fontWeight: FontWeight.w800, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Profile Image Section
            Stack(
              children: [
                Image.network(
                  profile['image'],
                  width: double.infinity,
                  height: 320,
                  fit: BoxFit.cover,
                ),
                // Shading gradient on bottom
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                // Text details overlay
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            profile['name'],
                            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(width: 8),
                          if (profile['verifiedType'] != 'none')
                            const Icon(Icons.verified, color: Colors.blueAccent, size: 24),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${profile['age']} Years  •  ${profile['height']}  •  ${profile['city']}, ${profile['state']}',
                        style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Profile info cards
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section: About Me
                  _buildSectionHeader('About Me'),
                  _buildContentCard(profile['about']),
                  const SizedBox(height: 20),

                  // Section: Education & Profession
                  _buildSectionHeader('Education & Career'),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        _buildDetailRow(Icons.school_outlined, 'Education Level', profile['education']),
                        const Divider(height: 20),
                        _buildDetailRow(Icons.menu_book_outlined, 'Degree', profile['degree']),
                        const Divider(height: 20),
                        _buildDetailRow(Icons.work_outline, 'Profession', profile['profession']),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Section: Family Details
                  _buildSectionHeader('Family Background'),
                  _buildContentCard(profile['familyBackground']),
                  const SizedBox(height: 24),

                  // Contact / Connect Actions
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Profile Shortlisted!')),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: primaryNavy, width: 1.5),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          icon: const Icon(Icons.bookmark_outline, color: primaryNavy),
                          label: const Text(
                            'Shortlist',
                            style: TextStyle(color: primaryNavy, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Interest Sent', style: TextStyle(color: primaryNavy, fontWeight: FontWeight.bold)),
                                content: Text('An interest request has been sent to the family of ${profile['name']}. You will be notified once they accept.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('OK', style: TextStyle(color: primaryNavy, fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryNavy,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            elevation: 0,
                          ),
                          icon: const Icon(Icons.favorite),
                          label: const Text(
                            'Send Interest',
                            style: TextStyle(fontWeight: FontWeight.bold),
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
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w800,
          color: primaryNavy,
        ),
      ),
    );
  }

  Widget _buildContentCard(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 14,
          height: 1.4,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: primaryNavy.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: primaryNavy, size: 20),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(color: Colors.black87, fontSize: 13.5, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}

// ==========================================
// 3. MATRIMONY PREMIUM VIEW (TAB 2)
// ==========================================
class MatrimonyPremiumView extends StatelessWidget {
  final LanguageProvider lang;
  static const Color primaryNavy = Color(0xFF00005C);
  static const Color accentGold = Color(0xFFE67E22);

  const MatrimonyPremiumView({super.key, required this.lang});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Benefits of Premium Matrimony Main Card (matching 2nd screen top card)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    // Red heart circular card
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.favorite, color: Colors.red, size: 28),
                    ),
                    const SizedBox(width: 16),
                    // Benefits Title
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Benefits Of',
                            style: TextStyle(color: Colors.black54, fontSize: 13, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            'Premium Matrimony',
                            style: TextStyle(color: primaryNavy, fontSize: 18, fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
                const SizedBox(height: 20),
                // Become premium button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BecomePremiumMemberScreen(lang: lang),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryNavy,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    icon: const Icon(Icons.check, size: 18),
                    label: const Text(
                      'Become Premium Member',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Card 1: Verified Community Profiles
          _buildFeatureCard(
            Icons.verified_user_outlined,
            'Verified Community Profiles',
            'Access hand-picked profiles from trusted Gujarati families with verified backgrounds.',
          ),
          const SizedBox(height: 16),

          // Row for two smaller benefit cards
          Row(
            children: [
              Expanded(
                child: _buildSmallFeatureCard(
                  Icons.visibility_outlined,
                  'Profile Views',
                  'See who visited your profile instantly.',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSmallFeatureCard(
                  Icons.chat_bubble_outline,
                  'Direct Chat',
                  'Connect directly with matched families.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Testimonial Box (Navy blue banner with Sangeeta Shah's quote)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: primaryNavy,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '"Found my son\'s life partner through Heritage Core\'s premium service. Highly recommended."',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.5,
                          fontStyle: FontStyle.italic,
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '— Sangeeta Shah',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Circular profile image of Sangeeta Shah
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white24, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100', // Beautiful female portrait
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.white.withValues(alpha: 0.2),
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Assistance section
          const Text(
            'Need assistance? Call our helpdesk',
            style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          // Call button
          SizedBox(
            width: double.infinity,
            height: 46,
            child: OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Connecting to helpdesk +91 98234 56789...')),
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFC0392B), width: 1.2), // Dark red / gold tint
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              icon: const Icon(Icons.phone, color: Color(0xFFC0392B), size: 18),
              label: const Text(
                'Support: +91 98234 56789',
                style: TextStyle(color: Color(0xFFC0392B), fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, String desc) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: accentGold, size: 24),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(color: primaryNavy, fontSize: 14.5, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            desc,
            style: const TextStyle(color: Colors.black54, fontSize: 12.5, height: 1.35, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallFeatureCard(IconData icon, String title, String desc) {
    return Container(
      height: 145,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accentGold, size: 22),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(color: primaryNavy, fontSize: 13.5, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Text(
              desc,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black54, fontSize: 11.5, height: 1.3, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 4. PERSONAL MATCHES VIEW (TAB 3 PLACEHOLDER)
// ==========================================
class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double radius;

  DashedBorderPainter({
    this.color = Colors.grey,
    this.strokeWidth = 1.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
    this.radius = 12.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        strokeWidth / 2,
        strokeWidth / 2,
        size.width - strokeWidth,
        size.height - strokeWidth,
      ),
      Radius.circular(radius),
    );

    final Path path = Path()..addRRect(rrect);
    
    for (final PathMetric metric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        final double len = dashWidth;
        if (distance + len > metric.length) {
          canvas.drawPath(
            metric.extractPath(distance, metric.length),
            paint,
          );
        } else {
          canvas.drawPath(
            metric.extractPath(distance, distance + len),
            paint,
          );
        }
        distance += len + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashSpace != dashSpace ||
        oldDelegate.radius != radius;
  }
}

class PersonalMatchesView extends StatelessWidget {
  final TabController tabController;
  static const Color primaryNavy = Color(0xFF00005C);

  const PersonalMatchesView({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          const Text(
            'Your Personal List',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: primaryNavy,
            ),
          ),
          const SizedBox(height: 16),

          // Member selection card
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100', // Mockup matching male profile photo
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 56,
                      height: 56,
                      color: Colors.grey[200],
                      child: const Icon(Icons.person, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'You have selected 0 members',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: primaryNavy,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Start adding members to your list',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade400,
                  size: 24,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Dashed connection builder card
          CustomPaint(
            painter: DashedBorderPainter(
              color: Colors.grey.shade300,
              radius: 12,
              dashWidth: 4,
              dashSpace: 4,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.favorite_border_rounded,
                    color: primaryNavy,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Build Your Connection',
                    style: TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w800,
                      color: primaryNavy,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Explore the directory to find compatible matches. Use the 'Personal List' to track profiles you find interesting within our community.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13.5,
                      height: 1.45,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      tabController.animateTo(0);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryNavy,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    icon: const Icon(Icons.search, size: 20),
                    label: const Text(
                      'Discover Members',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
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
  }
}

// ==========================================
// 5. BECOME PREMIUM MEMBER SCREEN (SCREEN 3)
// ==========================================
class BecomePremiumMemberScreen extends StatelessWidget {
  final LanguageProvider lang;
  static const Color primaryNavy = Color(0xFF00005C);

  const BecomePremiumMemberScreen({super.key, required this.lang});

  @override
  Widget build(BuildContext context) {
    // Dynamic user name from provider
    final String currentUserName = lang.registeredName.isNotEmpty
        ? lang.registeredName
        : 'Soham Aaditya More';

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Become Premium Member',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
        ),
        backgroundColor: const Color(0xFF3B5998), // Custom premium blue bar
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Member Card 1 (User profile)
          _buildMemberCard(
            context,
            currentUserName,
            'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=200', // Professional male portrait
          ),
          const SizedBox(height: 16),
          // Member Card 2 (Relative profile)
          _buildMemberCard(
            context,
            'Riya Aaditya More',
            'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=200', // Beautiful female portrait
          ),
        ],
      ),
    );
  }

  Widget _buildMemberCard(BuildContext context, String name, String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Square image with rounded corners
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 72,
                      height: 72,
                      color: Colors.grey[200],
                      child: const Icon(Icons.person, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Name
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Actions bar
          const Divider(height: 1, thickness: 0.5),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PaymentOptionsScreen(memberName: name, lang: lang),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: primaryNavy),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text(
                  'Become Premium Member',
                  style: TextStyle(color: primaryNavy, fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 6. PAYMENT OPTIONS SCREEN (SCREEN 4)
// ==========================================
class PaymentOptionsScreen extends StatefulWidget {
  final String memberName;
  final LanguageProvider lang;

  const PaymentOptionsScreen({super.key, required this.memberName, required this.lang});

  @override
  State<PaymentOptionsScreen> createState() => _PaymentOptionsScreenState();
}

class _PaymentOptionsScreenState extends State<PaymentOptionsScreen> {
  static const Color primaryNavy = Color(0xFF00005C);
  
  // Membership options (only one active at a time)
  bool _sixMonthsSelected = true;
  bool _twelveMonthsSelected = false;

  // Personal or Business purchase
  String _purchaseType = 'Personal';

  void _onPlanToggled(bool isSixMonths) {
    setState(() {
      if (isSixMonths) {
        _sixMonthsSelected = true;
        _twelveMonthsSelected = false;
      } else {
        _sixMonthsSelected = false;
        _twelveMonthsSelected = true;
      }
    });
  }

  void _simulatePaymentSuccess() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 72),
                const SizedBox(height: 16),
                const Text(
                  'Upgrade Successful!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryNavy),
                ),
                const SizedBox(height: 8),
                Text(
                  '${widget.memberName} is now a Premium Matrimony Member.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      // Mark user as premium and close payment navigation
                      widget.lang.simulateAdminApproval(); // Simulates registration/login approval + premium
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryNavy,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Go to Home', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Payment Options',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
        ),
        backgroundColor: const Color(0xFF3B5998),
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Membership plan selections
            // Plan 1: 6 months
            _buildPlanCard(
              title: '6 Months Premium Membership',
              price: 'Rs. 2000',
              isSelected: _sixMonthsSelected,
              onTap: () => _onPlanToggled(true),
            ),
            // Plan 2: 12 months
            _buildPlanCard(
              title: '12 Months Premium Membership',
              price: 'Rs. 3000',
              isSelected: _twelveMonthsSelected,
              onTap: () => _onPlanToggled(false),
            ),

            // 2. Subtitle purchase notice
            Container(
              width: double.infinity,
              color: const Color(0xFFF0F4F8),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
              child: const Text(
                'Choose if this is a Personal or Business purchase.',
                style: TextStyle(
                  color: Color(0xFF1B4F72),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // 3. Purchase type Radios
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  RadioListTile<String>(
                    title: const Text('Personal', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
                    value: 'Personal',
                    groupValue: _purchaseType,
                    activeColor: Colors.pink,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                    onChanged: (val) {
                      if (val != null) setState(() => _purchaseType = val);
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Business', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
                    value: 'Business',
                    groupValue: _purchaseType,
                    activeColor: Colors.pink,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                    onChanged: (val) {
                      if (val != null) setState(() => _purchaseType = val);
                    },
                  ),
                ],
              ),
            ),

            // 4. Choose Payment Method Header
            Container(
              width: double.infinity,
              color: const Color(0xFFF0F4F8),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: const Text(
                'CHOOSE PAYMENT METHOD',
                style: TextStyle(
                  color: Color(0xFF1B4F72),
                  fontSize: 12.5,
                  letterSpacing: 1.1,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            // 5. Payment Methods List
            // Option 1: UPI
            _buildPaymentMethodRow(
              icon: Icons.error_outline,
              iconColor: Colors.deepPurple,
              iconBgColor: Colors.purple[50]!,
              title: 'UPI Payment',
              subtitle: 'Google Pay / BHIM app etc',
              buttonText: 'Pay',
              onPressed: _simulatePaymentSuccess,
            ),
            const Divider(height: 1, indent: 16, endIndent: 16),
            // Option 2: Online
            _buildPaymentMethodRow(
              icon: Icons.credit_card,
              iconColor: Colors.deepPurple,
              iconBgColor: Colors.purple[50]!,
              title: 'Online Payment',
              subtitle: 'Card\nWallet\nNetbanking',
              buttonText: 'Pay Online',
              onPressed: _simulatePaymentSuccess,
            ),
            const Divider(height: 1, indent: 16, endIndent: 16),
            // Option 3: Cash
            _buildPaymentMethodRow(
              icon: Icons.wallet_giftcard,
              iconColor: Colors.pink,
              iconBgColor: Colors.pink[50]!,
              title: 'Pay using Cash',
              subtitle: '',
              buttonText: 'Contact Us',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Our executive will contact you for cash collection!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String price,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE), width: 0.5)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Checkbox(
              value: isSelected,
              activeColor: const Color(0xFF3B5998),
              onChanged: (val) => onTap(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodRow({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        children: [
          // Circular Icon badge
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 16),
          // Title & Subtitle info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500, height: 1.25),
                  ),
                ],
              ],
            ),
          ),
          // Action button
          OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: primaryNavy),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            ),
            child: Text(
              buttonText,
              style: const TextStyle(color: primaryNavy, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
