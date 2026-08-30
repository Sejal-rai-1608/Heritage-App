import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../widgets/custom_bottom_navbar.dart';
import 'home_screen.dart';

class FamilyTreeScreen extends StatefulWidget {
  final String? userName;
  final String? profileImagePath;

  const FamilyTreeScreen({
    super.key,
    this.userName,
    this.profileImagePath,
  });

  @override
  State<FamilyTreeScreen> createState() => _FamilyTreeScreenState();
}

class _FamilyTreeScreenState extends State<FamilyTreeScreen> {
  // Level of visible tree:
  // 1 = Focus Member only
  // 2 = Parents & Children
  // 3 = 3-Generations Grandparents, Parents & Children
  int _treeLevel = 1;

  void _expandTreeUp() {
    setState(() {
      if (_treeLevel < 3) {
        _treeLevel++;
      } else {
        _treeLevel = 1; // Toggle back to focus member
      }
    });
  }

  void _reduceGenerations() {
    setState(() {
      if (_treeLevel > 1) {
        _treeLevel--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final bool isGu = lang.currentLanguage == 'gu';

    final displayName = (widget.userName != null && widget.userName!.isNotEmpty)
        ? (isGu ? widget.userName! : 'Soham Aaditya More')
        : (isGu ? 'સોહમ આદિત્ય મોરે' : 'Soham Aaditya More');

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Color(0xFF1E232D)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isGu ? 'ફેમિલી ટ્રી' : 'Family Tree',
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
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isGu
                        ? 'સભ્યો ઉમેરવા માટે પ્રોફાઇલ સ્ક્રીન પર "+ કુટુંબના સભ્ય ઉમેરો" વાપરો'
                        : 'Use "+ Add Family Member" on Profile Screen to add members',
                  ),
                ),
              );
            },
            child: Text(
              isGu ? 'ઉમેરો' : 'Add',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF1E232D),
                letterSpacing: 0.8,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFF1E232D)),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Top Yellow Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF9E6),
                  border: Border(bottom: BorderSide(color: Color(0xFFFEF08A))),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.person_add_alt_1_outlined, size: 18, color: Color(0xFF856404)),
                    const SizedBox(width: 8),
                    Text(
                      _treeLevel == 1
                          ? (isGu ? "સોહમના ફેમિલી ટ્રીમાં ઉમેરો" : "Add Family to Soham's Tree")
                          : (_treeLevel == 2
                              ? (isGu ? "આદિત્યના ફેમિલી ટ્રીમાં ઉમેરો" : "Add Family to Aditya's Tree")
                              : (isGu ? "શાંતનુના ફેમિલી ટ્રીમાં ઉમેરો" : "Add Family to Shantanu's Tree")),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF856404),
                      ),
                    ),
                  ],
                ),
              ),

              // Main Tree Flow View
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 100),
                  child: Column(
                    children: [
                      // Header Title
                      Text(
                        _treeLevel == 1
                            ? (isGu
                                ? 'સોહમ આદિત્ય મોરે (સતારા રોડ) ફેમિલી-૧'
                                : 'Soham Aaditya More (Satara Road) Family-1')
                            : (_treeLevel == 2
                                ? (isGu
                                    ? 'આદિત્ય શાંતનુ મોરે (સતારા રોડ)'
                                    : 'Aditya Shantanu More (Satara Road)')
                                : (isGu ? 'શાંતનુ મોરે (સતારા રોડ)' : 'Shantanu More (Satara Road)')),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Serif',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E232D),
                          height: 1.25,
                        ),
                      ),
                      if (_treeLevel == 2) ...[
                        const SizedBox(height: 4),
                        Text(
                          isGu ? 'ફેમિલી-૪' : 'Family-4',
                          style: const TextStyle(
                            fontFamily: 'Serif',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF856404),
                          ),
                        ),
                      ] else if (_treeLevel == 3) ...[
                        const SizedBox(height: 4),
                        Text(
                          isGu ? 'ફેમિલી-૬' : 'Family-6',
                          style: const TextStyle(
                            fontFamily: 'Serif',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF856404),
                          ),
                        ),
                      ],
                      const SizedBox(height: 6),

                      // Subtitle Instructions
                      GestureDetector(
                        onTap: _expandTreeUp,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.history_toggle_off, size: 14, color: Color(0xFF6B7280)),
                            const SizedBox(width: 4),
                            Text(
                              isGu
                                  ? 'માતાપિતા જોવા માટે ઉપરનો એરો ક્લિક કરો.'
                                  : 'Tap up arrow to view parents & lineage.',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // RENDER TREE FLOW CHART ACCORDING TO LEVEL
                      if (_treeLevel == 1)
                        _buildLevel1FocusView(displayName, isGu)
                      else if (_treeLevel == 2)
                        _buildLevel2ParentsChildrenView(isGu)
                      else
                        _buildLevel3FullGenerationsView(isGu),

                      const SizedBox(height: 30),

                      // Share Family Tree Button
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isGu ? 'ફેમિલી ટ્રી શેર થઈ રહ્યું છે...' : 'Sharing family tree...',
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.share_outlined, size: 16, color: Color(0xFF6B7280)),
                            const SizedBox(width: 6),
                            Text(
                              isGu ? 'ફેમિલી ટ્રી શેર કરો' : 'Share Family Tree',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3,
        userName: widget.userName,
      ),
    );
  }

  // --- LEVEL 1: FOCUS MEMBER CARD ---
  Widget _buildLevel1FocusView(String name, bool isGu) {
    return Column(
      children: [
        // Up Arrow Line
        GestureDetector(
          onTap: _expandTreeUp,
          child: Column(
            children: [
              const Icon(Icons.arrow_upward, size: 24, color: Color(0xFF475569)),
              Container(width: 2, height: 36, color: const Color(0xFFCBD5E1)),
            ],
          ),
        ),

        // Focus Member Card
        Container(
          width: 280,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Avatar with Golden Ring
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFD9B854), width: 3),
                ),
                child: ClipOval(
                  child: widget.profileImagePath != null && File(widget.profileImagePath!).existsSync()
                      ? Image.file(File(widget.profileImagePath!), fit: BoxFit.cover)
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
              const SizedBox(height: 12),

              // FOCUS MEMBER Badge
              Text(
                isGu ? 'મુખ્ય સભ્ય' : 'FOCUS MEMBER',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  color: Color(0xFFB48A36),
                ),
              ),
              const SizedBox(height: 4),

              Text(
                name,
                style: const TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E232D),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                isGu ? 'પેઢી ૧' : 'GENERATION 1',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 16),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isGu
                                ? 'સોહમ મોરેની પ્રોફાઇલ વિગતો જુઓ'
                                : 'Viewing profile details of Soham More',
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F172A),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    ),
                    child: Text(
                      isGu ? 'વિગતો જુઓ' : 'View Details',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.edit_outlined, size: 18, color: Color(0xFF1E232D)),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Down Arrow Connector Line & Dot
        Column(
          children: [
            Container(width: 2, height: 40, color: const Color(0xFFE2E8F0)),
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFFCBD5E1),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // --- LEVEL 2: PARENTS & CHILDREN FLOW CHART ---
  Widget _buildLevel2ParentsChildrenView(bool isGu) {
    return Column(
      children: [
        // Parents Row (Top)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTreeNodeItem(
              name: isGu ? 'આદિત્ય મોરે' : 'Aditya More',
              imagePath: 'assets/images/sanjay_profile.png',
              directionIcon: Icons.arrow_upward,
              onTap: _expandTreeUp,
            ),
            _buildTreeNodeItem(
              name: isGu ? 'વૈશાલી મોરે' : 'Vaishali More',
              imagePath: null,
              directionIcon: Icons.arrow_upward,
              onTap: _expandTreeUp,
            ),
          ],
        ),

        _buildTConnectorLine(),

        // Children Row (Bottom)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTreeNodeItem(
              name: isGu ? 'સોહમ મોરે' : 'Soham More',
              imagePath: widget.profileImagePath ?? 'assets/images/image1.jpeg',
              directionIcon: Icons.arrow_downward,
              isHighlight: true,
              onTap: () {},
            ),
            _buildTreeNodeItem(
              name: isGu ? 'રીયા મોરે' : 'Riya More',
              imagePath: null,
              directionIcon: Icons.arrow_downward,
              onTap: () {},
            ),
          ],
        ),

        const SizedBox(height: 20),
        OutlinedButton(
          onPressed: _reduceGenerations,
          child: Text(
            isGu ? 'ઓછી પેઢીઓ' : 'Fewer Generations',
            style: const TextStyle(color: Color(0xFF856404)),
          ),
        ),
      ],
    );
  }

  // --- LEVEL 3: 3-GENERATIONS FULL FLOW CHART ---
  Widget _buildLevel3FullGenerationsView(bool isGu) {
    return Column(
      children: [
        // 1. Grandparents Generation (Top)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTreeNodeItem(
              name: isGu ? 'શાંતનુ મોરે' : 'Shantanu More',
              imagePath: 'assets/images/sanjay_profile.png',
              directionIcon: Icons.arrow_upward,
              onTap: () {},
            ),
            _buildTreeNodeItem(
              name: isGu ? 'માનસી મોરે' : 'Manasi More',
              imagePath: null,
              directionIcon: Icons.arrow_upward,
              onTap: () {},
            ),
          ],
        ),

        _buildTConnectorLine(),

        // 2. Parents Generation (Middle)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTreeNodeItem(
              name: isGu ? 'આદિત્ય મોરે' : 'Aditya More',
              imagePath: 'assets/images/sanjay_profile.png',
              directionIcon: Icons.arrow_downward,
              onTap: () {},
            ),
            _buildTreeNodeItem(
              name: isGu ? 'વૈશાલી મોરે' : 'Vaishali More',
              imagePath: null,
              directionIcon: Icons.arrow_upward,
              onTap: () {},
            ),
          ],
        ),

        _buildTConnectorLine(),

        // 3. Children Generation (Bottom)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTreeNodeItem(
              name: isGu ? 'સોહમ મોરે' : 'Soham More',
              imagePath: widget.profileImagePath ?? 'assets/images/image1.jpeg',
              directionIcon: Icons.arrow_downward,
              isHighlight: true,
              hasBadge: true,
              onTap: () {},
            ),
            _buildTreeNodeItem(
              name: isGu ? 'રીયા મોરે' : 'Riya More',
              imagePath: null,
              directionIcon: Icons.arrow_downward,
              onTap: () {},
            ),
          ],
        ),

        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: _reduceGenerations,
              child: Column(
                children: [
                  Text(isGu ? 'ઓછી' : 'FEWER', style: const TextStyle(color: Color(0xFF856404), fontWeight: FontWeight.bold, fontSize: 13)),
                  Text(isGu ? 'પેઢીઓ' : 'GENERATIONS', style: const TextStyle(color: Color(0xFF64748B), fontSize: 11)),
                ],
              ),
            ),
            GestureDetector(
              onTap: _reduceGenerations,
              child: Column(
                children: [
                  Text(isGu ? 'ઓછી' : 'FEWER', style: const TextStyle(color: Color(0xFF856404), fontWeight: FontWeight.bold, fontSize: 13)),
                  Text(isGu ? 'પેઢીઓ' : 'GENERATIONS', style: const TextStyle(color: Color(0xFF64748B), fontSize: 11)),
                ],
              ),
            ),
            GestureDetector(
              onTap: _reduceGenerations,
              child: Column(
                children: [
                  Text(isGu ? 'ઓછી' : 'FEWER', style: const TextStyle(color: Color(0xFF856404), fontWeight: FontWeight.bold, fontSize: 13)),
                  Text(isGu ? 'પેઢીઓ' : 'GENERATIONS', style: const TextStyle(color: Color(0xFF64748B), fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // TREE NODE WIDGET
  Widget _buildTreeNodeItem({
    required String name,
    required String? imagePath,
    required IconData directionIcon,
    bool isHighlight = false,
    bool hasBadge = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(directionIcon, size: 12, color: const Color(0xFF475569)),
              const SizedBox(width: 2),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E232D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            width: 120,
            height: 140,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isHighlight ? const Color(0xFF1E232D) : const Color(0xFFFEF08A),
                width: isHighlight ? 2 : 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (imagePath != null && imagePath.isNotEmpty)
                    (File(imagePath).existsSync()
                        ? Image.file(File(imagePath), fit: BoxFit.cover, width: double.infinity, height: double.infinity)
                        : Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity, height: double.infinity,
                            errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 40, color: Color(0xFFCBD5E1))))
                  else
                    const Icon(Icons.person_outline, size: 44, color: Color(0xFFCBD5E1)),

                  if (hasBadge)
                    Positioned(
                      bottom: 8,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: Color(0xFF856404),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.person, color: Colors.white, size: 10),
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

  // T-CONNECTOR HIERARCHY LINE
  Widget _buildTConnectorLine() {
    return Container(
      height: 36,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: CustomPaint(
        size: const Size(160, 36),
        painter: _TConnectorPainter(),
      ),
    );
  }
}

// CUSTOM PAINTER FOR T-CONNECTOR LINES IN TREE
class _TConnectorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final double width = size.width;
    final double height = size.height;
    final double midX = width / 2;
    final double midY = height / 2;

    // Top vertical stem
    canvas.drawLine(Offset(midX, 0), Offset(midX, midY), paint);

    // Horizontal crossbar
    canvas.drawLine(Offset(20, midY), Offset(width - 20, midY), paint);

    // Left & right downward stems
    canvas.drawLine(Offset(20, midY), Offset(20, height), paint);
    canvas.drawLine(Offset(width - 20, midY), Offset(width - 20, height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
