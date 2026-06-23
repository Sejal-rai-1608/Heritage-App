import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class SubCommunityScreen extends StatefulWidget {
  final String communityName;
  const SubCommunityScreen({super.key, required this.communityName});

  @override
  State<SubCommunityScreen> createState() => _SubCommunityScreenState();
}

class _SubCommunityScreenState extends State<SubCommunityScreen> {
  static const Color primaryNavy = Color(0xFF00005C);
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final Map<String, List<String>> _subCommunities = {
    'Gujarati': [
      'Leva Patel',
      'Kadva Patel',
      'Charotar Patel',
      'Anjana Patel',
      'Matiya Patel',
      'Kutch Kadva Patel',
      'Bhakta Patel',
    ],
  };

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final subs = _subCommunities[widget.communityName] ?? [];

    final filtered = subs
        .where((s) => s.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryNavy),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          lang.getText('community_directory'),
          style: const TextStyle(
            color: primaryNavy,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.mic, color: primaryNavy),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: primaryNavy.withValues(alpha: 0.2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
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
                  suffixIcon: const Icon(Icons.mic, color: Colors.red),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14,
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
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${widget.communityName} >',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final sub = filtered[index];
                return Card(
                  color: Colors.white,
                  elevation: 0.5,
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  child: ListTile(
                    title: Text(
                      sub,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      lang.setSelectedCommunity(sub);
                      Navigator.of(context)
                        ..pop() // pop SubCommunityScreen
                        ..pop(); // pop CommunityDirectoryScreen
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
