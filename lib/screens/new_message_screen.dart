import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class NewMessageScreen extends StatefulWidget {
  const NewMessageScreen({super.key});

  @override
  State<NewMessageScreen> createState() => _NewMessageScreenState();
}

class _NewMessageScreenState extends State<NewMessageScreen> {
  String _selectedMessageType = 'General';
  String _visibilityStatus = 'Open';
  String? _attachedImagePath;

  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();

  final List<String> _messageTypes = [
    'General',
    'Job',
    'Property',
    'Commercial',
    'Death / Obituary',
    'Event',
    'Business',
    'Matrimonial',
    'Seva / Support',
    'Other',
  ];

  @override
  void dispose() {
    _detailsController.dispose();
    _whatsappController.dispose();
    super.dispose();
  }

  Future<void> _pickAttachmentImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _attachedImagePath = image.path;
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void _sendMessage() {
    final lang = Provider.of<LanguageProvider>(context, listen: false);
    final bool isGu = lang.currentLanguage == 'gu';

    if (_detailsController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isGu ? 'કૃપા કરીને સંદેશની વિગતો દાખલ કરો!' : 'Please enter message details!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isGu ? 'સંદેશ સફળતાપૂર્વક મોકલવામાં આવ્યો!' : 'Message Posted Successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.of(context).pop();
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
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          isGu ? 'નવો સંદેશ' : 'New Message',
          style: const TextStyle(
            fontFamily: 'Serif',
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Message Type Label & Dropdown
                      _buildLabel(isGu ? 'સંદેશાનો પ્રકાર' : 'Message Type'),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F4FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedMessageType,
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF64748B)),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() {
                                  _selectedMessageType = val;
                                });
                              }
                            },
                            items: _messageTypes.map((type) {
                              return DropdownMenuItem<String>(
                                value: type,
                                child: Text(
                                  _getTypeLabel(type, isGu),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF1E293B),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Message Details Label & Multi-line TextArea
                      _buildLabel(isGu ? 'સંદેશની વિગતો' : 'Message Details'),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _detailsController,
                        maxLines: 7,
                        decoration: InputDecoration(
                          hintText: isGu ? 'સંદેશની સામગ્રી દાખલ કરો' : 'Enter Message Content',
                          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                          fillColor: const Color(0xFFF0F4FF),
                          filled: true,
                          contentPadding: const EdgeInsets.all(16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // WhatsApp Number Label & Input
                      _buildLabel(isGu ? 'વોટ્સએપ નંબર (જરૂરી નથી)' : 'WhatsApp Number (Not Necessary)'),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _whatsappController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.chat_bubble_outline,
                            color: Color(0xFF64748B),
                            size: 20,
                          ),
                          hintText: '+1 234 567 890',
                          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                          fillColor: const Color(0xFFF0F4FF),
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Action Footer Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left Visibility Dropdown (Open ˅)
                  PopupMenuButton<String>(
                    onSelected: (val) {
                      setState(() {
                        _visibilityStatus = val;
                      });
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(value: 'Open', child: Text(isGu ? 'જાહેર' : 'Open')),
                      PopupMenuItem(value: 'Members Only', child: Text(isGu ? 'માત્ર સભ્યો' : 'Members Only')),
                      PopupMenuItem(value: 'Private', child: Text(isGu ? 'ખાનગી' : 'Private')),
                    ],
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F4FF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.verified_user_outlined, size: 16, color: Color(0xFF1E293B)),
                          const SizedBox(width: 6),
                          Text(
                            _getVisibilityLabel(_visibilityStatus, isGu),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.keyboard_arrow_down, size: 18, color: Color(0xFF1E293B)),
                        ],
                      ),
                    ),
                  ),

                  // Middle Attachment Icon Box
                  InkWell(
                    onTap: _pickAttachmentImage,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                            image: _attachedImagePath != null
                                ? DecorationImage(
                                    image: FileImage(File(_attachedImagePath!)),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: _attachedImagePath == null
                              ? const Icon(Icons.image_outlined, color: Color(0xFF64748B), size: 24)
                              : null,
                        ),
                        Positioned(
                          top: -4,
                          right: -4,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: const BoxDecoration(
                              color: Color(0xFFEAB308),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.add, color: Colors.black, size: 14),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Right Send Button
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0F172A),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontFamily: 'Serif',
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E293B),
      ),
    );
  }

  String _getTypeLabel(String type, bool isGu) {
    if (!isGu) return type;
    switch (type) {
      case 'General':
        return 'સામાન્ય';
      case 'Job':
        return 'નોકરી';
      case 'Property':
        return 'મિલકત';
      case 'Commercial':
        return 'વ્યાવસાયિક';
      case 'Death / Obituary':
        return 'અવસાન / શ્રદ્ધાંજલિ';
      case 'Event':
        return 'ઇવેન્ટ';
      case 'Business':
        return 'વ્યાપાર';
      case 'Matrimonial':
        return 'લગ્ન';
      case 'Seva / Support':
        return 'સેવા / સહાય';
      default:
        return 'અન્ય';
    }
  }

  String _getVisibilityLabel(String status, bool isGu) {
    if (!isGu) return status;
    switch (status) {
      case 'Open':
        return 'જાહેર';
      case 'Members Only':
        return 'માત્ર સભ્યો';
      case 'Private':
        return 'ખાનગી';
      default:
        return status;
    }
  }
}
