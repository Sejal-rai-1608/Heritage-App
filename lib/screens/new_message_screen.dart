import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'image_picker_dialog.dart';

class NewMessageScreen extends StatefulWidget {
  final String? initialType;
  const NewMessageScreen({super.key, this.initialType});

  @override
  State<NewMessageScreen> createState() => _NewMessageScreenState();
}

class _NewMessageScreenState extends State<NewMessageScreen> {
  static const Color primaryNavy = Color(0xFF00005C);

  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();

  String? _selectedImagePath;

  String _selectedMessageType = 'General';
  String _messageVisibility = 'Open';

  final List<String> _messageTypes = [
    'Job',
    'Property',
    'Commercial',
    'Death',
    'New Born',
    'New Marriage',
    'Engagement',
    'Social',
    'Regional',
    'Buy-Sell',
    'Congratulation',
    'Thank you',
    'Condolence',
    'Birthday',
    'Marriage Anniversary',
    'Punya Tithi',
    'Academic',
    'Medical',
    'General',
    'Donation',
    'Samuhik Vivah',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialType != null &&
        _messageTypes.contains(widget.initialType)) {
      _selectedMessageType = widget.initialType!;
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    _whatsappController.dispose();
    super.dispose();
  }

  void _onSendMessage() {
    final content = _contentController.text.trim();
    final whatsapp = _whatsappController.text.trim();

    if (content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter message content')),
      );
      return;
    }

    final lang = Provider.of<LanguageProvider>(context, listen: false);
    lang.addPost(
      _selectedMessageType,
      content,
      whatsapp,
      imagePath: _selectedImagePath,
    );

    final bool isDeathRelated = [
      'Death',
      'Condolence',
      'Punya Tithi',
    ].contains(_selectedMessageType);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(Icons.hourglass_bottom, color: Colors.blue, size: 28),
              SizedBox(width: 8),
              Text(
                'Verification Pending',
                style: TextStyle(
                  color: primaryNavy,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Once approved, this message will be publicly visible.',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              if (isDeathRelated) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: const Text(
                    'Note: Death-related announcements are prioritized and approved swiftly.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Pop dialog
                Navigator.pop(context); // Pop screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryNavy,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.white,
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
    final bool isDeathRelated = [
      'Death',
      'Condolence',
      'Punya Tithi',
    ].contains(_selectedMessageType);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryNavy,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'New Message',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Message Type dropdown
                      const Text(
                        'Message Type',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedMessageType,
                            isExpanded: true,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            ),
                            items: _messageTypes.map((type) {
                              return DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() {
                                  _selectedMessageType = val;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Message Details field
                      const Text(
                        'Message Details',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _contentController,
                        maxLines: 6,
                        decoration: InputDecoration(
                          hintText: 'Enter Message Content',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 15,
                          ),
                          contentPadding: const EdgeInsets.all(16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: primaryNavy,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // WhatsApp Number field
                      const Text(
                        'WhatsApp Number(Not Necessary)',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _whatsappController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Enter WhatsApp Number (optional)',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 15,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: primaryNavy,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Notice warning at bottom for death posts
                      if (isDeathRelated) ...[
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red.shade100),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.priority_high_rounded,
                                color: Colors.red.shade700,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Death-related announcements will be approved first and quickly.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.red.shade900,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      // Cropped image preview
                      if (_selectedImagePath != null) ...[
                        const SizedBox(height: 24),
                        const Text(
                          'Selected Image',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Stack(
                          children: [
                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  _selectedImagePath!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Center(
                                        child: Icon(
                                          Icons.broken_image,
                                          size: 48,
                                          color: Colors.grey,
                                        ),
                                      ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedImagePath = null;
                                  });
                                },
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: Colors.black.withValues(
                                    alpha: 0.6,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // Bottom Toolbar (Shield, Open Dropdown, Gallery Add, Send Button)
              const Divider(height: 32),
              Row(
                children: [
                  const Icon(
                    Icons.shield_outlined,
                    color: primaryNavy,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 100,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _messageVisibility,
                        icon: const Icon(Icons.keyboard_arrow_down, size: 18),
                        items: ['Open', 'Closed'].map((v) {
                          return DropdownMenuItem(
                            value: v,
                            child: Text(
                              v,
                              style: const TextStyle(fontSize: 13),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _messageVisibility = val;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Gallery + icon
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
                          _selectedImagePath = result;
                        });
                      }
                    },
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Icon(
                            Icons.image_outlined,
                            color: Colors.grey.shade700,
                            size: 24,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor: _selectedImagePath != null
                                ? Colors.green
                                : Colors.blue,
                            child: Icon(
                              _selectedImagePath != null
                                  ? Icons.check
                                  : Icons.add,
                              size: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Send circle button
                  GestureDetector(
                    onTap: _onSendMessage,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: primaryNavy,
                        shape: BoxShape.circle,
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
            ],
          ),
        ),
      ),
    );
  }
}
