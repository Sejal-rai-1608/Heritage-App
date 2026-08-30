import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
    if (_detailsController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter message details!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Message Posted Successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'New Message',
          style: TextStyle(
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
                      _buildLabel('Message Type'),
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
                                  type,
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
                      _buildLabel('Message Details'),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _detailsController,
                        maxLines: 7,
                        decoration: InputDecoration(
                          hintText: 'Enter Message Content',
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
                      _buildLabel('WhatsApp Number (Not Necessary)'),
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
                      const PopupMenuItem(value: 'Open', child: Text('Open')),
                      const PopupMenuItem(value: 'Members Only', child: Text('Members Only')),
                      const PopupMenuItem(value: 'Private', child: Text('Private')),
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
                            _visibilityStatus,
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

                  // Middle Attachment Icon Box (Image picker with gold plus badge)
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
}
