// import 'package:flutter/material.dart';
// import '../../widgets/feedbacks/user_profile_widget.dart';
// import '../../widgets/feedbacks/star_rating_widget.dart';
// import '../../widgets/feedbacks/like_dislike_widget.dart';
// import '../../widgets/feedbacks/reply_text_field_widget.dart';
// import '../../widgets/feedbacks/send_reply_button_widget.dart';
//
// class ReplyToFeedbackPage extends StatefulWidget {
//   const ReplyToFeedbackPage({Key? key}) : super(key: key);
//
//   @override
//   State<ReplyToFeedbackPage> createState() => _ReplyToFeedbackPageState();
// }
//
// class _ReplyToFeedbackPageState extends State<ReplyToFeedbackPage> {
//   final TextEditingController _replyController = TextEditingController();
//   bool _isSubmitting = false;
//   int likeCount = 2;
//   bool isLiked = false;
//
//   @override
//   void dispose() {
//     _replyController.dispose();
//     super.dispose();
//   }
//
//   void _toggleLike() {
//     setState(() {
//       if (isLiked) {
//         likeCount--;
//         isLiked = false;
//       } else {
//         likeCount++;
//         isLiked = true;
//       }
//     });
//   }
//
//   void _showSuccessSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.green,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         margin: const EdgeInsets.all(16),
//       ),
//     );
//   }
//
//   void _showErrorSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         margin: const EdgeInsets.all(16),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
//         ),
//         title: const Text(
//           'Feedbacks',
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 32),
//
//                 const UserProfileWidget(
//                   name: 'Sophia Bennett',
//                   email: 'sophiabennett@gmail.com',
//                 ),
//
//                 const SizedBox(height: 28),
//
//                 // Star Rating
//                 const StarRatingWidget(rating: 5.0),
//
//                 const SizedBox(height: 20),
//
//                 // Review Text
//                 const Text(
//                   'The service was excellent, and the staff was very friendly. I especially loved the ambiance of the salon. Will definitely come back!',
//                   style: TextStyle(
//                     fontSize: 15,
//                     color: Colors.black87,
//                     height: 1.6,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // Like and Dislike Section
//                 LikeDislikeWidget(
//                   likeCount: likeCount,
//                   isLiked: isLiked,
//                   onLikePressed: _toggleLike,
//                   onDislikePressed: () {
//                     // Dislike action
//                   },
//                 ),
//
//                 const SizedBox(height: 28),
//
//                 // Reply Text Field
//                 ReplyTextFieldWidget(controller: _replyController),
//
//                 const SizedBox(height: 24),
//
//                 // Send Reply Button
//                 SendReplyButtonWidget(
//                   isSubmitting: _isSubmitting,
//                   onPressed: () async {
//                     if (_replyController.text.trim().isEmpty) {
//                       _showErrorSnackBar('Please write a reply');
//                       return;
//                     }
//
//                     setState(() => _isSubmitting = true);
//
//                     // Simulate sending reply
//                     await Future.delayed(const Duration(milliseconds: 800));
//
//                     if (!mounted) return;
//
//                     setState(() => _isSubmitting = false);
//
//                     _showSuccessSnackBar('Reply sent successfully!');
//
//                     // Clear the text field
//                     _replyController.clear();
//
//                     // Navigate back after a short delay
//                     Future.delayed(const Duration(milliseconds: 500), () {
//                       if (mounted) {
//                         Navigator.pop(context);
//                       }
//                     });
//                   },
//                 ),
//
//                 const SizedBox(height: 32),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../widgets/feedbacks/user_profile_widget.dart';
import '../../widgets/feedbacks/star_rating_widget.dart';
import '../../widgets/feedbacks/like_dislike_widget.dart';
import '../../widgets/feedbacks/reply_text_field_widget.dart';
import '../../widgets/feedbacks/send_reply_button_widget.dart';

class ReplyToFeedbackPage extends StatefulWidget {
  final Map<String, dynamic> feedback;

  const ReplyToFeedbackPage({
    Key? key,
    required this.feedback,
  }) : super(key: key);

  @override
  State<ReplyToFeedbackPage> createState() => _ReplyToFeedbackPageState();
}

class _ReplyToFeedbackPageState extends State<ReplyToFeedbackPage> {
  final TextEditingController _replyController = TextEditingController();
  bool _isSubmitting = false;
  int likeCount = 0;
  bool isLiked = false;

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      if (isLiked) {
        likeCount--;
        isLiked = false;
      } else {
        likeCount++;
        isLiked = true;
      }
    });
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  Future<void> _sendReply() async {
    if (_replyController.text.trim().isEmpty) {
      _showErrorSnackBar('Please write a reply');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      // TODO: Implement actual API call to send reply
      // For now, simulating the API call
      await Future.delayed(const Duration(milliseconds: 800));

      // Example API call structure:
      // final response = await ApiService.post(
      //   '/feedback/reply',
      //   {
      //     'feedbackId': widget.feedback['id'],
      //     'reply': _replyController.text.trim(),
      //   },
      // );

      if (!mounted) return;

      setState(() => _isSubmitting = false);

      _showSuccessSnackBar('Reply sent successfully!');

      // Clear the text field
      _replyController.clear();

      // Navigate back after a short delay
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          Navigator.pop(context, true); // Return true to indicate success
        }
      });
    } catch (e) {
      setState(() => _isSubmitting = false);
      _showErrorSnackBar('Failed to send reply: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Extract data from feedback object
    final String customerName = widget.feedback['name'] ?? 'Anonymous';
    final String userEmail = widget.feedback['userEmail'] ?? 'N/A';
    final double rating = (widget.feedback['rating'] as num?)?.toDouble() ?? 0.0;
    final String comment = widget.feedback['review'] ?? 'No comment provided';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
        ),
        title: const Text(
          'Reply to Feedback',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),

                UserProfileWidget(
                  name: customerName,
                  email: userEmail,
                ),

                const SizedBox(height: 28),

                // Star Rating
                StarRatingWidget(rating: rating),

                const SizedBox(height: 20),

                // Review Text
                Text(
                  comment,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    height: 1.6,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 20),

                // Like and Dislike Section
                LikeDislikeWidget(
                  likeCount: likeCount,
                  isLiked: isLiked,
                  onLikePressed: _toggleLike,
                  onDislikePressed: () {
                    // Dislike action
                  },
                ),

                const SizedBox(height: 28),

                // Reply Text Field
                ReplyTextFieldWidget(controller: _replyController),

                const SizedBox(height: 24),

                // Send Reply Button
                SendReplyButtonWidget(
                  isSubmitting: _isSubmitting,
                  onPressed: _sendReply,
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}