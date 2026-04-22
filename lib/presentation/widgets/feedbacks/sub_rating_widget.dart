import 'package:flutter/material.dart';

class SubRatingWidget extends StatelessWidget {
  final String label;
  final double rating;

  const SubRatingWidget({
    Key? key,
    required this.label,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(width: 8),
        const Icon(
          Icons.star,
          color: Color(0xFFFFA726),
          size: 18,
        ),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class SubRatingsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> subRatings;

  const SubRatingsWidget({Key? key, required this.subRatings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: subRatings.map((rating) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: SubRatingWidget(
            label: rating['label'],
            rating: rating['rating'],
          ),
        );
      }).toList(),
    );
  }
}
