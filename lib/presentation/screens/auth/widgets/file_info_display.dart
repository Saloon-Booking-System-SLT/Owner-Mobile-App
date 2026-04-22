import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class FileInfoDisplay extends StatelessWidget {
  final XFile? selectedImage;
  final VoidCallback? onChooseFile;

  const FileInfoDisplay({
    super.key,
    required this.selectedImage,
    this.onChooseFile,
  });

  String _getFileName() {
    if (selectedImage == null) return 'No file chosen';
    return selectedImage!.name;
  }

  String _getFileSize() {
    // For simplicity and web compatibility (length() is async), 
    // we omit the size display here or just return empty.
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onChooseFile,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: const Text(
                  'Choose File',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getFileName(),
                    style: TextStyle(
                      fontSize: 14,
                      color: selectedImage != null
                          ? Colors.black87
                          : Colors.grey.shade600,
                      fontWeight: selectedImage != null
                          ? FontWeight.w500
                          : FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  if (selectedImage != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      _getFileSize(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}