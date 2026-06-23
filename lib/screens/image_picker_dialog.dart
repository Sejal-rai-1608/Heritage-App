import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePickerDialog extends StatefulWidget {
  final bool
  isProfilePhoto; // true for profile, false for post messages/businesses
  const CustomImagePickerDialog({super.key, this.isProfilePhoto = true});

  @override
  State<CustomImagePickerDialog> createState() =>
      _CustomImagePickerDialogState();
}

class _CustomImagePickerDialogState extends State<CustomImagePickerDialog> {
  final ImagePicker _picker = ImagePicker();

  // Premium dummy profile photos (Unsplash)
  final List<String> _profilePresets = [
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200',
    'https://images.unsplash.com/photo-1628157582853-a796fa650a6a?w=200',
    'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200',
  ];

  // Premium dummy post/announcement/business photos
  final List<String> _postPresets = [
    'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=300', // Food/Vivaah
    'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=300', // Meeting/Business
    'https://images.unsplash.com/photo-1582213782179-e0d53f98f2ca?w=300', // Community charity
    'https://images.unsplash.com/photo-1528605248644-14dd04022da1?w=300', // Celebration/Events
    'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=300', // Shop facade
    'https://images.unsplash.com/photo-1497366216548-37526070297c?w=300', // Modern office
  ];

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1080,
        maxHeight: 1080,
      );
      if (image != null && mounted) {
        _selectImage(image.path);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  void _selectImage(String path) async {
    // Open crop dialog after selection
    final croppedUrl = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          CustomCropDialog(imageUrl: path, isCircle: widget.isProfilePhoto),
    );

    if (croppedUrl != null && mounted) {
      Navigator.pop(context, croppedUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryNavy = Color(0xFF00005C);
    final presets = widget.isProfilePhoto ? _profilePresets : _postPresets;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.isProfilePhoto
                        ? 'Upload Profile Photo'
                        : 'Upload Image',
                    style: const TextStyle(
                      color: primaryNavy,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Local storage upload buttons
              ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.gallery),
                icon: const Icon(Icons.photo_library, color: Colors.white),
                label: const Text(
                  'Choose from Gallery',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryNavy,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => _pickImage(ImageSource.camera),
                icon: const Icon(Icons.camera_alt, color: primaryNavy),
                label: const Text(
                  'Take Photo with Camera',
                  style: TextStyle(
                    color: primaryNavy,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: primaryNavy, width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'OR CHOOSE TEMPLATE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 16),

              // Presets Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: presets.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _selectImage(presets[index]),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          presets[index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, err, stack) => const Center(
                            child: Icon(Icons.broken_image, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCropDialog extends StatefulWidget {
  final String imageUrl; // Can be a local file path or network URL
  final bool isCircle;
  const CustomCropDialog({
    super.key,
    required this.imageUrl,
    this.isCircle = true,
  });

  @override
  State<CustomCropDialog> createState() => _CustomCropDialogState();
}

class _CustomCropDialogState extends State<CustomCropDialog> {
  double _zoomScale = 1.0;
  double _rotationAngle = 0.0; // In radians

  final TransformationController _transformationController =
      TransformationController();

  void _rotateImage() {
    setState(() {
      _rotationAngle += 1.5708; // Rotate 90 degrees in radians (PI / 2)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.grey[900], // Dark background for cropper
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Crop & Edit Image',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white70),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Interactive Editor Area
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Panning/Zooming Image
                    Transform.rotate(
                      angle: _rotationAngle,
                      child: InteractiveViewer(
                        transformationController: _transformationController,
                        minScale: 0.5,
                        maxScale: 4.0,
                        onInteractionUpdate: (details) {
                          setState(() {
                            // Sync slider with scale changes
                            _zoomScale = _transformationController.value
                                .getMaxScaleOnAxis();
                          });
                        },
                        child: widget.imageUrl.startsWith('http')
                            ? Image.network(
                                widget.imageUrl,
                                fit: BoxFit.contain,
                                errorBuilder: (c, e, s) => const Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    color: Colors.grey,
                                    size: 48,
                                  ),
                                ),
                              )
                            : Image.file(
                                File(widget.imageUrl),
                                fit: BoxFit.contain,
                                errorBuilder: (c, e, s) => const Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    color: Colors.grey,
                                    size: 48,
                                  ),
                                ),
                              ),
                      ),
                    ),

                    // Crop Frame Overlay
                    IgnorePointer(
                      child: Container(
                        decoration: ShapeDecoration(
                          shape: widget.isCircle
                              ? _CircularOverlayShape(borderColor: Colors.teal)
                              : _SquareOverlayShape(borderColor: Colors.teal),
                        ),
                      ),
                    ),

                    // Guideline Text
                    Positioned(
                      bottom: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: const Text(
                          'Pinch or drag to resize & position',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Editor Controls (Slider for Zoom, Rotate Button)
            Row(
              children: [
                const Icon(Icons.zoom_out, color: Colors.white70, size: 18),
                Expanded(
                  child: Slider(
                    value: _zoomScale.clamp(0.5, 4.0),
                    min: 0.5,
                    max: 4.0,
                    activeColor: Colors.teal,
                    inactiveColor: Colors.white24,
                    onChanged: (val) {
                      setState(() {
                        _zoomScale = val;
                        // Programmatically update transformation matrix
                        final currentMatrix = _transformationController.value;
                        final translation = currentMatrix.getTranslation();
                        final newMatrix = Matrix4.identity()
                          ..translate(translation.x, translation.y)
                          ..scale(_zoomScale);
                        _transformationController.value = newMatrix;
                      });
                    },
                  ),
                ),
                const Icon(Icons.zoom_in, color: Colors.white70, size: 18),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.rotate_right, color: Colors.white),
                  tooltip: 'Rotate 90°',
                  onPressed: _rotateImage,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Bottom Buttons
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Returns the image URL/path
                      Navigator.pop(context, widget.imageUrl);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Crop & Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Custom overlay painter for Circle Profile Photo crop shape
class _CircularOverlayShape extends ShapeBorder {
  final Color borderColor;
  const _CircularOverlayShape({this.borderColor = Colors.teal});

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      Path()..addRect(rect);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final width = rect.width;
    final height = rect.height;
    final radius = (width < height ? width : height) * 0.35;

    // Dark background mask
    final maskPaint = Paint()..color = Colors.black.withValues(alpha: 0.65);
    final circlePath = Path()
      ..addOval(
        Rect.fromCircle(center: Offset(width / 2, height / 2), radius: radius),
      );
    final outerPath = Path()..addRect(rect);
    final clipPath = Path.combine(
      PathOperation.difference,
      outerPath,
      circlePath,
    );
    canvas.drawPath(clipPath, maskPaint);

    // Border line
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(Offset(width / 2, height / 2), radius, borderPaint);
  }

  @override
  ShapeBorder scale(double t) => this;
}

// Custom overlay painter for Square Post Photo crop shape
class _SquareOverlayShape extends ShapeBorder {
  final Color borderColor;
  const _SquareOverlayShape({this.borderColor = Colors.teal});

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      Path()..addRect(rect);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final width = rect.width;
    final height = rect.height;
    final size = (width < height ? width : height) * 0.75;
    final cropRect = Rect.fromCenter(
      center: Offset(width / 2, height / 2),
      width: size,
      height: size,
    );

    // Dark background mask
    final maskPaint = Paint()..color = Colors.black.withValues(alpha: 0.65);
    final squarePath = Path()..addRect(cropRect);
    final outerPath = Path()..addRect(rect);
    final clipPath = Path.combine(
      PathOperation.difference,
      outerPath,
      squarePath,
    );
    canvas.drawPath(clipPath, maskPaint);

    // Border line
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawRect(cropRect, borderPaint);
  }

  @override
  ShapeBorder scale(double t) => this;
}
