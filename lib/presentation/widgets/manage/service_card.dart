import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';
import '../../../data/models/service_model.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const ServiceCard({Key? key, required this.service, this.onDelete, this.onEdit})
    : super(key: key);

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Delete Service',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: Text(
            'Are you sure you want to delete "${service.name}"? ',
            style: const TextStyle(fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFF757575),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                onDelete?.call(); // Call the delete callback
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF5350),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Delete',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Service Image Thumbnail
            if (service.imagePath != null || service.imageUrl != null)
              Container(
                margin: const EdgeInsets.only(right: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: service.imagePath != null
                      ? (kIsWeb
                          ? Image.network(
                              service.imagePath!,
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(service.imagePath!),
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ))
                      : Image.network(
                          service.imageUrl!,
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.image_not_supported,
                                size: 24,
                                color: Color(0xFF9E9E9E),
                              ),
                            );
                          },
                        ),
                ),
              ),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    service.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Category and Price
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          service.category,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF616161),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Rs. ${service.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0BA5E9),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Duration and Gender
                  Row(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 12,
                            color: Color(0xFF757575),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${service.duration} min',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF757575),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE1BEE7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          service.gender,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF7B1FA2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Menu button - centered
            PopupMenuButton<String>(
              icon: const Icon(
                Icons.more_vert,
                size: 20,
                color: Color(0xFF757575),
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              onSelected: (value) {
                if (value == 'edit') {
                  onEdit?.call();
                } else if (value == 'delete') {
                  _showDeleteConfirmation(context);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        size: 18,
                        color: Color(0xFF1A1A1A),
                      ),
                      SizedBox(width: 8),
                      Text('Edit'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete_outline,
                        size: 18,
                        color: Color(0xFFEF5350),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Delete',
                        style: TextStyle(color: Color(0xFFEF5350)),
                      ),
                    ],
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
