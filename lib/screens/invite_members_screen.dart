import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class InviteMembersScreen extends StatefulWidget {
  const InviteMembersScreen({super.key});

  @override
  State<InviteMembersScreen> createState() => _InviteMembersScreenState();
}

class _InviteMembersScreenState extends State<InviteMembersScreen> {
  static const Color primaryNavy = Color(0xFF00005C);
  String _activeTab = 'Contacts'; // 'Recents', 'Contacts', 'Groups'
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _sendInvite(String contactName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.share, color: primaryNavy),
            const SizedBox(width: 8),
            const Text(
              'Invite Member',
              style: TextStyle(
                color: primaryNavy,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        content: Text(
          'Send invitation link to $contactName?',
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Invitation sent to $contactName successfully!',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryNavy,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Send Invite',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final allProviderContacts = lang.contacts;

    final filteredProviderContacts = allProviderContacts
        .where(
          (c) => (c['name'] as String).toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ),
        )
        .toList();

    final filteredFavourites = filteredProviderContacts
        .where((c) => c['isFavourite'] == true)
        .map((c) => c['name'] as String)
        .toList();

    final filteredContacts = filteredProviderContacts
        .where((c) => c['isFavourite'] != true)
        .map((c) => c['name'] as String)
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.close, color: primaryNavy),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Row(
          children: [
            Icon(Icons.shield_outlined, color: primaryNavy, size: 24),
            SizedBox(width: 8),
            Text(
              'Private access',
              style: TextStyle(
                color: primaryNavy,
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // --- Custom Tabs (Recents, Contacts, Groups) ---
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTabItem('Recents'),
                  _buildTabItem('Contacts'),
                  _buildTabItem('Groups'),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.grey),

            if (_activeTab == 'Contacts') ...[
              // --- Search Bar ---
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (val) {
                      setState(() {
                        _searchQuery = val;
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      hintText: '${lang.contacts.length} contacts',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
              ),

              // --- Contacts List & Sidebar Index ---
              Expanded(
                child: Row(
                  children: [
                    // Main list
                    Expanded(
                      child: ListView(
                        children: [
                          if (filteredFavourites.isNotEmpty) ...[
                            _buildSectionHeader('FAVOURITES'),
                            ...filteredFavourites.map(
                              (name) => _buildContactTile(name),
                            ),
                          ],
                          if (filteredContacts.isNotEmpty) ...[
                            _buildSectionHeader('A'),
                            ...filteredContacts.map(
                              (name) => _buildContactTile(name),
                            ),
                          ],
                          if (filteredFavourites.isEmpty &&
                              filteredContacts.isEmpty)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(40.0),
                                child: Text(
                                  'No contacts found',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Alphabet Sidebar
                    _buildAlphabetSidebar(),
                  ],
                ),
              ),
            ] else ...[
              Expanded(
                child: Center(
                  child: Text(
                    '$_activeTab coming soon',
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(String tabName) {
    final bool isActive = _activeTab == tabName;
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeTab = tabName;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: Text(
              tabName,
              style: TextStyle(
                color: isActive ? primaryNavy : Colors.grey,
                fontWeight: isActive ? FontWeight.w800 : FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
          if (isActive)
            Container(height: 3, width: 80, color: primaryNavy)
          else
            const SizedBox(height: 3),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildContactTile(String name) {
    return Column(
      children: [
        ListTile(
          title: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              fontSize: 16,
            ),
          ),
          onTap: () => _sendInvite(name),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 4,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Divider(height: 1, thickness: 0.5, color: Color(0xFFF0F0F0)),
        ),
      ],
    );
  }

  Widget _buildAlphabetSidebar() {
    final letters = [
      '♥',
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z',
      '#',
    ];

    return Padding(
      padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: letters.map((char) {
          final isHeart = char == '♥';
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: Text(
              char,
              style: TextStyle(
                color: isHeart ? Colors.red : Colors.grey[600],
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
