import 'package:flutter/material.dart';

class StarRatingWidget extends StatelessWidget {
  final double rating;
  final double size;

  const StarRatingWidget({
    Key? key,
    required this.rating,
    this.size = 28,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Icon(
            index < rating.floor()
                ? Icons.star
                : index == rating.floor() && rating % 1 != 0
                    ? Icons.star_half
                    : Icons.star_border,
            color: Colors.black87,
            size: size,
          ),
        ),
      ),
    );
  }
}

class StarRatingDisplayWidget extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const StarRatingDisplayWidget({
    Key? key,
    required this.rating,
    required this.reviewCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(rating.floor(), (index) => const Icon(
          Icons.star,
          color: Color(0xFFFFA726),
          size: 20,
        )),
        if (rating % 1 != 0)
          const Icon(
            Icons.star_half,
            color: Color(0xFFFFA726),
            size: 20,
          ),
        ...List.generate(5 - rating.ceil(), (index) => const Icon(
          Icons.star_border,
          color: Color(0xFFFFA726),
          size: 20,
        )),
      ],
    );
  }
}
