import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class WebMapPicker extends StatelessWidget {
  final Function(String) onLocationSelected;
  final String? initialAddress;

  const WebMapPicker({
    super.key,
    required this.onLocationSelected,
    this.initialAddress,
  });

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      // This should never be called on non-web platforms
      return Container(
        height: 300,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: const Center(
          child: Text(
            'Use mobile app for map functionality',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.location_on,
            color: Color(0xFF1565C0),
            size: 48,
          ),
          const SizedBox(height: 16),
          const Text(
            'Web Map Placeholder',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Map functionality is available on mobile devices',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter salon address manually',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1.0,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Color(0xFF1565C0)),
                  onPressed: () {
                    // For web, you could integrate with a web map API here
                    onLocationSelected('Manual address entry');
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
