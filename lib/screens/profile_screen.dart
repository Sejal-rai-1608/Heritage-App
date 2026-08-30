import 'dart:io';
import 'package:flutter/material.dart';
import '../widgets/custom_bottom_navbar.dart';
import 'home_screen.dart';
import 'registration_form_screen.dart';
import 'settings_screen.dart';
import 'image_picker_dialog.dart';
import 'member_directory_screen.dart';
import 'family_tree_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String? userName;
  final String? profileImagePath;
  final String? dateOfBirth;
  final String? bloodGroup;
  final String? nativePlace;
  final String? communityWing;
  final String? spouseName;
  final List<String>? childrenNames;
  final int initialTab;

  const ProfileScreen({
    super.key,
    this.userName,
    this.profileImagePath,
    this.dateOfBirth,
    this.bloodGroup,
    this.nativePlace,
    this.communityWing,
    this.spouseName,
    this.childrenNames,
    this.initialTab = 0,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late int _activeTab; // 0: Family, 1: Profile Details, 2: Contact
  String _userHeight = "5 ft 10 in";
  String? _selectedImage;

  // Family Members List
  List<Map<String, String>> _familyMembers = [];

  @override
  void initState() {
    super.initState();
    _activeTab = widget.initialTab;
    _selectedImage = widget.profileImagePath;
    _familyMembers = [
      {'name': 'Aaditya Shantanu', 'relation': 'Father', 'gender': 'male'},
      {'name': 'Vaishali', 'relation': 'Mother', 'gender': 'female'},
      {'name': 'Riya Aaditya More', 'relation': 'Sister', 'gender': 'female'},
    ];

    if (widget.spouseName != null && widget.spouseName!.isNotEmpty) {
      _familyMembers.insert(0, {
        'name': widget.spouseName!,
        'relation': 'Spouse',
        'gender': 'female',
      });
    }
  }

  // STEP 1: Popup 1 Selection Dialog (Matching Image 1)
  void _showAddFamilyMemberDialog() {
    showDialog(
      context: context,
      builder: (dialogCtx) {
        return Dialog(
          backgroundColor: Colors.white,
          elevation: 10,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Container(
            width: 340,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(dialogCtx).size.height - MediaQuery.of(dialogCtx).viewInsets.bottom - 40,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header Row (Avatar with edit badge, Name, Subtitle, Close button)
                  Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFFD9B854), width: 2),
                            ),
                            child: ClipOval(
                              child: _selectedImage != null && File(_selectedImage!).existsSync()
                                  ? Image.file(File(_selectedImage!), fit: BoxFit.cover)
                                  : Image.asset(
                                      'assets/images/image1.jpeg',
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Image.asset(
                                        'assets/images/sanjay_profile.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                color: Color(0xFFD9B854),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Soham Aaditya More',
                              style: TextStyle(
                                fontFamily: 'Serif',
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xFF1E232D),
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'DIRECT DESCENDANT',
                              style: TextStyle(
                                color: Color(0xFFB48A36),
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, size: 20, color: Color(0xFF94A3B8)),
                        onPressed: () => Navigator.pop(dialogCtx),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Divider(color: Colors.grey.shade100, height: 1),
                  const SizedBox(height: 8),

                  // Options List (Add Wife, Add Brother, Add Sister, etc.)
                  _buildAddOptionItem(
                    dialogCtx,
                    icon: Icons.female_outlined,
                    title: 'Add Wife',
                    onTap: () {
                      Navigator.pop(dialogCtx);
                      _showAddMemberFormDialog('Wife');
                    },
                  ),
                  _buildAddOptionItem(
                    dialogCtx,
                    icon: Icons.person_add_alt_1_outlined,
                    title: 'Add Brother',
                    onTap: () {
                      Navigator.pop(dialogCtx);
                      _showAddMemberFormDialog('Brother');
                    },
                  ),
                  _buildAddOptionItem(
                    dialogCtx,
                    icon: Icons.female_outlined,
                    title: 'Add Sister',
                    onTap: () {
                      Navigator.pop(dialogCtx);
                      _showAddMemberFormDialog('Sister');
                    },
                  ),
                  _buildAddOptionItem(
                    dialogCtx,
                    icon: Icons.person_add_alt_1_outlined,
                    title: 'Add Father',
                    onTap: () {
                      Navigator.pop(dialogCtx);
                      _showAddMemberFormDialog('Father');
                    },
                  ),
                  _buildAddOptionItem(
                    dialogCtx,
                    icon: Icons.female_outlined,
                    title: 'Add Mother',
                    onTap: () {
                      Navigator.pop(dialogCtx);
                      _showAddMemberFormDialog('Mother');
                    },
                  ),
                  const SizedBox(height: 14),

                  // Bottom Action Buttons: CONNECT & DELETE
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 42,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(dialogCtx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Connected to family profile')),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0F172A),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'CONNECT',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 42,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(dialogCtx);
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFFECDD3)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'DELETE',
                              style: TextStyle(
                                color: Color(0xFFE11D48),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddOptionItem(
    BuildContext dialogCtx, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F6FE),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: const Color(0xFF1E232D), size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E232D),
                  ),
                ),
              ),
              Icon(Icons.chevron_right, size: 18, color: Colors.grey.shade300),
            ],
          ),
        ),
      ),
    );
  }

  // STEP 2: Popup 2 Input Dialog for Adding Member (Matching Image 2)
  void _showAddMemberFormDialog(String relation) {
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (formCtx) {
        return Dialog(
          backgroundColor: Colors.white,
          elevation: 10,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Container(
            width: 340,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(formCtx).size.height - MediaQuery.of(formCtx).viewInsets.bottom - 40,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top Header Avatar with Golden Outline & Heart Badge
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFD9B854), width: 2.5),
                        ),
                        child: ClipOval(
                          child: _selectedImage != null && File(_selectedImage!).existsSync()
                              ? Image.file(File(_selectedImage!), fit: BoxFit.cover)
                              : Image.asset(
                                  'assets/images/image1.jpeg',
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Image.asset(
                                    'assets/images/sanjay_profile.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Heading Title: "Add [Relation] of Soham Aaditya More"
                  Text(
                    'Add $relation of Soham Aaditya More',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Serif',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF1E232D),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // TextField Label: "[Relation]'s Name"
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "$relation's Name",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Color(0xFF1E232D),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // TextField
                  TextField(
                    controller: nameController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Enter full name',
                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
                        borderSide: const BorderSide(color: Color(0xFF1E232D), width: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Subtitle below field
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Please enter the maiden name or current legal name.',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Primary Button: + ADD
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () {
                        final enteredName = nameController.text.trim();
                        if (enteredName.isNotEmpty) {
                          final isFemale = ['Wife', 'Mother', 'Sister', 'Daughter', 'Spouse'].contains(relation);
                          setState(() {
                            _familyMembers.add({
                              'name': enteredName,
                              'relation': relation,
                              'gender': isFemale ? 'female' : 'male',
                            });
                          });
                          Navigator.pop(formCtx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('$relation "$enteredName" added successfully!')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please enter a valid name')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F172A),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.person_add_alt_1_outlined, color: Colors.white, size: 16),
                          SizedBox(width: 8),
                          Text(
                            'ADD',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Secondary Button: Cancel
                  SizedBox(
                    width: double.infinity,
                    height: 42,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(formCtx),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color(0xFF1E232D),
                          fontWeight: FontWeight.w600,
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
      },
    );
  }

  void _showUpdateHeightDialog() {
    final List<String> heights = [
      '5 ft 4 in',
      '5 ft 5 in',
      '5 ft 6 in',
      '5 ft 7 in',
      '5 ft 8 in',
      '5 ft 9 in',
      '5 ft 10 in',
      '5 ft 11 in',
      '6 ft 0 in',
      '6 ft 1 in',
      '6 ft 2 in',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              const Text(
                'Update Height',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Serif',
                  color: Color(0xFF1E232D),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Select your current height from the list below',
                style: TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
              ),
              const SizedBox(height: 16),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: heights.length,
                  itemBuilder: (context, index) {
                    final h = heights[index];
                    final isSelected = h == _userHeight;
                    return ListTile(
                      title: Text(
                        h,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? const Color(0xFF856404) : Colors.black87,
                        ),
                      ),
                      trailing: isSelected
                          ? const Icon(Icons.check_circle, color: Color(0xFF856404))
                          : null,
                      onTap: () {
                        setState(() => _userHeight = h);
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Height updated to $_userHeight')),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _pickMedia() async {
    final result = await showDialog<String>(
      context: context,
      builder: (_) => const CustomImagePickerDialog(),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        _selectedImage = result;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile media updated!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final String displayName = (widget.userName != null && widget.userName!.isNotEmpty)
        ? widget.userName!
        : 'Soham Aaditya More';

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F8FA),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E232D)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          _activeTab == 1 ? 'Profile Details' : 'Heritage Luxe',
          style: const TextStyle(
            color: Color(0xFF1E232D),
            fontFamily: 'Serif',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (_activeTab == 1)
            IconButton(
              icon: const Icon(Icons.info_outline, color: Color(0xFF1E232D)),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Showing profile verification info')),
                );
              },
            )
          else ...[
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
              icon: const Icon(Icons.notifications_none_outlined, color: Color(0xFF1E232D)),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No new notifications')),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.more_vert, color: Color(0xFF1E232D)),
              onPressed: () {
                _showHeritageCoreSideDrawer();
              },
            ),
          ],
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. HERO PROFILE CARD (Matching Screenshots)
                _buildHeroProfileCard(displayName),
                const SizedBox(height: 16),

                // 2. ACTION CARDS (Shown on Family tab)
                if (_activeTab == 0) ...[
                  _buildAddMediaCard(),
                  const SizedBox(height: 12),
                  _buildUpdateHeightCard(),
                  const SizedBox(height: 20),
                ] else
                  const SizedBox(height: 8),

                // 3. TAB BAR SECTION (Family, Profile Details, Contact)
                _buildTabHeader(),
                const SizedBox(height: 16),

                // 4. TAB CONTENT
                if (_activeTab == 0)
                  _buildFamilyTabContent()
                else if (_activeTab == 1)
                  _buildProfileDetailsTabContent()
                else
                  _buildContactTabContent(),
              ],
            ),
          ),

          // FLOATING BUTTON: "See Family Tree" (when in Family tab)
          if (_activeTab == 0)
            Positioned(
              bottom: 16,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => FamilyTreeScreen(
                        userName: widget.userName,
                        profileImagePath: _selectedImage,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161E2E),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.qr_code_2_outlined, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'See Family Tree',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // FLOATING EDIT BUTTON (when in Profile Details or Contact tab, matching Screenshot 3)
          if (_activeTab == 1 || _activeTab == 2)
            Positioned(
              bottom: 16,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const RegistrationFormScreen(),
                    ),
                  );
                },
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFF161E2E),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3,
        userName: widget.userName,
      ),
    );
  }

  // HERO PROFILE CARD WIDGET
  Widget _buildHeroProfileCard(String displayName) {
    return Container(
      width: double.infinity,
      height: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Profile Image (Asset or File)
            Positioned.fill(
              child: _selectedImage != null && File(_selectedImage!).existsSync()
                  ? Image.file(File(_selectedImage!), fit: BoxFit.cover)
                  : Image.asset(
                      'assets/images/image1.jpeg',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Image.asset(
                        'assets/images/sanjay_profile.png',
                        fit: BoxFit.cover,
                      ),
                    ),
            ),

            // Dark Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.15),
                      Colors.black.withValues(alpha: 0.85),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 0.35, 1.0],
                  ),
                ),
              ),
            ),

            // Content Overlay (Name, Location, Connect Button if tab 0)
            Positioned(
              left: 20,
              right: 20,
              bottom: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Serif',
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      const Expanded(
                        child: Text(
                          'Satara Road, Nala Sopara East',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_activeTab == 0) ...[
                    const SizedBox(height: 14),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Connect request sent!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFDF7D),
                        foregroundColor: Colors.black,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        'Connect',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black87,
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
    );
  }

  // ACTION CARD: Add Profile Media
  Widget _buildAddMediaCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: _pickMedia,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F6FE),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.add_a_photo_outlined,
                    color: Color(0xFF7A6200),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Text(
                    'Add Profile Media',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E232D),
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade400,
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ACTION CARD: Update Height
  Widget _buildUpdateHeightCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F3F8),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: _showUpdateHeightDialog,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1A2130),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.unfold_more,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Update Height',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E232D),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE2E8F0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              _userHeight,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E232D),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Keep your profile current',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.edit_outlined,
                    color: Color(0xFF1E232D),
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TAB HEADER (Family, Profile Details, Contact)
  Widget _buildTabHeader() {
    final tabs = ['Family', 'Profile Details', 'Contact'];

    return Row(
      children: List.generate(tabs.length, (index) {
        final isSelected = _activeTab == index;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _activeTab = index),
            child: Container(
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected ? const Color(0xFF1E232D) : const Color(0xFFE2E8F0),
                    width: isSelected ? 2.5 : 1.0,
                  ),
                ),
              ),
              child: Text(
                tabs[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? const Color(0xFF1E232D) : const Color(0xFF6B7280),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  // FAMILY TAB CONTENT
  Widget _buildFamilyTabContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heading & Add Family Member
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Immediate\nFamily',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Serif',
                color: Color(0xFF1E232D),
                height: 1.15,
              ),
            ),
            GestureDetector(
              onTap: _showAddFamilyMemberDialog,
              child: Row(
                children: const [
                  Icon(Icons.person_add_alt_1_outlined, color: Color(0xFF856404), size: 18),
                  SizedBox(width: 6),
                  Text(
                    'Add Family\nMember',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF856404),
                      height: 1.15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Family Members List Cards
        ..._familyMembers.map((member) {
          final bool isFemale = member['gender'] == 'female';
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: const BoxDecoration(
                    color: Color(0xFFDBEAFE),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isFemale ? Icons.female : Icons.person_outline,
                    color: const Color(0xFF3B82F6),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member['name'] ?? '',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E232D),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      member['relation'] ?? '',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  // PROFILE DETAILS TAB CONTENT (Matching Screenshots 1, 2, 3)
  Widget _buildProfileDetailsTabContent() {
    return Column(
      children: [
        // Card 1: Personal Details (Screenshot 1)
        _buildPersonalDetailsCard(),
        const SizedBox(height: 16),

        // Card 2: Matrimony (Screenshot 1)
        _buildMatrimonyCard(),
        const SizedBox(height: 16),

        // Card 3: Education & Occupation (Screenshot 2)
        _buildEducationOccupationCard(),
        const SizedBox(height: 16),

        // Card 4: Location Details (Screenshot 2)
        _buildLocationDetailsCard(),
        const SizedBox(height: 16),

        // Card 5: Contact Information (Screenshot 3)
        _buildContactInformationCard(),
        const SizedBox(height: 16),

        // Card 6: Other Details (Screenshot 3)
        _buildOtherDetailsCard(),
      ],
    );
  }

  // CONTACT TAB CONTENT (Matching Contact Details Screenshots 1 & 2)
  Widget _buildContactTabContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Header Title & Subtitle
        const Text(
          'Contact Details',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Serif',
            color: Color(0xFF1E232D),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Manage your verified communication channels and addresses.',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 18),

        // CARD 1: MOBILE CONNECTIVITY (White Card)
        _buildMobileConnectivityCard(),
        const SizedBox(height: 16),

        // CARD 2: COMMUNICATION (Dark Navy Card)
        _buildCommunicationCard(),
        const SizedBox(height: 16),

        // CARD 3: RESIDENTIAL ADDRESS (White Card)
        _buildResidentialAddressCard(),
        const SizedBox(height: 16),

        // CARD 4: PROFESSIONAL LINE (White Card)
        _buildProfessionalLineCard(),
      ],
    );
  }

  // CARD 1: MOBILE CONNECTIVITY
  Widget _buildMobileConnectivityCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row with Signal/Tower Icon on Right
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'MOBILE CONNECTIVITY',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF475569),
                  letterSpacing: 0.8,
                ),
              ),
              Icon(
                Icons.cell_tower_outlined,
                color: Color(0xFFD9B854),
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Highlighted Soft Blue Cell Phone Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'CELL PHONE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B),
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '8010594617',
                      style: TextStyle(
                        fontFamily: 'Serif',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E232D),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFEF9C3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.phone,
                    color: Color(0xFF856404),
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // SECONDARY CELL
          const Text(
            'SECONDARY CELL',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '— Not Provided —',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF94A3B8),
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 18),

          // HOME PHONE
          const Text(
            'HOME PHONE',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '— Not Provided —',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF94A3B8),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  // CARD 2: COMMUNICATION (Dark Navy Card)
  Widget _buildCommunicationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: const [
              Icon(
                Icons.mail_outline,
                color: Color(0xFFFDE047),
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'COMMUNICATION',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // EMAIL ADDRESS
          const Text(
            'EMAIL ADDRESS',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF94A3B8),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '— No email linked —',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF94A3B8),
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 20),

          const Divider(color: Colors.white12, height: 1),
          const SizedBox(height: 16),

          // Note Text
          const Text(
            'Keep your contact information updated to receive exclusive invitations and community updates.',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF94A3B8),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 18),

          // "Add Email" Yellow Pill Button
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: () {
                _showAddEmailDialog();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFDE047),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              child: const Text(
                'Add Email',
                style: TextStyle(
                  color: Color(0xFF1E232D),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // CARD 3: RESIDENTIAL ADDRESS
  Widget _buildResidentialAddressCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: const [
              Icon(
                Icons.location_on_outlined,
                color: Color(0xFF1E232D),
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'RESIDENTIAL ADDRESS',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E232D),
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Inner Soft Blue Container
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFEFF6FF)),
            ),
            child: Column(
              children: const [
                Text(
                  '— Address not verified —',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Verify your address to unlock premium local networking features.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF94A3B8),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // CARD 4: PROFESSIONAL LINE
  Widget _buildProfessionalLineCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PROFESSIONAL LINE',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E232D),
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 16),

          // Item 1: WORK LANDLINE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'WORK LANDLINE',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF64748B),
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                '—',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Item 2: WORK MOBILE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'WORK MOBILE',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF64748B),
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                '—',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Item 3: WORK MOBILE 2
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'WORK MOBILE 2',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF64748B),
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                '—',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddEmailDialog() {
    final emailController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: 320,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Add Email Address',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Serif'),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter your email address',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Cancel'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E232D)),
                        onPressed: () {
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Email address submitted for verification')),
                          );
                        },
                        child: const Text('Save', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- CARD 1: PERSONAL DETAILS ---
  Widget _buildPersonalDetailsCard() {
    return _buildDetailCard(
      icon: Icons.person_outline,
      title: 'Personal Details',
      children: [
        _buildRowItem('Religion', '-'),
        _buildRowItem('Birth Place', '-'),
        _buildRowItem('Birth Time', '-'),
        _buildRowItem('Manglik', '-'),
        _buildRowItem('Native Place', 'Satara Road'),
        _buildRowItem('Blood Group', '-'),
      ],
    );
  }

  // --- CARD 2: MATRIMONY ---
  Widget _buildMatrimonyCard() {
    return _buildDetailCard(
      icon: Icons.favorite_outline,
      title: 'Matrimony',
      children: [
        _buildRowItem('Marital Status', 'Single'),
        _buildRowItem('Birth Date', '24 May 2005'),
        _buildRowItem('Height', '-'),
        _buildRowItem('Weight', '-'),
        _buildRowItem('Annual Income', '-'),
        _buildRowItem('Home Ownership', '-'),
      ],
    );
  }

  // --- CARD 3: EDUCATION & OCCUPATION ---
  Widget _buildEducationOccupationCard() {
    return _buildDetailCard(
      icon: Icons.school_outlined,
      title: 'Education &\nOccupation',
      children: [
        const SizedBox(height: 4),
        // Education Level box
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F6FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Education Level',
                style: TextStyle(fontSize: 11, color: Color(0xFF6B7280)),
              ),
              SizedBox(height: 4),
              Text(
                'B.E./B.Tech (Engineering)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E232D),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Education Detail box
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F6FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Education Detail',
                style: TextStyle(fontSize: 11, color: Color(0xFF6B7280)),
              ),
              SizedBox(height: 4),
              Text(
                'B.E./B.Tech (Engineering)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E232D),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Occupation Sub-Section
        Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Color(0xFFFEF3C7),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.work_outline,
                color: Color(0xFF856404),
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Occupation',
                  style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                ),
                SizedBox(height: 2),
                Text(
                  'Student',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E232D),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildRowItem('Occupation Detail', '-'),
      ],
    );
  }

  // --- CARD 4: LOCATION DETAILS ---
  Widget _buildLocationDetailsCard() {
    return _buildDetailCard(
      icon: Icons.map_outlined,
      title: 'Location Details',
      children: [
        const SizedBox(height: 4),
        // Blue Location Banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFD9E6FF),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  color: Color(0xFFBFDBFE),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.explore_outlined,
                  color: Color(0xFF1D4ED8),
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Maharashtra, India',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E232D),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Thane Region',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildSubColumnItem('City', 'Thane')),
            Expanded(child: _buildSubColumnItem('Area', 'Nala Sopara East')),
          ],
        ),
        const SizedBox(height: 14),
        _buildSubColumnItem('Pin Code', '401209'),
      ],
    );
  }

  // --- CARD 5: CONTACT INFORMATION ---
  Widget _buildContactInformationCard() {
    return _buildDetailCard(
      icon: Icons.contact_mail_outlined,
      title: 'Contact Information',
      children: [
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.phone_outlined, size: 18, color: Color(0xFF6B7280)),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Cell Phone', style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
                SizedBox(height: 2),
                Text('8010594617', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1E232D))),
              ],
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            const Icon(Icons.email_outlined, size: 18, color: Color(0xFF6B7280)),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Email Address', style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
                SizedBox(height: 2),
                Text('-', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1E232D))),
              ],
            ),
          ],
        ),
        const SizedBox(height: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Full Address', style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
            SizedBox(height: 2),
            Text('Nala Sopara East', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1E232D))),
          ],
        ),
      ],
    );
  }

  // --- CARD 6: OTHER DETAILS ---
  Widget _buildOtherDetailsCard() {
    return _buildDetailCard(
      icon: Icons.article_outlined,
      title: 'Other Details',
      children: [
        Row(
          children: [
            Expanded(child: _buildSubColumnItem('Hobby', '-')),
            Expanded(child: _buildSubColumnItem('Diet', '-')),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(child: _buildSubColumnItem('Drink Alcohol', '-')),
            Expanded(child: _buildSubColumnItem('Smoke', '-')),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(child: _buildSubColumnItem('Tobacco', '-')),
            Expanded(child: _buildSubColumnItem('Body Type', '-')),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(child: _buildSubColumnItem('Physical Disability', '-')),
            Expanded(child: _buildSubColumnItem('Health Problem', '-')),
          ],
        ),
        const SizedBox(height: 18),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('About Me', style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
            SizedBox(height: 4),
            Text(
              'No additional information provided.',
              style: TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
            ),
          ],
        ),
      ],
    );
  }

  // HELPER WIDGET FOR CARD CONTAINER
  Widget _buildDetailCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF856404), size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Serif',
                    color: Color(0xFF1E232D),
                    height: 1.15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(color: Colors.grey.shade200, height: 1),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }

  Widget _buildRowItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF6B7280),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E232D),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubColumnItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E232D),
          ),
        ),
      ],
    );
  }

  // HERITAGE CORE SIDE DRAWER (Matching Screenshot)
  void _showHeritageCoreSideDrawer() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'SideDrawer',
      barrierColor: Colors.black.withValues(alpha: 0.4),
      transitionDuration: const Duration(milliseconds: 280),
      pageBuilder: (ctx, anim1, anim2) {
        return Align(
          alignment: Alignment.centerRight,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.82,
              height: double.infinity,
              color: Colors.white,
              child: SafeArea(
                child: Column(
                  children: [
                    // 1. Top Header Row: "Heritage Core" + Close (X)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Heritage Core',
                            style: TextStyle(
                              fontFamily: 'Serif',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E232D),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Color(0xFF1E232D), size: 22),
                            onPressed: () => Navigator.pop(ctx),
                          ),
                        ],
                      ),
                    ),

                    // Scrollable Menu Content
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 2. User Profile Card
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFDF5),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: const Color(0xFFFEF3C7)),
                              ),
                              child: Row(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: 52,
                                        height: 52,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: const Color(0xFFD9B854), width: 2),
                                        ),
                                        child: ClipOval(
                                          child: _selectedImage != null && File(_selectedImage!).existsSync()
                                              ? Image.file(File(_selectedImage!), fit: BoxFit.cover)
                                              : Image.asset(
                                                  'assets/images/image1.jpeg',
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (_, __, ___) => Image.asset(
                                                    'assets/images/sanjay_profile.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 2,
                                        bottom: 2,
                                        child: Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF22C55E),
                                            shape: BoxShape.circle,
                                            border: Border.all(color: Colors.white, width: 2),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          (widget.userName != null && widget.userName!.isNotEmpty)
                                              ? widget.userName!
                                              : 'Soham Aaditya More',
                                          style: const TextStyle(
                                            fontFamily: 'Serif',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Color(0xFF1E232D),
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Row(
                                          children: const [
                                            Icon(Icons.location_on_outlined, size: 12, color: Color(0xFF6B7280)),
                                            SizedBox(width: 2),
                                            Expanded(
                                              child: Text(
                                                'Satara Road, Nala Sopara.',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: Color(0xFF6B7280),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.verified,
                                    color: Color(0xFF856404),
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 18),

                            // 3. Primary Action Button: FAMILY TREE
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                  _showFamilyTreeModal();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF161E2E),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.hub_outlined, color: Colors.white, size: 20),
                                    SizedBox(width: 10),
                                    Text(
                                      'FAMILY TREE',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // 4. Menu Items
                            _buildDrawerMenuItem(
                              icon: Icons.groups_outlined,
                              title: 'Directory',
                              onTap: () {
                                Navigator.pop(ctx);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => MemberDirectoryScreen(userName: widget.userName),
                                  ),
                                );
                              },
                            ),
                            _buildDrawerMenuItem(
                              icon: Icons.edit_note_outlined,
                              title: 'Edit Profile',
                              onTap: () {
                                Navigator.pop(ctx);
                                setState(() => _activeTab = 1); // Switch to Profile Details tab
                              },
                            ),
                            _buildDrawerMenuItem(
                              icon: Icons.camera_alt_outlined,
                              title: 'Change Photo',
                              onTap: () {
                                Navigator.pop(ctx);
                                _pickMedia();
                              },
                            ),
                            _buildDrawerMenuItem(
                              icon: Icons.mail_outline,
                              title: 'Inbox',
                              hasNotificationBadge: true,
                              onTap: () {
                                Navigator.pop(ctx);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Inbox opened')),
                                );
                              },
                            ),
                            const SizedBox(height: 8),
                            Divider(color: Colors.grey.shade200, height: 1),
                            const SizedBox(height: 8),

                            _buildDrawerMenuItem(
                              icon: Icons.translate_outlined,
                              title: 'BHASHA BADLA',
                              onTap: () {
                                Navigator.pop(ctx);
                                _showLanguageDialog();
                              },
                            ),
                            _buildDrawerMenuItem(
                              icon: Icons.autorenew_outlined,
                              title: 'Refresh',
                              onTap: () {
                                Navigator.pop(ctx);
                                setState(() {});
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Profile refreshed')),
                                );
                              },
                            ),
                            _buildDrawerMenuItem(
                              icon: Icons.share_outlined,
                              title: 'Share',
                              onTap: () {
                                Navigator.pop(ctx);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Sharing profile link...')),
                                );
                              },
                            ),
                            const SizedBox(height: 14),

                            // 5. Problem in Profile Red Card
                            InkWell(
                              onTap: () {
                                Navigator.pop(ctx);
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                                );
                              },
                              borderRadius: BorderRadius.circular(14),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEF2F2),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: const Color(0xFFFCA5A5)),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.warning_amber_rounded,
                                      color: Color(0xFFDC2626),
                                      size: 22,
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        'Problem in Profile',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Color(0xFFDC2626),
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      color: Color(0xFFDC2626),
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),

                    // 6. Footer Section
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF8FAFC),
                        border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
                      ),
                      child: Column(
                        children: const [
                          Text(
                            'HERITAGE V2.4.0',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            '© 2024 Heritage Core Professional Network',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (ctx, anim1, anim2, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim1, curve: Curves.easeOutCubic)),
          child: child,
        );
      },
    );
  }

  Widget _buildDrawerMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool hasNotificationBadge = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            children: [
              Stack(
                children: [
                  Icon(icon, color: const Color(0xFF475569), size: 22),
                  if (hasNotificationBadge)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: Color(0xFFDC2626),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E232D),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Select Language / bhaaShaa chunae'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                trailing: const Icon(Icons.check, color: Color(0xFF856404)),
                onTap: () => Navigator.pop(ctx),
              ),
              ListTile(
                title: const Text('hiMdi (Hindi)'),
                onTap: () => Navigator.pop(ctx),
              ),
              ListTile(
                title: const Text('maraaTHii (Marathi)'),
                onTap: () => Navigator.pop(ctx),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFamilyTreeModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: const EdgeInsets.all(24),
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Family Tree',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Serif',
                      color: Color(0xFF1E232D),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Grandparents
                      _buildTreeNode('Shantanu More', 'Grandfather', isRoot: true),
                      const SizedBox(height: 16),
                      Container(width: 2, height: 24, color: const Color(0xFF856404)),
                      const SizedBox(height: 16),

                      // Parents
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildTreeNode('Aaditya Shantanu', 'Father'),
                          _buildTreeNode('Vaishali', 'Mother'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(width: 2, height: 24, color: const Color(0xFF856404)),
                      const SizedBox(height: 16),

                      // Children / Current User
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildTreeNode('Soham Aaditya More', 'Self (You)', isHighlight: true),
                          _buildTreeNode('Riya Aaditya More', 'Sister'),
                        ],
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
  }

  Widget _buildTreeNode(String name, String relation, {bool isRoot = false, bool isHighlight = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isHighlight
            ? const Color(0xFFFFF7DB)
            : (isRoot ? const Color(0xFF161E2E) : const Color(0xFFF1F5F9)),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isHighlight ? const Color(0xFF856404) : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: isRoot ? Colors.white : const Color(0xFF1E232D),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            relation,
            style: TextStyle(
              fontSize: 11,
              color: isRoot
                  ? Colors.white70
                  : (isHighlight ? const Color(0xFF856404) : Colors.grey.shade600),
            ),
          ),
        ],
      ),
    );
  }
}
