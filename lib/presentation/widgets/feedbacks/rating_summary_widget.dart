import 'package:flutter/material.dart';

class RatingSummaryWidget extends StatelessWidget {
  final double overallRating;
  final int reviewCount;
  final List<Map<String, dynamic>> ratings;

  const RatingSummaryWidget({
    Key? key,
    required this.overallRating,
    required this.reviewCount,
    required this.ratings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side - Overall Rating
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  overallRating.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(overallRating.floor(), (index) => const Icon(
                      Icons.star,
                      color: Color(0xFFFFA726),
                      size: 20,
                    )),
                    if (overallRating % 1 != 0)
                      const Icon(
                        Icons.star_half,
                        color: Color(0xFFFFA726),
                        size: 20,
                      ),
                    ...List.generate(5 - overallRating.ceil(), (index) => const Icon(
                      Icons.star_border,
                      color: Color(0xFFFFA726),
                      size: 20,
                    )),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '$reviewCount review${reviewCount != 1 ? 's' : ''}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 24),
          
          // Right side - Rating Bars
          Expanded(
            flex: 3,
            child: Column(
              children: ratings.map((rating) => RatingBarWidget(
                stars: rating['stars'],
                percentage: rating['percentage'],
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class RatingBarWidget extends StatelessWidget {
  final int stars;
  final int percentage;

  const RatingBarWidget({
    Key? key,
    required this.stars,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$stars',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: percentage / 100,
                backgroundColor: Colors.grey.shade200,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.black87),
                minHeight: 8,
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 32,
            child: Text(
              '$percentage%',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
