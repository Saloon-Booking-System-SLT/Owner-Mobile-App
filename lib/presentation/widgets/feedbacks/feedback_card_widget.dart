import 'package:flutter/material.dart';

class FeedbackCardWidget extends StatelessWidget {
  final Map<String, dynamic> feedback;
  final VoidCallback onViewDetails;
  final VoidCallback onReply;

  const FeedbackCardWidget({
    Key? key,
    required this.feedback,
    required this.onViewDetails,
    required this.onReply,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info Row
          UserInfoRow(feedback: feedback),
          
          const SizedBox(height: 16),
          
          // Review Text
          ReviewText(review: feedback['review']),
          
          const SizedBox(height: 20),
          
          // Action Buttons
          ActionButtons(
            onViewDetails: onViewDetails,
            onReply: onReply,
          ),
        ],
      ),
    );
  }
}

class UserInfoRow extends StatelessWidget {
  final Map<String, dynamic> feedback;

  const UserInfoRow({Key? key, required this.feedback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar
        UserAvatar(),
        const SizedBox(width: 16),
        // User Details
        Expanded(
          child: UserDetails(
            name: feedback['name'],
            service: feedback['service'],
            date: feedback['date'],
          ),
        ),
      ],
    );
  }
}

class UserAvatar extends StatelessWidget {
  const UserAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.person_outline,
        color: Colors.grey.shade400,
        size: 28,
      ),
    );
  }
}

class UserDetails extends StatelessWidget {
  final String name;
  final String service;
  final String date;

  const UserDetails({
    Key? key,
    required this.name,
    required this.service,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          service,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          date,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class ReviewText extends StatelessWidget {
  final String review;

  const ReviewText({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      review,
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey.shade700,
        height: 1.5,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  final VoidCallback onViewDetails;
  final VoidCallback onReply;

  const ActionButtons({
    Key? key,
    required this.onViewDetails,
    required this.onReply,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 44,
            child: ElevatedButton(
              onPressed: onViewDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1565C0),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text(
                'View Details',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 44,
            child: OutlinedButton(
              onPressed: onReply,
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFFF5F5F5),
                foregroundColor: Colors.black87,
                side: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Reply to Feedback',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
