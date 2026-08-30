import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': '1',
      'title': 'Grand Mass Marriage 2024',
      'titleGu': 'સમૂહ લગ્ન ૨૦૨૪',
      'message': 'Registration for couples is now open. Early bird registration ends soon.',
      'messageGu': 'યુગલો માટે નોંધણી હવે ખુલ્લી છે. વહેલા નોંધણી ટૂંક સમયમાં સમાપ્ત થાય છે.',
      'time': '2 hours ago',
      'timeGu': '૨ કલાક પહેલાં',
      'icon': Icons.favorite_rounded,
      'color': const Color(0xFFDC2626),
      'isRead': false,
    },
    {
      'id': '2',
      'title': 'Community Donation Update',
      'titleGu': 'સમુદાય દાન અપડેટ',
      'message': 'Village Primary School Renovation cause reached 45% of its funding goal!',
      'messageGu': 'ગામડાની પ્રાથમિક શાળાનું નવીનીકરણ ૪૫% લક્ષ્ય પર પહોંચ્યું!',
      'time': '5 hours ago',
      'timeGu': '૫ કલાક પહેલાં',
      'icon': Icons.volunteer_activism_rounded,
      'color': const Color(0xFFE5A93C),
      'isRead': false,
    },
    {
      'id': '3',
      'title': 'New Directory Members',
      'titleGu': 'નવા ડિરેક્ટરી સભ્યો',
      'message': '5 new verified business members added to Ahmedabad directory.',
      'messageGu': 'અમદાવાદ ડિરેક્ટરીમાં ૫ નવા ચકાસાયેલ સભ્યો ઉમેરાયા.',
      'time': '1 day ago',
      'timeGu': '૧ દિવસ પહેલાં',
      'icon': Icons.storefront_rounded,
      'color': const Color(0xFF2563EB),
      'isRead': true,
    },
    {
      'id': '4',
      'title': 'Profile Verification Reminder',
      'titleGu': 'પ્રોફાઇલ ચકાસણી રીમાઇન્ડર',
      'message': 'Complete your full registration details to unlock directory access and matrimony.',
      'messageGu': 'ડિરેક્ટરી અને લગ્ન સુવિધા અનલૉક કરવા માટે પ્રોફાઇલ પૂર્ણ કરો.',
      'time': '2 days ago',
      'timeGu': '૨ દિવસ પહેલાં',
      'icon': Icons.assignment_ind_rounded,
      'color': const Color(0xFF7C3AED),
      'isRead': true,
    },
    {
      'id': '5',
      'title': 'Swajan App Support',
      'titleGu': 'સ્વજન એપ સપોર્ટ',
      'message': 'Welcome to Swajan App! Connect with your community members.',
      'messageGu': 'સ્વજન એપમાં આપનું સ્વાગત છે! તમારા સમુદાયના સભ્યો સાથે જોડાઓ.',
      'time': '3 days ago',
      'timeGu': '૩ દિવસ પહેલાં',
      'icon': Icons.verified_user_rounded,
      'color': const Color(0xFF16A34A),
      'isRead': true,
    },
  ];

  void _markAllAsRead(bool isGu) {
    setState(() {
      for (var n in _notifications) {
        n['isRead'] = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isGu ? 'બધી સૂચનાઓ વંચાઈ ગઈ તરીકે ચિહ્નિત થઈ' : 'All notifications marked as read'),
        backgroundColor: const Color(0xFF1E232D),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final bool isGu = lang.currentLanguage == 'gu';

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E232D)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          isGu ? 'સૂચનાઓ' : 'Notifications',
          style: const TextStyle(
            fontFamily: 'Serif',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E232D),
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => _markAllAsRead(isGu),
            child: Text(
              isGu ? 'બધા વાંચો' : 'Read All',
              style: const TextStyle(
                color: Color(0xFFC68A00),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isGu ? 'કોઈ સૂચનાઓ નથી' : 'No Notifications',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E232D),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    isGu ? 'તમે બધું જોયું છે!' : 'You are all caught up!',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final item = _notifications[index];
                final bool isRead = item['isRead'] as bool;
                final String itemTitle = isGu ? (item['titleGu'] ?? item['title']) : item['title'];
                final String itemMessage = isGu ? (item['messageGu'] ?? item['message']) : item['message'];
                final String itemTime = isGu ? (item['timeGu'] ?? item['time']) : item['time'];

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: isRead ? Colors.white : const Color(0xFFFFFDF5),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isRead ? Colors.grey.shade200 : const Color(0xFFF3D276),
                      width: isRead ? 1.0 : 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: (item['color'] as Color).withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        color: item['color'] as Color,
                        size: 22,
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            itemTitle,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: isRead ? FontWeight.w700 : FontWeight.w900,
                              color: const Color(0xFF1E232D),
                            ),
                          ),
                        ),
                        if (!isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE5A93C),
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          itemMessage,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF5A6270),
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          itemTime,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        item['isRead'] = true;
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}
