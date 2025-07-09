import 'package:flutter/material.dart';

class ImageSourceDialog extends StatelessWidget {
  final VoidCallback onCameraSelected;
  final VoidCallback onGallerySelected;

  const ImageSourceDialog({
    super.key,
    required this.onCameraSelected,
    required this.onGallerySelected,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Seleccionar fuente'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Cámara'),
            onTap: () {
              Navigator.of(context).pop();
              onCameraSelected();
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Galería'),
            onTap: () {
              Navigator.of(context).pop();
              onGallerySelected();
            },
          ),
        ],
      ),
    );
  }

  static Future<void> show({
    required BuildContext context,
    required VoidCallback onCameraSelected,
    required VoidCallback onGallerySelected,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return ImageSourceDialog(
          onCameraSelected: onCameraSelected,
          onGallerySelected: onGallerySelected,
        );
      },
    );
  }
}
