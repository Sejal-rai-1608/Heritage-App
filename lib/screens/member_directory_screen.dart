import 'package:flutter/material.dart';
import 'new_message_screen.dart';
import '../widgets/custom_bottom_navbar.dart';

class MemberDirectoryScreen extends StatefulWidget {
  final String? userName;

  const MemberDirectoryScreen({super.key, this.userName});

  @override
  State<MemberDirectoryScreen> createState() => _MemberDirectoryScreenState();
}

class Member {
  final String name;
  final String firstName;
  final String city;
  final String profession;
  final IconData professionIcon;
  final String imageUrl;

  Member({
    required this.name,
    required this.firstName,
    required this.city,
    required this.profession,
    required this.professionIcon,
    required this.imageUrl,
  });
}

class _MemberDirectoryScreenState extends State<MemberDirectoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCity = 'All Cities';
  String _selectedProfession = 'All Professions';

  final List<String> _cities = [
    'All Cities',
    'Ahmedabad',
    'Surat',
    'Rajkot',
    'Vadodara',
    'Bhavnagar',
    'Jamnagar',
  ];

  final List<String> _professions = [
    'All Professions',
    'Textile Business',
    'Gynecologist',
    'Civil Engineer',
    'School Principal',
    'Software Consultant',
    'Diamond Merchant',
    'Interior Designer',
  ];

  final List<Member> _allMembers = [
    Member(
      name: 'Amit I. Patel',
      firstName: 'Amit',
      city: 'Ahmedabad',
      profession: 'Textile Business',
      professionIcon: Icons.business_center_outlined,
      imageUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=400',
    ),
    Member(
      name: 'Anjali Shah',
      firstName: 'Anjali',
      city: 'Surat',
      profession: 'Gynecologist',
      professionIcon: Icons.local_hospital_outlined,
      imageUrl:
          'https://images.unsplash.com/photo-1594824813566-88855ce78907?auto=format&fit=crop&q=80&w=400',
    ),
    Member(
      name: 'Bharat Gandhi',
      firstName: 'Bharat',
      city: 'Rajkot',
      profession: 'Civil Engineer',
      professionIcon: Icons.architecture_outlined,
      imageUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&q=80&w=400',
    ),
    Member(
      name: 'Bhavna Desai',
      firstName: 'Bhavna',
      city: 'Vadodara',
      profession: 'School Principal',
      professionIcon: Icons.school_outlined,
      imageUrl:
          'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&q=80&w=400',
    ),
    Member(
      name: 'Chirag Mehta',
      firstName: 'Chirag',
      city: 'Ahmedabad',
      profession: 'Software Consultant',
      professionIcon: Icons.laptop_mac_outlined,
      imageUrl:
          'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&q=80&w=400',
    ),
    Member(
      name: 'Deepak Joshi',
      firstName: 'Deepak',
      city: 'Surat',
      profession: 'Diamond Merchant',
      professionIcon: Icons.diamond_outlined,
      imageUrl:
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&q=80&w=400',
    ),
    Member(
      name: 'Kavita Trivedi',
      firstName: 'Kavita',
      city: 'Ahmedabad',
      profession: 'Interior Designer',
      professionIcon: Icons.palette_outlined,
      imageUrl:
          'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&q=80&w=400',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Member> get _filteredMembers {
    return _allMembers.where((member) {
      final matchesSearch = _searchQuery.isEmpty ||
          member.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          member.profession.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          member.city.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesCity =
          _selectedCity == 'All Cities' || member.city == _selectedCity;

      final matchesProfession = _selectedProfession == 'All Professions' ||
          member.profession == _selectedProfession;

      return matchesSearch && matchesCity && matchesProfession;
    }).toList();
  }

  Map<String, List<Member>> get _groupedMembers {
    final Map<String, List<Member>> grouped = {};
    for (var member in _filteredMembers) {
      final letter = member.name.substring(0, 1).toUpperCase();
      if (!grouped.containsKey(letter)) {
        grouped[letter] = [];
      }
      grouped[letter]!.add(member);
    }
    return grouped;
  }

  void _showContactOptions(BuildContext context, Member member) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Contact ${member.name}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                  fontFamily: 'Serif',
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${member.profession} • ${member.city}',
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 24),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF0F172A),
                  child: Icon(Icons.chat_bubble_outline, color: Colors.white, size: 20),
                ),
                title: const Text('Send In-App Message',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NewMessageScreen(),
                    ),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF25D366),
                  child: Icon(Icons.phone, color: Colors.white, size: 20),
                ),
                title: const Text('WhatsApp / Phone Call',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Calling ${member.name}...'),
                      backgroundColor: const Color(0xFF0F172A),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _groupedMembers;
    final sortedLetters = grouped.keys.toList()..sort();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0F172A), size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Heritage Luxe',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Serif',
          ),
        ),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_none_outlined,
                    color: Color(0xFF0F172A), size: 24),
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFB45309),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {},
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Search Bar Input
            Container(
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
                  hintText: 'Search members by name...',
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
            const SizedBox(height: 16),

            // 2. City Dropdown Filter
            const Text(
              'City',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCity,
                  isExpanded: true,
                  icon: const Icon(Icons.unfold_more, color: Color(0xFF475569)),
                  style: const TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() => _selectedCity = newValue);
                    }
                  },
                  items: _cities.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 3. Profession Dropdown Filter
            const Text(
              'Profession',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedProfession,
                  isExpanded: true,
                  icon: const Icon(Icons.unfold_more, color: Color(0xFF475569)),
                  style: const TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() => _selectedProfession = newValue);
                    }
                  },
                  items: _professions.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 4. Alphabetically Grouped Member Sections
            if (sortedLetters.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: Center(
                  child: Text(
                    'No members found matching your search.',
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
                  ),
                ),
              )
            else
              ...sortedLetters.map((letter) {
                final members = grouped[letter]!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Header: Letter with Divider
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                      child: Row(
                        children: [
                          Text(
                            letter,
                            style: const TextStyle(
                              color: Color(0xFF9A7B38),
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Serif',
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Divider(
                              color: Color(0xFFE2E8F0),
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Member Cards for this Letter
                    ...members.map((member) => _buildMemberCard(context, member)),
                  ],
                );
              }),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        userName: widget.userName,
      ),
    );
  }

  Widget _buildMemberCard(BuildContext context, Member member) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
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
        children: [
          // Top Row: Details on Left, Image on Right
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.name,
                      style: const TextStyle(
                        color: Color(0xFF0F172A),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Serif',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: Color(0xFF64748B),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          member.city,
                          style: const TextStyle(
                            color: Color(0xFF475569),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          member.professionIcon,
                          size: 16,
                          color: const Color(0xFF64748B),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            member.profession,
                            style: const TextStyle(
                              color: Color(0xFF475569),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),

              // Profile Image
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  member.imageUrl,
                  width: 82,
                  height: 82,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 82,
                      height: 82,
                      color: const Color(0xFFF1F5F9),
                      child: const Icon(
                        Icons.person,
                        size: 40,
                        color: Color(0xFF94A3B8),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Bottom Full Width Black Pill Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _showContactOptions(context, member),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.chat_bubble_outline,
                    size: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Contact ${member.firstName}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
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
