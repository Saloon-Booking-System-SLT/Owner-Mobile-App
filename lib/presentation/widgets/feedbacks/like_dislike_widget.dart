import 'package:flutter/material.dart';

class LikeDislikeWidget extends StatelessWidget {
  final int likeCount;
  final bool isLiked;
  final VoidCallback onLikePressed;
  final VoidCallback onDislikePressed;

  const LikeDislikeWidget({
    Key? key,
    required this.likeCount,
    required this.isLiked,
    required this.onLikePressed,
    required this.onDislikePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Like Button
        InkWell(
          onTap: onLikePressed,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: Row(
              children: [
                Icon(
                  isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                  color: isLiked ? const Color(0xFF1565C0) : Colors.grey.shade600,
                  size: 22,
                ),
                const SizedBox(width: 6),
                Text(
                  '$likeCount',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isLiked ? const Color(0xFF1565C0) : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20),
        // Dislike Button
        InkWell(
          onTap: onDislikePressed,
          borderRadius: BorderRadius.circular(8),
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.thumb_down_outlined,
              color: Colors.grey,
              size: 22,
            ),
          ),
        ),
      ],
    );
  }
}
